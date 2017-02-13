//
//  ListingTimeCreatedView.m
//  Codeconomy
//
//  Created by studio on 2/12/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import "ListingTimeCreatedView.h"

@interface ListingTimeCreatedView ()
@property (nonatomic, strong) UILabel *createdLabel;
@end

@implementation ListingTimeCreatedView

- (instancetype)initWithCreatedDate:(NSDate *)createdDate seller:(NSString *)seller {
    self = [super init];
    if (self) {
        _createdLabel = [[UILabel alloc] init];
        NSTimeInterval distanceBetweenDates = [[NSDate date] timeIntervalSinceDate:createdDate];
        int hoursBetweenDates = distanceBetweenDates / 3600;
        _createdLabel.text = [NSString stringWithFormat:@"This code was posted %d hours ago by %@.", hoursBetweenDates, seller];
        [self addSubview:_createdLabel];
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
