//
//  Review.m
//  Codeconomy
//
//  Created by studio on 2/26/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import "Review.h"

@implementation Review
@dynamic buyerId;
@dynamic sellerId;
@dynamic transaction;
@dynamic reviewDescription;
@dynamic stars;

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"Review";
}

- (instancetype)initWithBuyerId:(int)buyerId
                       sellerId:(int)sellerId
                    transaction:(int)transaction
              reviewDescription:(NSString *)reviewDescription
                          stars:(int)stars {
    self = [super init];
    if (self) {
        self.buyerId = buyerId;
        self.sellerId = sellerId;
        self.transaction = transaction;
        self.reviewDescription = reviewDescription;
        self.stars = stars;
    }
    return self;
}
@end
