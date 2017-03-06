//
//  TransactionTileView.m
//  Codeconomy
//
//  Created by Gary on 03/05/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import "TransactionTileView.h"
#import "Util.h"
#import "Coupon.h"

@interface TransactionTileView ()
@property (nonatomic, strong) Transaction *transactionData;
@property (nonatomic, strong) Coupon *couponData;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *dateTransacted;
@property (nonatomic, strong) UIView *circle;
@property BOOL userBought;
@end

@implementation TransactionTileView

- (id)init {
    self = [super init];
    if (self) {
        _title = [[UILabel alloc] init];
        _dateTransacted = [[UILabel alloc] init];
        _circle = [[UIView alloc] init];
        [self setBackgroundColor: [[Util sharedManager] colorWithHexString:[Util getWhiteColorHex]]];
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)setTransaction:(Transaction *)transaction user:(User *)user {
    self.user = user;
    self.transactionData = transaction;
    self.couponData = transaction.coupon;
    self.userBought = user.username == transaction.buyer.username;
    [self setLabels];
}

- (void)setLabels {
    int radius = 5;
    self.circle.frame = CGRectMake(0, 0, 2 * radius, 2 * radius);
    if (self.userBought) {
        self.circle.backgroundColor = [[Util sharedManager] colorWithHexString:[Util getBlueColorHex]];
    } else {
        self.circle.backgroundColor = [[Util sharedManager] colorWithHexString:[Util getGreenColorHex]];
    }
    self.circle.layer.cornerRadius = radius;
    self.circle.layer.masksToBounds = YES;
    [self addSubview:self.circle];

    NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@", self.couponData.storeName, self.couponData.couponDescription]];
    [titleString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:18.0f] range:NSMakeRange(0, self.couponData.storeName.length)];
    [titleString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.0f] range:NSMakeRange(self.couponData.storeName.length + 1, self.couponData.couponDescription.length)];
    self.title.attributedText = titleString;
    [self addSubview:self.title];
    [self.title sizeToFit];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
//    dateFormatter.dateFormat = @"m/d/yy";
    dateFormatter.dateFormat = @"MMMM d, ''yy";
    NSString *dateString = [dateFormatter stringFromDate: self.transactionData.transactionDate];
    
    if (self.userBought) {
        self.dateTransacted.text = [NSString stringWithFormat:@"you bought this on %@", dateString];
    } else {
        self.dateTransacted.text = [NSString stringWithFormat:@"you sold this on %@", dateString];
    }
    [self.dateTransacted setFont:[UIFont systemFontOfSize:14.0f]];
    [self addSubview:self.dateTransacted];
    [self.dateTransacted sizeToFit];
    
    [self setNeedsLayout];
}

- (void) layoutSubviews {
    [super layoutSubviews];
    self.circle.frame = CGRectMake(16.0, self.frame.size.height / 2.0 - self.circle.frame.size.height / 2.0, self.circle.frame.size.width, self.circle.frame.size.height);
    self.title.frame = CGRectMake(self.circle.frame.origin.x + self.circle.frame.size.width + 30.0, 10.0, self.title.frame.size.width, self.title.frame.size.height);
    self.dateTransacted.frame = CGRectMake(self.title.frame.origin.x, self.frame.size.height - self.dateTransacted.frame.size.height - 8.0, self.dateTransacted.frame.size.width, self.dateTransacted.frame.size.height);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
