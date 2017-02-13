//
//  ListingTimeCreatedView.m
//  Codeconomy
//
//  Created by studio on 2/12/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import "ListingTimeCreatedView.h"
#import "Util.h"

@interface ListingTimeCreatedView ()
@property (nonatomic, strong) UILabel *createdLabel;
@end

@implementation ListingTimeCreatedView

- (instancetype)initWithCreatedDate:(NSDate *)createdDate seller:(NSString *)seller {
    self = [super init];
    if (self) {
        self.backgroundColor = [[Util sharedManager] colorWithHexString:@"FFFFFF"];
        
        _createdLabel = [[UILabel alloc] init];
        NSTimeInterval distanceBetweenDates = [[NSDate date] timeIntervalSinceDate:createdDate];
        int hoursBetweenDates = distanceBetweenDates / 3600;
        _createdLabel.text = [NSString stringWithFormat:@"This code was posted %d hours ago by %@.", hoursBetweenDates, seller];
        _createdLabel.numberOfLines = 0;
        [self addSubview:_createdLabel];
        
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)layoutSubviews {
    self.createdLabel.frame = CGRectMake(20.0, 12.0, self.frame.size.width - 40.0, self.frame.size.height - 24.0);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
