//
//  CouponCode.m
//  Codeconomy
//
//  Created by studio on 2/26/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import "Coupon.h"

@implementation Coupon
@dynamic sellerId;
@dynamic status;
@dynamic price;
@dynamic expirationDate;
@dynamic storeName;
@dynamic couponDescription;
@dynamic additionalInfo;
@dynamic code;
@dynamic deleted;

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"Coupon";
}

- (instancetype)initWithSellerId:(NSString *)sellerId
                          status:(int)status
                           price:(int)price
                  expirationDate:(NSDate *)expirationDate
                       storeName:(NSString *)storeName
               couponDescription:(NSString *)couponDescription
                  additionalInfo:(NSString *)additionalInfo
                            code:(NSString *)code
                         deleted:(BOOL)deleted {
    self = [super init];
    if (self) {
        self.sellerId = sellerId;
        self.status = status;
        self.price = price;
        self.expirationDate = expirationDate;
        self.storeName = storeName;
        self.couponDescription = couponDescription;
        self.additionalInfo = additionalInfo;
        self.code = code;
        self.deleted = deleted;
    }
    return self;
}

@end
