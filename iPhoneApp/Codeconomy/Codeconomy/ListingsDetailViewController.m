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

@interface ListingsDetailViewController ()
@property (nonatomic, strong) Coupon *couponData;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) ListingHeaderView *headerView;
@property (nonatomic, strong) ListingDetailView *detailView;
@property (nonatomic, strong) ListingTimeCreatedView *createdView;
@property (nonatomic, strong) UIButton *buy;
@end

@implementation ListingsDetailViewController

- (instancetype)initWithCoupon:(Coupon *)couponData {
    self = [super init];
    if (self) {
        _price = [[UILabel alloc] init];
        _price.text = @"36🔑";
        _couponData = couponData;
        _headerView = [[ListingHeaderView alloc] initWithStoreName:_couponData.storeName title:_couponData.title description:_couponData.couponDescription];
        _detailView = [[ListingDetailView alloc] initWithPrice:_couponData.price expirationDate:_couponData.expirationDate category:@"Clothing 👖"];
        _createdView = [[ListingTimeCreatedView alloc] initWithCreatedDate:_couponData.createdDate seller:[NSString stringWithFormat:@"%d", _couponData.sellerId]];
        _buy = [[UIButton alloc] init];
        
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
    [self.buy setTitle: @"Buy" forState: UIControlStateNormal];
    _buy.backgroundColor = [[Util sharedManager] colorWithHexString:@"9FCBFE"];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
