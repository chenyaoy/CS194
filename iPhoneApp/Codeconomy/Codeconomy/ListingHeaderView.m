//
//  ListingHeaderView.m
//  Codeconomy
//
//  Created by studio on 2/12/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import "ListingHeaderView.h"
#import "Util.h"

@interface ListingHeaderView ()
@property (nonatomic, strong) UILabel *storeName;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *couponDescription;
@end

@implementation ListingHeaderView

- (instancetype)initWithStoreName:(NSString *)storeName
                            title:(NSString *)title
                      description:(NSString *)couponDescription {
    self = [super init];
    if (self) {
        self.backgroundColor = [[Util sharedManager] colorWithHexString:@"FFFFFF"];
        
        _storeName = [[UILabel alloc] init];
        _storeName.text = storeName;
        _storeName.font = [Util getMediumFont:40.0];
        [self addSubview:_storeName];
        _title = [[UILabel alloc] init];
        _title.text = title;
        _title.font = [Util getRegularFont:30.0];
        [self addSubview:_title];
        _couponDescription = [[UILabel alloc] init];
        _couponDescription.text = couponDescription;
        _couponDescription.font = [Util getRegularFont:20.0];
        [self addSubview:_couponDescription];
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)layoutSubviews {
    [self.storeName sizeToFit];
    [self.title sizeToFit];
    [self.couponDescription sizeToFit];
    self.storeName.frame = CGRectMake(self.frame.size.width / 2.0 - self.storeName.frame.size.width / 2.0, 12.0, self.storeName.frame.size.width, self.storeName.frame.size.height);
    self.title.frame = CGRectMake(self.frame.size.width / 2.0 - self.title.frame.size.width / 2.0, self.storeName.frame.origin.y + self.storeName.frame.size.height + 4.0, self.title.frame.size.width, self.title.frame.size.height);
    self.couponDescription.frame = CGRectMake(20.0, self.frame.size.height - self.couponDescription.frame.size.height - 12.0, self.couponDescription.frame.size.width, self.couponDescription.frame.size.height);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
