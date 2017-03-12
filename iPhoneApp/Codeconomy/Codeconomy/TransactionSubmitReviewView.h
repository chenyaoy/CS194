//
//  TransactionSubmitReviewView.h
//  Codeconomy
//
//  Created by studio on 3/9/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Transaction.h"

@class TransactionSubmitReviewView;
@protocol TransactionSubmitReviewViewDelegate <NSObject>
- (void)updateTransaction;
@end

@interface TransactionSubmitReviewView : UIView
@property id <TransactionSubmitReviewViewDelegate> delegate;
- (instancetype)initWithTransaction:(Transaction *)transaction;
@end
