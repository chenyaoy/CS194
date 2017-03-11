//
//  SettingsViewController.h
//  Codeconomy
//
//  Created by Gary on 03/09/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface SettingsViewController : UIViewController
- (instancetype)initWithUser:(User *)user;
@end
