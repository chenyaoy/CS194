//
//  TransactionSellerView.h
//  Codeconomy
//
//  Created by Gary on 03/05/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface TransactionTimeView : UIView
- (instancetype)initWithTransactionDate:(NSDate *)transactionDate otherUser:(User *)otherUser userBought:(BOOL)userBought;
@end
