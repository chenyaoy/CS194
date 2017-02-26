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
@property int sellerId;
@property int status;
@property int price;
@property (retain) NSDate *expirationDate;
@property (retain) NSString *storeName;
@property (retain) NSString *couponDescription;
@property (retain) NSString *additionalInfo;
@property (retain) NSString *code;
@property BOOL deleted;
- (instancetype)initWithSellerId:(int)sellerId
                          status:(int)status
                           price:(int)price
                  expirationDate:(NSDate *)expirationDate
                       storeName:(NSString *)storeName
               couponDescription:(NSString *)couponDescription
                  additionalInfo:(NSString *)additionalInfo
                            code:(NSString *)code
                         deleted:(BOOL)deleted;
@end
