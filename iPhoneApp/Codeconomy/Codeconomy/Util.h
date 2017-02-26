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
+ (NSString *)getWhiteColorHex;
+ (NSString *)getLightGrayColorHex;
+ (NSString *)getDarkGrayColorHex;
- (UIColor *)colorWithHexString:(NSString *)hex;
@end
