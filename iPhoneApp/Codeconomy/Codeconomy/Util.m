//
//  Util.m
//  Codeconomy
//
//  Created by studio on 2/12/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import "Util.h"

@implementation Util

+ (id)sharedManager {
    static Util *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

/**
 * Returns "FE3824", the hex color code for the Codeconomy red.
 * @return hexString hex color code for red
 */
+ (NSString *)getRedColorHex {
    return @"FE3824";
}

/**
 * Returns "9FCBFE", the hex color code for the Codeconomy blue.
 * @return hexString hex color code for blue
 */
+ (NSString *)getBlueColorHex {
    return @"9FCBFE";
}

/**
 * Returns "44DB5E", the hex color code for the Codeconomy green.
 * @return hexString hex color code for green
 */
+ (NSString *)getGreenColorHex {
    return @"44DB5E";
}

/**
 * Returns "FFFFFF", the hex color code for white.
 * @return hexString hex color code for white
 */
+ (NSString *)getWhiteColorHex {
    return @"FFFFFF";
}

/**
 * Returns "F7F7F7", the hex color code for the Codeconomy light gray.
 * @return hexString hex color code for light gray
 */
+ (NSString *)getLightGrayColorHex {
    return @"F7F7F7";
}

/**
 * Returns "7A797B", the hex color code for the Codeconomy dark gray.
 * @return hexString hex color code for dark gray
 */
+ (NSString *)getDarkGrayColorHex {
    return @"7A797B";
}

-(UIColor *)colorWithHexString:(NSString *)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

#pragma mark - Fonts

+ (UIFont *)getRegularFont:(CGFloat)size {
    return [UIFont fontWithName:@"Rubik-Regular" size:size];
}

+ (UIFont *)getLightFont:(CGFloat)size {
    return [UIFont fontWithName:@"Rubik-Light" size:size];
}

+ (UIFont *)getLightItalicFont:(CGFloat)size {
    return [UIFont fontWithName:@"Rubik-LightItalic" size:size];
}

+ (UIFont *)getItalicFont:(CGFloat)size {
    return [UIFont fontWithName:@"Rubik-Italic" size:size];
}

+ (UIFont *)getMediumFont:(CGFloat)size {
    return [UIFont fontWithName:@"Rubik-Medium" size:size];
}

+ (UIFont *)getMediumItalicFont:(CGFloat)size {
    return [UIFont fontWithName:@"Rubik-MediumItalic" size:size];
}

+ (UIFont *)getBoldFont:(CGFloat)size {
    return [UIFont fontWithName:@"Rubik-Bold" size:size];
}

+ (UIFont *)getBoldItalicFont:(CGFloat)size {
    return [UIFont fontWithName:@"Rubik-BoldItalic" size:size];
}

+ (UIFont *)getBlackFont:(CGFloat)size {
    return [UIFont fontWithName:@"Rubik-Black" size:size];
}

+ (UIFont *)getBlackItalicFont:(CGFloat)size {
    return [UIFont fontWithName:@"Rubik-BlackItalic" size:size];
}

@end
