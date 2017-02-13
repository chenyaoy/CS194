//
//  ListingHeaderView.m
//  Codeconomy
//
//  Created by studio on 2/12/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import "ListingHeaderView.h"

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
        _storeName = [[UILabel alloc] init];
        _storeName.text = storeName;
        [self addSubview:_storeName];
        _title = [[UILabel alloc] init];
        _title.text = title;
        [self addSubview:_title];
        _couponDescription = [[UILabel alloc] init];
        _couponDescription.text = couponDescription;
        [self addSubview:_couponDescription];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
