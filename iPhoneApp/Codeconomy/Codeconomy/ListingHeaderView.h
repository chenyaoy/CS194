//
//  ListingHeaderView.h
//  Codeconomy
//
//  Created by studio on 2/12/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListingHeaderView : UIView
- (instancetype)initWithStoreName:(NSString *)storeName
                            title:(NSString *)title
                      description:(NSString *)couponDescription;
@end
