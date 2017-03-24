//
//  ListingTimeCreatedView.h
//  Codeconomy
//
//  Created by studio on 2/12/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface ListingTimeCreatedView : UIView
- (instancetype)initWithCreatedDate:(NSDate *)createdDate
                             seller:(User *)seller
                           userOwns:(bool)userOwns;
- (CGSize)getLabelSize;
@end
