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
@property (nonatomic, strong) UILabel *store;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *dateTransacted;
@property (nonatomic, strong) UIView *circle;
@property BOOL userBought;
@end

@implementation TransactionTileView

- (id)init {
    self = [super init];
    if (self) {
        _store = [[UILabel alloc] init];
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

    self.store.text = self.couponData.storeName;
    [self.store setFont:[Util getMediumFont:18.0]];
    [self addSubview:self.store];
    [self.store sizeToFit];
    
    self.title.text = self.couponData.couponDescription;
    [self.title setFont:[Util getRegularFont:18.0]];
    [self addSubview:self.title];
    [self.title sizeToFit];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"MMMM d, yyyy";
    NSString *dateString = [dateFormatter stringFromDate: self.transactionData.transactionDate];
    
    if (self.userBought) {
        self.dateTransacted.text = [NSString stringWithFormat:@"you bought this on %@", dateString];
    } else {
        self.dateTransacted.text = [NSString stringWithFormat:@"you sold this on %@", dateString];
    }
    [self.dateTransacted setFont:[Util getRegularFont:14.0]];
    [self addSubview:self.dateTransacted];
    [self.dateTransacted sizeToFit];
    
    [self setNeedsLayout];
}

- (void) layoutSubviews {
    [super layoutSubviews];
    self.circle.frame = CGRectMake(16.0, self.frame.size.height / 2.0 - self.circle.frame.size.height / 2.0, self.circle.frame.size.width, self.circle.frame.size.height);
    self.store.frame = CGRectMake(self.circle.frame.origin.x + self.circle.frame.size.width + 30.0, 10.0, self.store.frame.size.width, self.store.frame.size.height);
    self.title.frame = CGRectMake(self.store.frame.origin.x, self.store.frame.origin.y + self.store.frame.size.height + 4.0, self.title.frame.size.width, self.title.frame.size.height);
    self.dateTransacted.frame = CGRectMake(self.title.frame.origin.x, self.frame.size.height - self.dateTransacted.frame.size.height - 10.0, self.dateTransacted.frame.size.width, self.dateTransacted.frame.size.height);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
