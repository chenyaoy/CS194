//
//  Util.h
//  Codeconomy
//
//  Created by studio on 2/12/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Util : NSObject
+ (id)sharedManager;
+ (NSString *)getRedColorHex;
+ (NSString *)getBlueColorHex;
+ (NSString *)getGreenColorHex;
+ (NSString *)getWhiteColorHex;
+ (NSString *)getLightGrayColorHex;
+ (NSString *)getDarkGrayColorHex;
- (UIColor *)colorWithHexString:(NSString *)hex;

+ (UIFont *)getRegularFont:(CGFloat)size;
+ (UIFont *)getLightFont:(CGFloat)size;
+ (UIFont *)getLightItalicFont:(CGFloat)size;
+ (UIFont *)getItalicFont:(CGFloat)size;
+ (UIFont *)getMediumFont:(CGFloat)size;
+ (UIFont *)getMediumItalicFont:(CGFloat)size;
+ (UIFont *)getBoldFont:(CGFloat)size;
+ (UIFont *)getBoldItalicFont:(CGFloat)size;
+ (UIFont *)getBlackFont:(CGFloat)size;
+ (UIFont *)getBlackItalicFont:(CGFloat)size;
@end
