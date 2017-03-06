//
//  Filter.h
//  Codeconomy
//
//  Created by studio on 2/26/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import <Parse/Parse.h>
#import "Coupon.h"

@interface Filter : PFObject<PFSubclassing>
+ (NSString *)parseClassName;
@property int category;
@property (retain) Coupon *coupon;
- (instancetype)initWithCategory:(int)category
                          coupon:(Coupon *)coupon;
@end
