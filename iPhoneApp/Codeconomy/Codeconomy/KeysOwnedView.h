//
//  KeysOwnedView.h
//  Codeconomy
//
//  Created by Gary on 03/15/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeysOwnedView : UIView
- (instancetype)initWithCredits:(int)credits;
- (CGSize)getKeysLabelSize;
@end
