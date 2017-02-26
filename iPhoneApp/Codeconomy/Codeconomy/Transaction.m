//
//  Transaction.m
//  Codeconomy
//
//  Created by studio on 2/26/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import "Transaction.h"

@implementation Transaction
@dynamic buyerId;
@dynamic sellerId;
@dynamic couponId;
@dynamic reviewDescription;
@dynamic stars;

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"Transaction";
}

- (instancetype)initWithBuyerId:(NSString *)buyerId
                       sellerId:(NSString *)sellerId
                       couponId:(NSString *)couponId
              reviewDescription:(NSString *)reviewDescription
                          stars:(int)stars {
    self = [super init];
    if (self) {
        self.buyerId = buyerId;
        self.sellerId = sellerId;
        self.couponId = couponId;
        self.reviewDescription = reviewDescription;
        self.stars = stars;
    }
    return self;
}
@end
