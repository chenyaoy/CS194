//
//  TransactionReviewView.h
//  Codeconomy
//
//  Created by studio on 3/11/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Transaction.h"

@interface TransactionReviewView : UIView
- (instancetype)initWithTransaction:(Transaction *)transaction;
@end
