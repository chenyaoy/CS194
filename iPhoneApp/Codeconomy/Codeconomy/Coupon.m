//
//  Coupon.m
//  Codeconomy
//
//  Created by studio on 2/12/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import "Coupon.h"

@implementation Coupon
- (instancetype)initWithCouponId:(int)couponId
                        sellerId:(int)sellerId
                          status:(int)status
                           price:(float)price
                  expirationDate:(NSDate *)expirationDate
                     createdDate:(NSDate *)createdDate
                       storeName:(NSString *)storeName
                           title:(NSString *)title
               couponDescription:(NSString *)couponDescription
                            code:(NSString *)code
                         deleted:(BOOL)deleted {
    self = [super init];
    if (self) {
        self.couponId = couponId;
        self.sellerId = sellerId;
        self.status = status;
        self.price = price;
        self.expirationDate = expirationDate;
        self.createdDate = createdDate;
        self.storeName = storeName;
        self.title = title;
        self.couponDescription = couponDescription;
        self.code = code;
        self.deleted = deleted;
    }
    return self;
}
@end
