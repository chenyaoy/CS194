//
//  KeysBuyingOptionsView.m
//  Codeconomy
//
//  Created by Gary on 03/15/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import "KeysBuyingOptionsView.h"
#import "Util.h"

@interface KeysBuyingOptionsView ()
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *tenKeysQuantity;
@property (nonatomic, strong) UILabel *fiftyKeysQuantity;
@property (nonatomic, strong) UILabel *hundredKeysQuantity;
@property (nonatomic, strong) UIButton *buyTenKeys;
@property (nonatomic, strong) UIButton *buyFiftyKeys;
@property (nonatomic, strong) UIButton *buyHundredKeys;
@end

@implementation KeysBuyingOptionsView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [[Util sharedManager] colorWithHexString:[Util getWhiteColorHex]];
        
        _title = [[UILabel alloc] init];
        _title.text = @"Buy More Keys";
        _title.font = [UIFont systemFontOfSize:20.0];
        [self addSubview:_title];
        
        _tenKeysQuantity = [[UILabel alloc] init];
        _tenKeysQuantity.text = @"10🔑";
        _tenKeysQuantity.font = [UIFont systemFontOfSize:24.0];
        [self addSubview:_tenKeysQuantity];

        _fiftyKeysQuantity = [[UILabel alloc] init];
        _fiftyKeysQuantity.text = @"50🔑";
        _fiftyKeysQuantity.font = [UIFont systemFontOfSize:24.0];
        [self addSubview:_fiftyKeysQuantity];
        
        _hundredKeysQuantity = [[UILabel alloc] init];
        _hundredKeysQuantity.text = @"100🔑";
        _hundredKeysQuantity.font = [UIFont systemFontOfSize:24.0];
        [self addSubview:_hundredKeysQuantity];
        
        _buyTenKeys = [[UIButton alloc] init];
        [_buyTenKeys setTitle:@"$5" forState:UIControlStateNormal];
        [_buyTenKeys setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_buyTenKeys addTarget:self action:@selector(tapKeyQuantity:) forControlEvents:UIControlEventTouchUpInside];
        _buyTenKeys.titleLabel.textAlignment = NSTextAlignmentCenter;
        _buyTenKeys.titleLabel.font = [UIFont systemFontOfSize:24.0];
        _buyTenKeys.layer.borderWidth = 2.0f;
        _buyTenKeys.layer.borderColor = [[UIColor blackColor] CGColor];
        _buyTenKeys.layer.cornerRadius = 10;
        _buyTenKeys.layer.masksToBounds = YES;
        _buyTenKeys.layer.opacity = 0.33;
        [self addSubview:_buyTenKeys];
        
        _buyFiftyKeys = [[UIButton alloc] init];
        [_buyFiftyKeys setTitle:@"$22" forState:UIControlStateNormal];
        [_buyFiftyKeys setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_buyFiftyKeys addTarget:self action:@selector(tapKeyQuantity:) forControlEvents:UIControlEventTouchUpInside];
        _buyFiftyKeys.titleLabel.textAlignment = NSTextAlignmentCenter;
        _buyFiftyKeys.titleLabel.font = [UIFont systemFontOfSize:24.0];
        _buyFiftyKeys.layer.borderWidth = 2.0f;
        _buyFiftyKeys.layer.borderColor = [[UIColor blackColor] CGColor];
        _buyFiftyKeys.layer.cornerRadius = 10;
        _buyFiftyKeys.layer.masksToBounds = YES;
        _buyFiftyKeys.layer.opacity = 0.33;
        [self addSubview:_buyFiftyKeys];
        
        _buyHundredKeys = [[UIButton alloc] init];
        [_buyHundredKeys setTitle:@"$40" forState:UIControlStateNormal];
        [_buyHundredKeys setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_buyHundredKeys addTarget:self action:@selector(tapKeyQuantity:) forControlEvents:UIControlEventTouchUpInside];
        _buyHundredKeys.titleLabel.textAlignment = NSTextAlignmentCenter;
        _buyHundredKeys.titleLabel.font = [UIFont systemFontOfSize:24.0];
        _buyHundredKeys.layer.borderWidth = 2.0f;
        _buyHundredKeys.layer.borderColor = [[UIColor blackColor] CGColor];
        _buyHundredKeys.layer.cornerRadius = 10;
        _buyHundredKeys.layer.masksToBounds = YES;
        _buyHundredKeys.layer.opacity = 0.33;
        [self addSubview:_buyHundredKeys];
        
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)layoutSubviews {
    [self.title sizeToFit];
    [self.tenKeysQuantity sizeToFit];
    [self.fiftyKeysQuantity sizeToFit];
    [self.hundredKeysQuantity sizeToFit];
    [self.buyTenKeys sizeToFit];
    [self.buyFiftyKeys sizeToFit];
    [self.buyHundredKeys sizeToFit];
    self.title.frame = CGRectMake((self.frame.size.width - self.title.frame.size.width) / 2.0,
                                 12.0,
                                 self.title.frame.size.width,
                                 self.title.frame.size.height);
    
    CGSize textSize = [self.tenKeysQuantity.text boundingRectWithSize:CGSizeMake(self.tenKeysQuantity.frame.size.width, MAXFLOAT)
                                                          options:NSStringDrawingUsesLineFragmentOrigin
                                                       attributes:@{NSFontAttributeName:self.tenKeysQuantity.font}
                                                          context:nil].size;
    self.buyTenKeys.frame = CGRectMake(self.frame.size.width - 20.0 - self.buyTenKeys.frame.size.width,
                                      self.title.frame.origin.y + self.title.frame.size.height + 12.0,
                                      70.0,
                                      40.0);
    self.tenKeysQuantity.frame = CGRectMake(20.0,
                                       self.buyTenKeys.frame.origin.y + (self.buyTenKeys.frame.size.height - self.tenKeysQuantity.frame.size.height) / 2,
                                       self.tenKeysQuantity.frame.size.width,
                                       textSize.height);
    
    textSize = [self.fiftyKeysQuantity.text boundingRectWithSize:CGSizeMake(self.fiftyKeysQuantity.frame.size.width, MAXFLOAT)
                                                       options:NSStringDrawingUsesLineFragmentOrigin
                                                    attributes:@{NSFontAttributeName:self.fiftyKeysQuantity.font}
                                                       context:nil].size;
    self.buyFiftyKeys.frame = CGRectMake(self.buyTenKeys.frame.origin.x,
                                       self.buyTenKeys.frame.origin.y + self.buyTenKeys.frame.size.height + 10.0,
                                       self.buyTenKeys.frame.size.width,
                                       self.buyTenKeys.frame.size.height);
    self.fiftyKeysQuantity.frame = CGRectMake(20.0,
                                            self.buyFiftyKeys.frame.origin.y + (self.buyFiftyKeys.frame.size.height - self.fiftyKeysQuantity.frame.size.height) / 2,
                                            self.fiftyKeysQuantity.frame.size.width,
                                            textSize.height);
    
    textSize = [self.hundredKeysQuantity.text boundingRectWithSize:CGSizeMake(self.hundredKeysQuantity.frame.size.width, MAXFLOAT)
                                                       options:NSStringDrawingUsesLineFragmentOrigin
                                                    attributes:@{NSFontAttributeName:self.hundredKeysQuantity.font}
                                                       context:nil].size;
    self.buyHundredKeys.frame = CGRectMake(self.buyFiftyKeys.frame.origin.x,
                                           self.buyFiftyKeys.frame.origin.y + self.buyFiftyKeys.frame.size.height + 10.0,
                                       self.buyTenKeys.frame.size.width,
                                       self.buyTenKeys.frame.size.height);
    self.hundredKeysQuantity.frame = CGRectMake(20.0,
                                            self.buyHundredKeys.frame.origin.y + (self.buyHundredKeys.frame.size.height - self.hundredKeysQuantity.frame.size.height) / 2,
                                            self.hundredKeysQuantity.frame.size.width,
                                            textSize.height);
}


#pragma mark - Listeners

- (void)tapKeyQuantity:(UIButton *)sender {
}

- (void)tapBuy:(UIButton *)sender {
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
