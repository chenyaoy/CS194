//
//  Review.h
//  Codeconomy
//
//  Created by studio on 2/26/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import <Parse/Parse.h>

@interface Review : PFObject<PFSubclassing>
+ (NSString *)parseClassName;
@property int buyerId;
@property int sellerId;
@property int transaction;
@property (retain) NSString *reviewDescription;
@property int stars;
- (instancetype)initWithBuyerId:(int)buyerId
                       sellerId:(int)sellerId
                    transaction:(int)transaction
              reviewDescription:(NSString *)reviewDescription
                          stars:(int)stars;
@end
