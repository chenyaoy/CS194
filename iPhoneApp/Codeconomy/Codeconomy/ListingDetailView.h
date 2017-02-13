//
//  ListingDetailView.h
//  Codeconomy
//
//  Created by studio on 2/12/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListingDetailView : UIView
- (instancetype)initWithPrice:(int)price
               expirationDate:(NSDate *)expirationDate
                     category:(NSString *)category;
@end
