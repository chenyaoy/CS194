//
//  ListingDetailViewViewController.m
//  Codeconomy
//
//  Created by studio on 2/12/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import "ListingsDetailViewViewController.h"
#import "ListingHeaderView.h"
#import "ListingDetailView.h"
#import "ListingTimeCreatedView.h"
#import "Coupon.h"

@interface ListingsDetailViewViewController ()
@property (nonatomic, strong) Coupon *couponData;
@property (nonatomic, strong) UILabel *credits;
@property (nonatomic, strong) ListingHeaderView *headerView;
@property (nonatomic, strong) ListingDetailView *detailView;
@property (nonatomic, strong) ListingTimeCreatedView *createdView;
@property (nonatomic, strong) UIButton *buy;
@end

@implementation ListingsDetailViewViewController

- (instancetype)initWithCoupon:(Coupon *)couponData {
    self = [super init];
    if (self) {
        _couponData = couponData;
        _credits = [[UILabel alloc] init];
        [self.view addSubview:_credits];
        _headerView = [[ListingHeaderView alloc] initWithStoreName:_couponData.storeName title:_couponData.title description:_couponData.couponDescription];
        [self.view addSubview:_headerView];
        _detailView = [[ListingDetailView alloc] initWithPrice:_couponData.price expirationDate:_couponData.expirationDate category:@"Clothing 👖"];
        [self.view addSubview:_detailView];
        _createdView = [[ListingTimeCreatedView alloc] initWithCreatedDate:_couponData.createdDate seller:[NSString stringWithFormat:@"%d", _couponData.sellerId]];
        [self.view addSubview:_createdView];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews {
    
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
