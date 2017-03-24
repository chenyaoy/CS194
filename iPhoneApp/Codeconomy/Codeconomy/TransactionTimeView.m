//
//  TransactionSellerView.m
//  Codeconomy
//
//  Created by Gary on 03/05/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import "TransactionTimeView.h"
#import "Util.h"

@interface TransactionTimeView ()
@property (nonatomic, strong) UILabel *transactionTimeLabel;
@end

@implementation TransactionTimeView

- (instancetype)initWithTransactionDate:(NSDate *)transactionDate otherUser:(User *)otherUser userBought:(BOOL)userBought {
    self = [super init];
    if (self) {
        self.backgroundColor = [[Util sharedManager] colorWithHexString:[Util getWhiteColorHex]];
        
        _transactionTimeLabel = [[UILabel alloc] init];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
        dateFormatter.dateFormat = @"MMMM d, yyyy 'at' h:mm a";
        NSString *dateString = [dateFormatter stringFromDate: transactionDate];
        if (userBought) {
            _transactionTimeLabel.text = [NSString stringWithFormat:@"You bought this code from %@ on %@.", otherUser.displayName, dateString];
        } else {
            _transactionTimeLabel.text = [NSString stringWithFormat:@"You sold this code to %@ on %@.", otherUser.displayName, dateString];
        }
        _transactionTimeLabel.numberOfLines = 0;
        [self addSubview:_transactionTimeLabel];
        
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)layoutSubviews {
    self.transactionTimeLabel.frame = CGRectMake(20.0, 12.0, self.frame.size.width - 40.0, self.frame.size.height - 24.0);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
