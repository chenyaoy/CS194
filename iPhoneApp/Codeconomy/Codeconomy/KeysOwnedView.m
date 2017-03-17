//
//  KeysOwnedView.m
//  Codeconomy
//
//  Created by Gary on 03/15/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import "KeysOwnedView.h"
#import "Util.h"
#import "User.h"

@interface KeysOwnedView ()
@property (nonatomic, strong) UILabel *keys;
@end

@implementation KeysOwnedView

- (instancetype)initWithCredits:(int)credits {
    self = [super init];
    if (self) {
        self.backgroundColor = [[Util sharedManager] colorWithHexString:[Util getWhiteColorHex]];
        
        _keys = [[UILabel alloc] init];
        _keys.text = [NSString stringWithFormat:@"You currently have\n%d🔑", credits];
        _keys.font = [UIFont systemFontOfSize:20.0];
        _keys.numberOfLines = 0;
        [_keys setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_keys];
        
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(reloadUserData:)
                                                     name:@"reloadUserData"
                                                   object:nil];
    }
    return self;
}

- (void)layoutSubviews {
    [self.keys sizeToFit];
    self.keys.frame = CGRectMake((self.frame.size.width - self.keys.frame.size.width) / 2.0,
                                 12.0,
                                 self.keys.frame.size.width,
                                 self.keys.frame.size.height);
}

- (CGSize)getKeysLabelSize {
    return self.keys.frame.size;
}

#pragma mark - Helpers

- (void)reloadUserData:(NSNotification *) notification {
    self.keys.text = [NSString stringWithFormat:@"You currently have\n%d🔑", [User currentUser].credits];
    [self.keys sizeToFit];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
