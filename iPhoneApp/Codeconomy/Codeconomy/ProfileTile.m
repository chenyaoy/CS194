//
//  Tile.m
//  Codeconomy
//
//  Created by studio on 2/12/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import "ProfileTile.h"
#import "Util.h"

@interface ProfileTile ()
@property (nonatomic, strong) UILabel *left;
@property (nonatomic, strong) UILabel *right;
@end

@implementation ProfileTile

- (id)init {
    self = [super init];
    if (self) {
        _left = [[UILabel alloc] init];
        _right = [[UILabel alloc] init];
        [self setBackgroundColor:[UIColor whiteColor]];
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)setLeftLabel:(NSString *)label {
    self.left.text = label;
    [self.left setFont:[Util getRegularFont:28.0]];
    self.left.numberOfLines = 0;
    [self addSubview:self.left];
    [self.left sizeToFit];
}

- (void)setRightLabel:(NSString *)label {
    self.right.text = label;
    [self.right setFont:[Util getRegularFont:20.0]];
    self.right.numberOfLines = 0;
    [self addSubview:self.right];
    [self.right sizeToFit];
}

- (void)setRightLabelMedium:(NSString *)label {
    self.right.text = label;
    [self.right setFont:[Util getMediumFont:20.0]];
    self.right.numberOfLines = 0;
    [self addSubview:self.right];
    [self.right sizeToFit];
}

- (void)setRightLabelBold:(NSString *)label {
    self.right.text = label;
    [self.right setFont:[Util getBoldFont:20.0]];
    self.right.numberOfLines = 0;
    [self addSubview:self.right];
    [self.right sizeToFit];
}

- (void) layoutSubviews {
    [super layoutSubviews];
    
    self.left.frame = CGRectMake(10.0, self.frame.size.height / 2.0 - self.left.frame.size.height / 2.0, self.left.frame.size.width, self.left.frame.size.height);
    self.right.frame = CGRectMake(self.frame.size.width - self.right.frame.size.width - 10.0, self.frame.size.height / 2.0 - self.right.frame.size.height / 2.0, self.right.frame.size.width, self.right.frame.size.height);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
