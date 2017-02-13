//
//  ListingsViewController.m
//  Codeconomy
//
//  Created by studio on 2/12/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import "ListingsViewController.h"
#import "Coupon.h"
#import "Util.h"

@interface ListingsViewController ()
@property (nonatomic, strong) UITableView *listings;
@property (nonatomic, strong) NSMutableArray *allListings;
@end

@implementation ListingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _listings = [[UITableView alloc] init];
    [self.view addSubview:_listings];
    _allListings = [[NSMutableArray alloc] init];
    [self.view setBackgroundColor: [[Util sharedManager] colorWithHexString:@"F7F7F7"]];
    
    [self generateMockData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews {
    self.listings.frame = CGRectMake(20.0, self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.frame.size.height + 15.0, self.view.frame.size.width - 40.0, self.tabBarController.tabBar.frame.origin.y - (self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.frame.size.height + 30.0));
}

- (void)generateMockData {
    Coupon *coupon1 = [[Coupon alloc] initWithCouponId:1 sellerId:1 status:1 price:2 expirationDate:[NSDate date] createdDate:[NSDate date] storeName:@"J.Crew" title:@"30% off ANY ITEM" couponDescription:@"30% off ANY ITEM" code:@"fuckmeinthedick" deleted:0];
    Coupon *coupon2 = [[Coupon alloc] initWithCouponId:1 sellerId:1 status:1 price:2 expirationDate:[NSDate date] createdDate:[NSDate date] storeName:@"J.Crew" title:@"30% off ANY ITEM" couponDescription:@"30% off ANY ITEM" code:@"fuckmeinthedick" deleted:0];
    Coupon *coupon3 = [[Coupon alloc] initWithCouponId:1 sellerId:1 status:1 price:2 expirationDate:[NSDate date] createdDate:[NSDate date] storeName:@"J.Crew" title:@"30% off ANY ITEM" couponDescription:@"30% off ANY ITEM" code:@"fuckmeinthedick" deleted:0];
    Coupon *coupon4 = [[Coupon alloc] initWithCouponId:1 sellerId:1 status:1 price:2 expirationDate:[NSDate date] createdDate:[NSDate date] storeName:@"J.Crew" title:@"30% off ANY ITEM" couponDescription:@"30% off ANY ITEM" code:@"fuckmeinthedick" deleted:0];
    Coupon *coupon5 = [[Coupon alloc] initWithCouponId:1 sellerId:1 status:1 price:2 expirationDate:[NSDate date] createdDate:[NSDate date] storeName:@"J.Crew" title:@"30% off ANY ITEM" couponDescription:@"30% off ANY ITEM" code:@"fuckmeinthedick" deleted:0];
    Coupon *coupon6 = [[Coupon alloc] initWithCouponId:1 sellerId:1 status:1 price:2 expirationDate:[NSDate date] createdDate:[NSDate date] storeName:@"J.Crew" title:@"30% off ANY ITEM" couponDescription:@"30% off ANY ITEM" code:@"fuckmeinthedick" deleted:0];
    Coupon *coupon7 = [[Coupon alloc] initWithCouponId:1 sellerId:1 status:1 price:2 expirationDate:[NSDate date] createdDate:[NSDate date] storeName:@"J.Crew" title:@"30% off ANY ITEM" couponDescription:@"30% off ANY ITEM" code:@"fuckmeinthedick" deleted:0];
    
    [self.allListings addObject:coupon1];
    [self.allListings addObject:coupon2];
    [self.allListings addObject:coupon3];
    [self.allListings addObject:coupon4];
    [self.allListings addObject:coupon5];
    [self.allListings addObject:coupon6];
    [self.allListings addObject:coupon7];
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
