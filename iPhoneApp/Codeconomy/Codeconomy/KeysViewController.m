//
//  KeysViewController.m
//  Codeconomy
//
//  Created by Gary on 03/12/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import "KeysViewController.h"
#import "KeysOwnedView.h"
#import "KeysBuyingOptionsView.h"
#import "Util.h"

@interface KeysViewController ()
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) KeysOwnedView *ownedView;
@property (nonatomic, strong) KeysBuyingOptionsView *buyingOptionsView;

@property (nonatomic, strong) UIButton *buy;
@end

@implementation KeysViewController

- (instancetype)initWithUser:(User *)user {
    self = [super init];
    if (self) {
        _user = user;
        
        _ownedView = [[KeysOwnedView alloc] initWithCredits:user.credits];
        _buyingOptionsView = [[KeysBuyingOptionsView alloc] init];
        
        _buy = [[UIButton alloc] init];
        [_buy addTarget:self action:@selector(tapBuy:) forControlEvents:UIControlEventTouchUpInside];
        [_buy setTitle: @"Buy" forState: UIControlStateNormal];
        _buy.titleLabel.font = [UIFont systemFontOfSize:24.0 weight:UIFontWeightRegular];
        _buy.backgroundColor = [[Util sharedManager] colorWithHexString:[Util getBlueColorHex]];
        _buy.layer.cornerRadius = 10;
        _buy.layer.masksToBounds = YES;
        [self.view addSubview:_buy];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[[Util sharedManager] colorWithHexString:[Util getLightGrayColorHex]]];
    
    [self.view addSubview:_ownedView];
    [self.view addSubview:_buyingOptionsView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews {
    [self.buy sizeToFit];
    self.ownedView.frame = CGRectMake(20.0,
                                      self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.frame.size.height + 15.0,
                                      self.view.frame.size.width - 40.0,
                                      12.0 + [self.ownedView getKeysLabelSize].height + 12.0);
    self.buyingOptionsView.frame = CGRectMake(20.0,
                                      self.ownedView.frame.origin.y + self.ownedView.frame.size.height + 8.0,
                                      self.view.frame.size.width - 40.0,
                                      384.0);
    self.buy.frame = CGRectMake(20.0,
                                self.buyingOptionsView.frame.origin.y + self.buyingOptionsView.frame.size.height + 15.0,
                                self.view.frame.size.width - 40.0,
                                40.0);

}

#pragma mark - Listeners

- (void)tapBuy:(UIButton *)sender {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Purchase"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    int keyQuantity = self.buyingOptionsView.getKeyQuantity;
    if (keyQuantity == -1) {
        [alert setMessage:@"You haven't selected how many keys you want to buy!"];
        UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
                                                             return;
                                                         }];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        [alert setMessage:[NSString stringWithFormat:@"Are you sure you want to buy %d🔑?", keyQuantity]];
        
        UIAlertAction* yesAction = [UIAlertAction actionWithTitle:@"Yes"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              User *user = [User currentUser];
                                                              user.credits += keyQuantity;
                                                              [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                                                                  if (succeeded) {
                                                                      [[NSNotificationCenter defaultCenter]
                                                                       postNotificationName:@"reloadUserData"
                                                                       object:self];
                                                                      [self dismissViewControllerAnimated:YES completion:nil];
                                                                  } else {
                                                                      NSLog(@"failed to buy keys");
                                                                  }
                                                              }];
                                                          }];
        UIAlertAction* noAction = [UIAlertAction actionWithTitle:@"No"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action) {}];
        [alert addAction:yesAction];
        [alert addAction:noAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
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
