//
//  TransactionsTableViewCell.m
//  Codeconomy
//
//  Created by Gary on 03/05/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import "TransactionsTableViewCell.h"
#import "TransactionTileView.h"
#import "Util.h"

@interface TransactionsTableViewCell ()
@property (nonatomic, strong) Transaction *transactionData;
@property (nonatomic, strong) TransactionTileView *transactionTileView;
@end

@implementation TransactionsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _transactionData = [[Transaction alloc] init];
        _transactionTileView = [[TransactionTileView alloc] init];
        [self setBackgroundColor: [[Util sharedManager] colorWithHexString:[Util getLightGrayColorHex]]];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTransaction:(Transaction *)transaction user:(User *)user {
    self.transactionData = transaction;
    [self.transactionTileView setTransaction:transaction user:user];
    [self.contentView addSubview:self.transactionTileView];
}

- (void)layoutSubviews {
    self.transactionTileView.frame = self.contentView.frame;
}

@end
