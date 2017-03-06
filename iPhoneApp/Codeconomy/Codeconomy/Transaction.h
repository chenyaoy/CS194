//
//  Transaction.h
//  Codeconomy
//
//  Created by studio on 2/26/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import <Parse/Parse.h>
#import "User.h"
#import "Coupon.h"

@interface Transaction : PFObject<PFSubclassing>
+ (NSString *)parseClassName;
@property (retain) User *buyer;
@property (retain) User *seller;
@property (retain) Coupon *coupon;
@property (retain) NSDate *transactionDate;
@property (retain) NSString *reviewDescription;
@property int stars;
- (instancetype)initWithBuyer:(User *)buyer
                       seller:(User *)seller
                       coupon:(Coupon *)coupon
              transactionDate:(NSDate *)transactionDate
            reviewDescription:(NSString *)reviewDescription
                        stars:(int)stars;
@end
