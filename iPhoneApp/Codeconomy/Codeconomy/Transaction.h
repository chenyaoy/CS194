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
@property (retain) NSString *buyerId;
@property (retain) NSString *sellerId;
@property (retain) NSString *couponId;
@property (retain) NSString *reviewDescription;
@property int stars;
- (instancetype)initWithBuyerId:(NSString *)buyerId
                       sellerId:(NSString *)sellerId
                       couponId:(NSString *)couponId
              reviewDescription:(NSString *)reviewDescription
                          stars:(int)stars;
@end
