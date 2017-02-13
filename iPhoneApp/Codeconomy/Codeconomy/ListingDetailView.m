//
//  ListingDetailView.m
//  Codeconomy
//
//  Created by studio on 2/12/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import "ListingDetailView.h"

@interface ListingDetailView ()
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UILabel *expirationDate;
@property (nonatomic, strong) UILabel *category;
@end

@implementation ListingDetailView

- (instancetype)initWithPrice:(int)price
               expirationDate:(NSDate *)expirationDate
                     category:(NSString *)category {
    self = [super init];
    if (self) {
        _price = [[UILabel alloc] init];
        _price.text = [NSString stringWithFormat:@"Price: %d🔑", price];
        [self addSubview:_price];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.dateFormat = @"MM/dd/yy";
        NSString *dateString = [dateFormatter stringFromDate: expirationDate];
        _expirationDate = [[UILabel alloc] init];
        _expirationDate.text = [NSString stringWithFormat:@"Expires on %@", dateString];
        [self addSubview:_expirationDate];
        
        _category = [[UILabel alloc] init];
        _category.text = category;
        [self addSubview:_category];
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
