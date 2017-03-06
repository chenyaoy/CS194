//
//  TransactionsDetailViewController.h
//  Codeconomy
//
//  Created by Gary on 03/05/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Transaction.h"
#import "User.h"

@interface TransactionsDetailViewController : UIViewController
- (instancetype)initWithTransaction:(Transaction *)transactionData user:(User *)user;
@end
