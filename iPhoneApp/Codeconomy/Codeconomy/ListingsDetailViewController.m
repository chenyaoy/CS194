//
//  ListingDetailViewViewController.m
//  Codeconomy
//
//  Created by studio on 2/12/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import "ListingsDetailViewController.h"
#import "ListingHeaderView.h"
#import "ListingDetailView.h"
#import "ListingTimeCreatedView.h"
#import "Util.h"
#import "Coupon.h"
#import "User.h"
#import "Transaction.h"

@interface ListingsDetailViewController ()
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) Coupon *couponData;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) ListingHeaderView *headerView;
@property (nonatomic, strong) ListingDetailView *detailView;
@property (nonatomic, strong) ListingTimeCreatedView *createdView;
@property (nonatomic, strong) UIButton *buy;
@property BOOL userOwns;
@end

@implementation ListingsDetailViewController

- (instancetype)initWithCoupon:(Coupon *)couponData buy:(BOOL)buy user:(User *)user{
    self = [super init];
    if (self) {
        _user = user;
        
        _price = [[UILabel alloc] init];
        _price.text = [NSString stringWithFormat:@"%d🔑", self.user.credits];
        _couponData = couponData;
        _headerView = [[ListingHeaderView alloc] initWithStoreName:_couponData.storeName title:_couponData.couponDescription description:_couponData.additionalInfo];
        _detailView = [[ListingDetailView alloc] initWithPrice:_couponData.price expirationDate:_couponData.expirationDate category:_couponData.category];
//        _createdView = [[ListingTimeCreatedView alloc] initWithCreatedDate:_couponData.createdAt seller:[NSString stringWithFormat:@"%d", _couponData.sellerId]];
        _createdView = [[ListingTimeCreatedView alloc] initWithCreatedDate:_couponData.createdAt seller:_couponData.seller]; // TODO: this should be the seller display name or user name
        _buy = [[UIButton alloc] init];
        _userOwns = !buy;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(reloadUserData:)
                                                     name:@"reloadUserData"
                                                   object:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[Util sharedManager] colorWithHexString:@"F7F7F7"];
    
    [_price sizeToFit];
    [self.view addSubview:_headerView];
    [self.view addSubview:_detailView];
    [self.view addSubview:_createdView];
    [self.view addSubview:_buy];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.price];
    self.navigationItem.rightBarButtonItem = item;
    self.navigationItem.title = @"Code";
    if (_userOwns) {
        [_buy setTitle: @"Delete" forState: UIControlStateNormal];
        _buy.backgroundColor = [[Util sharedManager] colorWithHexString:[Util getRedColorHex]];
        [_buy addTarget:self action:@selector(tapDelete:) forControlEvents:UIControlEventTouchUpInside];
    } else {
        [_buy setTitle: @"Buy" forState: UIControlStateNormal];
        _buy.backgroundColor = [[Util sharedManager] colorWithHexString:[Util getBlueColorHex]];
        [_buy addTarget:self action:@selector(tapBuy:) forControlEvents:UIControlEventTouchUpInside];
    }
    _buy.titleLabel.font = [UIFont systemFontOfSize:30.0f weight:UIFontWeightMedium];
    _buy.layer.cornerRadius = 10;
    _buy.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews {
    self.headerView.frame = CGRectMake(20.0, self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.frame.size.height + 15.0, self.view.frame.size.width - 40.0, 147.0);
    self.detailView.frame = CGRectMake(20.0, self.headerView.frame.origin.y + self.headerView.frame.size.height + 8.0, self.view.frame.size.width - 40.0, 127.0);
    self.createdView.frame = CGRectMake(20.0, self.detailView.frame.origin.y + self.detailView.frame.size.height + 8.0, self.view.frame.size.width - 40.0, 72.0);
    self.buy.frame = CGRectMake(20.0, self.createdView.frame.origin.y + self.createdView.frame.size.height + 25.0, self.view.frame.size.width - 40.0, 50.0);
}

#pragma mark - Helpers

- (void)purchaseCoupon {
    self.couponData.status = 0;
    [self.couponData saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (!succeeded) {
            NSLog(@"%@", error);
        }
    }];
    
    Transaction *transaction = [[Transaction alloc] initWithBuyer:self.user seller:self.couponData.seller.fetchIfNeeded coupon:self.couponData transactionDate:[NSDate date] reviewDescription:nil stars:0];
    [transaction saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (!succeeded) {
            NSLog(@"%@", error);
        }
    }];
    
    self.user.credits -= self.couponData.price;
    [self.user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"reloadUserData"
             object:self];
            User *seller = self.couponData.seller.fetchIfNeeded;
            NSURL *serverAddress = [NSURL URLWithString: [NSString stringWithFormat:@"https://codeconomy-web.herokuapp.com/users/addCredits?username=%@&credits=%d", seller.username, seller.credits]];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setHTTPMethod:@"POST"];
            [request setURL:serverAddress];
            NSError *error = nil;
            NSHTTPURLResponse *responseCode = nil;
            NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
//            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:serverAddress cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
//            [request setHTTPMethod:@"GET"];
//            NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//            [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//                NSLog(@"success");
//            }] resume];
        } else {
            NSLog(@"%@", error);
        }
    }];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)deleteCoupon {
    self.couponData.deleted = true;
    [_couponData saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (!succeeded) {
            NSLog(@"%@", error);
        }
    }];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Listeners

- (void)tapBuy:(UIButton *)sender {
//    int keyDifference = abs([User currentUser].credits - _couponData.price);
    int keyDifference = abs(self.user.credits - _couponData.price);
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Purchase"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    if (keyDifference >= 0) {
        NSString *message = [NSString stringWithFormat:@"This code will cost %d🔑. Are you sure you want to purchase it?", _couponData.price];
        [alert setMessage:message];
        
        UIAlertAction* yesAction = [UIAlertAction actionWithTitle:@"Yes"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              [self purchaseCoupon];
                                                          }];
        UIAlertAction* noAction = [UIAlertAction actionWithTitle:@"No"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action) {}];
        [alert addAction:yesAction];
        [alert addAction:noAction];
    } else {
        NSString *message = [NSString stringWithFormat:@"You do not have enough 🔑 to purchase this code. You need %d more 🔑.", keyDifference];
        [alert setMessage:message];
        UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {}];
        [alert addAction:okAction];
    }
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)tapDelete:(UIButton *)sender {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Delete"
                                                                   message:@"Are you sure you want to delete this listing?"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive
                                                          handler:^(UIAlertAction * action) {
                                                              [self deleteCoupon];
                                                          }];
    UIAlertAction* noAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel
                                                     handler:^(UIAlertAction * action) {}];
    [alert addAction:yesAction];
    [alert addAction:noAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)reloadUserData:(NSNotification *) notification {
    [self.user fetch];
    self.price.text = [NSString stringWithFormat:@"%d🔑", self.user.credits];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
