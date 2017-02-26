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

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"Transaction";
}

- (instancetype)initWithBuyerId:(int)buyerId
                       sellerId:(int)sellerId {
    self = [super init];
    if (self) {
        self.buyerId = buyerId;
        self.sellerId = sellerId;
    }
    return self;
}
@end
