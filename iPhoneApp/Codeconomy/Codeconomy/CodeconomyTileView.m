//
//  CodeconomyTileView.m
//  Codeconomy
//
//  Created by studio on 2/12/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import "CodeconomyTileView.h"
#import "Util.h"

@interface CodeconomyTileView ()
@property (nonatomic, strong) Coupon *couponData;
@property (nonatomic, strong) UILabel *credits;
@property (nonatomic, strong) UILabel *store;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *expires;
@property (nonatomic, strong) UILabel *posted;
@end

@implementation CodeconomyTileView

- (id)init {
    self = [super init];
    if (self) {
        _credits = [[UILabel alloc] init];
        _store = [[UILabel alloc] init];
        _title = [[UILabel alloc] init];
        _expires = [[UILabel alloc] init];
        _posted = [[UILabel alloc] init];
        
        [self setBackgroundColor: [[Util sharedManager] colorWithHexString:@"FFFFFF"]];
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)setCoupon:(Coupon *)coupon {
    self.couponData = coupon;
    [self setLabels];
}

- (void)setLabels {
    self.credits.text = [NSString stringWithFormat:@"%d🔑", self.couponData.price];
    [self.credits setFont:[Util getRegularFont:22.0]];
    [self addSubview:self.credits];
    [self.credits sizeToFit];
    
    self.store.text = self.couponData.storeName;
    [self.store setFont:[Util getMediumFont:18.0]];
    [self addSubview:self.store];
    [self.store sizeToFit];
    
    self.title.text = self.couponData.couponDescription;
    [self.title setFont:[Util getRegularFont:18.0]];
    [self addSubview:self.title];
    [self.title sizeToFit];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"M/d/yy";
    NSString *dateString = [dateFormatter stringFromDate: self.couponData.expirationDate];
    
    self.expires.text = [NSString stringWithFormat:@"expires %@", dateString];
    if (!dateString) {
        self.expires.text = @"does not expire";
    }
    [self.expires setFont:[Util getItalicFont:14.0]];
    [self addSubview:self.expires];
    [self.expires sizeToFit];
    
    NSTimeInterval distanceBetweenDates = [[NSDate date] timeIntervalSinceDate:self.couponData.createdAt];
    int hoursBetweenDates = distanceBetweenDates / 3600;
    
    self.posted.text = [NSString stringWithFormat:@"posted %dh ago", hoursBetweenDates];
    [self.posted setFont:[Util getItalicFont:14.0]];
    [self addSubview:self.posted];
    [self.posted sizeToFit];
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.credits.frame = CGRectMake(12.0, self.frame.size.height / 2.0 - self.credits.frame.size.height / 2.0, self.credits.frame.size.width, self.credits.frame.size.height);
    self.store.frame = CGRectMake(self.credits.frame.origin.x + self.credits.frame.size.width + 30.0, 10.0, self.store.frame.size.width, self.store.frame.size.height);
    self.title.frame = CGRectMake(self.store.frame.origin.x, self.store.frame.origin.y + self.store.frame.size.height + 4.0, self.title.frame.size.width, self.title.frame.size.height);
    self.expires.frame = CGRectMake(self.title.frame.origin.x, self.frame.size.height - self.expires.frame.size.height - 10.0, self.expires.frame.size.width, self.expires.frame.size.height);
    self.posted.frame = CGRectMake(self.frame.size.width - self.posted.frame.size.width - 12.0, self.expires.frame.origin.y, self.posted.frame.size.width, self.posted.frame.size.height);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
