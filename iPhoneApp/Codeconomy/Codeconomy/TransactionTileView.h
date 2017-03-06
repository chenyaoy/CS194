//
//  TransactionTileView.h
//  Codeconomy
//
//  Created by Gary on 03/05/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Transaction.h"
#import "User.h"

@interface TransactionTileView : UIView
- (void)setTransaction:(Transaction *)transaction user:(User *)user;
@end
