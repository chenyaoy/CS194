//
//  CategoryTileView.m
//  Codeconomy
//
//  Created by studio on 2/13/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import "CategoryTileView.h"
#import "Util.h"

@interface CategoryTileView ()
@property (nonatomic, strong) UILabel *emojiLabel;
@property (nonatomic, strong) UILabel *categoryLabel;
@end

@implementation CategoryTileView

- (instancetype)init {
    self = [super init];
    if (self) {
        _emojiLabel = [[UILabel alloc] init];
        _categoryLabel = [[UILabel alloc] init];
        _emojiLabel.font = [Util getRegularFont:30.0];
        _categoryLabel.font = [Util getRegularFont:18.0];
        [self setBackgroundColor: [[Util sharedManager] colorWithHexString:@"FFFFFF"]];
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)setCategory:(NSString *)name emoji:(NSString *)emoji {
    _emojiLabel.text = emoji;
    _categoryLabel.text = name;
    [self addSubview:_emojiLabel];
    [self addSubview:_categoryLabel];
    [_emojiLabel sizeToFit];
    [_categoryLabel sizeToFit];
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    self.emojiLabel.frame = CGRectMake(self.frame.size.width / 2.0 - self.emojiLabel.frame.size.width / 2.0, 18.0, self.emojiLabel.frame.size.width, self.emojiLabel.frame.size.height);
    self.categoryLabel.frame = CGRectMake(self.frame.size.width / 2.0 - self.categoryLabel.frame.size.width / 2.0, self.frame.size.height - self.categoryLabel.frame.size.height - 18.0, self.categoryLabel.frame.size.width, self.categoryLabel.frame.size.height);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
