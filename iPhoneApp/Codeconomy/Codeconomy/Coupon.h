//
//  CouponCode.h
//  Codeconomy
//
//  Created by studio on 2/26/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import <Parse/Parse.h>

@interface Coupon : PFObject<PFSubclassing>
+ (NSString *)parseClassName;
@property (retain) NSString *sellerId;
@property int status; // 0 = sold, 1 = for sale
@property int price;
@property (retain) NSDate *expirationDate;
@property (retain) NSString *storeName;
@property (retain) NSString *couponDescription;
@property (retain) NSString *additionalInfo;
@property (retain) NSString *code;
@property BOOL deleted;
- (instancetype)initWithSellerId:(NSString *)sellerId
                          status:(int)status
                           price:(int)price
                  expirationDate:(NSDate *)expirationDate
                       storeName:(NSString *)storeName
               couponDescription:(NSString *)couponDescription
                  additionalInfo:(NSString *)additionalInfo
                            code:(NSString *)code
                         deleted:(BOOL)deleted;
@end
