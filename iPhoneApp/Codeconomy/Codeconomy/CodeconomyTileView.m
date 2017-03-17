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
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *expires;
@property (nonatomic, strong) UILabel *posted;
@end

@implementation CodeconomyTileView

- (id)init {
    self = [super init];
    if (self) {
        _credits = [[UILabel alloc] init];
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
    [self.credits setFont:[UIFont boldSystemFontOfSize:22.0f]];
    [self addSubview:self.credits];
    [self.credits sizeToFit];
    
    NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@", self.couponData.storeName, self.couponData.couponDescription]];
    [titleString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:18.0f] range:NSMakeRange(0, self.couponData.storeName.length)];
    [titleString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.0f] range:NSMakeRange(self.couponData.storeName.length + 1, self.couponData.couponDescription.length)];
    self.title.attributedText = titleString;
    [self addSubview:self.title];
    [self.title sizeToFit];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"MM/dd/yy";
    NSString *dateString = [dateFormatter stringFromDate: self.couponData.expirationDate];
    
    self.expires.text = [NSString stringWithFormat:@"expires %@", dateString];
    [self.expires setFont:[UIFont systemFontOfSize:14.0f]];
    [self addSubview:self.expires];
    [self.expires sizeToFit];
    
    NSTimeInterval distanceBetweenDates = [[NSDate date] timeIntervalSinceDate:self.couponData.createdAt];
    int hoursBetweenDates = distanceBetweenDates / 3600;
    
    self.posted.text = [NSString stringWithFormat:@"posted %dh ago", hoursBetweenDates];
    [self.posted setFont:[UIFont systemFontOfSize:14.0f]];
    [self addSubview:self.posted];
    [self.posted sizeToFit];
    [self setNeedsLayout];
}

- (void) layoutSubviews {
    [super layoutSubviews];
    self.credits.frame = CGRectMake(12.0, self.frame.size.height / 2.0 - self.credits.frame.size.height / 2.0, self.credits.frame.size.width, self.credits.frame.size.height);
    self.title.frame = CGRectMake(self.credits.frame.origin.x + self.credits.frame.size.width + 30.0, 10.0, self.title.frame.size.width, self.title.frame.size.height);
    self.expires.frame = CGRectMake(self.title.frame.origin.x, self.frame.size.height - self.expires.frame.size.height - 8.0, self.expires.frame.size.width, self.expires.frame.size.height);
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
