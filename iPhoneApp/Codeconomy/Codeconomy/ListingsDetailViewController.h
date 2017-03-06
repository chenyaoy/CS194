//
//  ListingDetailViewViewController.h
//  Codeconomy
//
//  Created by studio on 2/12/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Coupon.h"
#import "User.h"

@interface ListingsDetailViewController : UIViewController
- (instancetype)initWithCoupon:(Coupon *)couponData buy:(BOOL)buy user:(User *)user;
@end
