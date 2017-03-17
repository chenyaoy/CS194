//
//  KeysBuyingOptionsView.h
//  Codeconomy
//
//  Created by Gary on 03/15/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeysBuyingOptionsView : UIView
- (instancetype)init;
- (int)getKeyQuantity;
- (NSString *)getCardNumber;
- (NSString *)getExpirationDate;
- (NSString *)getSecurityCode;
- (NSString *)getZipCode;
@end
