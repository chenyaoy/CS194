//
//  ExploreCollectionViewCell.m
//  Codeconomy
//
//  Created by studio on 2/13/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import "ExploreCollectionViewCell.h"
#import "CategoryTileView.h"
#import "Util.h"

@interface ExploreCollectionViewCell ()
@property (nonatomic, strong) CategoryTileView *categoryView;
@end

@implementation ExploreCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _categoryView = [[CategoryTileView alloc] init];
        [self setBackgroundColor: [[Util sharedManager] colorWithHexString:@"F7F7F7"]];
    }
    return self;
}

- (void)setCategory:(NSString *)name emoji:(NSString *)emoji {
    [self.categoryView setCategory:name emoji:emoji];
    [self.contentView addSubview:self.categoryView];
}

- (void)layoutSubviews {
    self.categoryView.frame = self.contentView.frame;
}

@end
