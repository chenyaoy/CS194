//
//  Coupon.h
//  Codeconomy
//
//  Created by studio on 2/12/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Coupon : NSObject
@property (nonatomic) int couponId;
@property (nonatomic) int sellerId;
@property (nonatomic) int status;
@property (nonatomic) int price;
@property (nonatomic, strong) NSDate *expirationDate;
@property (nonatomic, strong) NSDate *createdDate;
@property (nonatomic, strong) NSString *storeName;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *couponDescription;
@property (nonatomic, strong) NSString *code;
@property (nonatomic) BOOL deleted;

- (instancetype)initWithCouponId:(int)couponId
                        sellerId:(int)sellerId
                          status:(int)status
                           price:(float)price
                  expirationDate:(NSDate *)expirationDate
                     createdDate:(NSDate *)createdDate
                       storeName:(NSString *)storeName
                           title:(NSString *)title
               couponDescription:(NSString *)couponDescription
                            code:(NSString *)code
                         deleted:(BOOL)deleted;
@end
