//
//  Transaction.h
//  Codeconomy
//
//  Created by studio on 2/26/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import <Parse/Parse.h>

@interface Transaction : PFObject<PFSubclassing>
+ (NSString *)parseClassName;
@property int buyerId;
@property int sellerId;
@property int couponId;
@property (retain) NSString *reviewDescription;
@property int stars;
- (instancetype)initWithBuyerId:(int)buyerId
                       sellerId:(int)sellerId
                       couponId:(int)couponId
              reviewDescription:(NSString *)reviewDescription
                          stars:(int)stars;
@end