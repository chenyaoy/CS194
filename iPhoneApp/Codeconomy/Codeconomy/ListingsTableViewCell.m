//
//  ListingsTableViewCell.m
//  Codeconomy
//
//  Created by studio on 2/12/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import "ListingsTableViewCell.h"
#import "Coupon.h"
#import "CodeconomyTileView.h"
#import "Util.h"

@interface ListingsTableViewCell ()
@property (nonatomic, strong) Coupon *couponData;
@property (nonatomic, strong) CodeconomyTileView *codeconomyTileView;
@end

@implementation ListingsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _couponData = [[Coupon alloc] init];
        _codeconomyTileView = [[CodeconomyTileView alloc] init];
        [self setBackgroundColor: [[Util sharedManager] colorWithHexString:@"F7F7F7"]];
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

- (void)setCoupon:(Coupon *)coupon {
    self.couponData = coupon;
    [self.codeconomyTileView setCoupon:coupon];
    [self.contentView addSubview:self.codeconomyTileView];
}

- (void)layoutSubviews {
    self.codeconomyTileView.frame = self.contentView.frame;
}

@end
