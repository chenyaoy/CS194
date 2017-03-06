//
//  Transaction.m
//  Codeconomy
//
//  Created by studio on 2/26/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import "Transaction.h"

@implementation Transaction
@dynamic buyer;
@dynamic seller;
@dynamic coupon;
@dynamic transactionDate;
@dynamic reviewDescription;
@dynamic stars;

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"Transaction";
}

- (instancetype)initWithBuyer:(User *)buyer
                       seller:(User *)seller
                       coupon:(Coupon *)coupon
              transactionDate:(NSDate *)transactionDate
            reviewDescription:(NSString *)reviewDescription
                        stars:(int)stars {
    self = [super init];
    if (self) {
        self.buyer = buyer;
        self.seller = seller;
        self.coupon = coupon;
        self.transactionDate = transactionDate;
        self.reviewDescription = reviewDescription;
        self.stars = stars;
    }
    return self;
}
@end
