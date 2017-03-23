//
//  SearchViewController.h
//  Codeconomy
//
//  Created by studio on 3/22/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface SearchViewController : UIViewController
- (instancetype)initWithUser:(User *)user withCategory:(NSString *)category;
- (instancetype)initWithUser:(User *)user withSearchString:(NSString *)str;
@end
