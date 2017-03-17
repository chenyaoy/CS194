//
//  ListingDetailView.m
//  Codeconomy
//
//  Created by studio on 2/12/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import "ListingDetailView.h"
#import "Util.h"

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
        self.backgroundColor = [[Util sharedManager] colorWithHexString:@"FFFFFF"];
        
        _price = [[UILabel alloc] init];
        _price.text = [NSString stringWithFormat:@"Price: %d🔑", price];
        _price.font = [UIFont systemFontOfSize:36.0];
        [self addSubview:_price];
        
        _expirationDate = [[UILabel alloc] init];
        if (expirationDate != nil) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
            dateFormatter.dateFormat = @"M/d/yy 'at' h:mm a";
            NSString *dateString = [dateFormatter stringFromDate: expirationDate];
            _expirationDate.text = [NSString stringWithFormat:@"Expires on %@", dateString];
        } else {
            _expirationDate.text = @"This code does not expire.";
        }
        _expirationDate.font = [UIFont systemFontOfSize:20.0];
        [self addSubview:_expirationDate];
        
        _category = [[UILabel alloc] init];
        _category.text = [self translateCategoryText:category];
        _category.font = [UIFont systemFontOfSize:20.0];
        [self addSubview:_category];
        
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)layoutSubviews {
    [self.price sizeToFit];
    [self.expirationDate sizeToFit];
    [self.category sizeToFit];
    self.price.frame = CGRectMake(20.0, 18.0, self.price.frame.size.width, self.price.frame.size.height);
    self.expirationDate.frame = CGRectMake(20.0, self.price.frame.origin.y + self.price.frame.size.height + 4.0, self.expirationDate.frame.size.width, self.expirationDate.frame.size.height);
    self.category.frame = CGRectMake(20.0, self.frame.size.height - self.category.frame.size.height - 12.0, self.category.frame.size.width, self.category.frame.size.height);
}

- (NSString *)translateCategoryText:(NSString *)category {
    if ([category isEqualToString:@"Clothing"]) {
        return @"Clothing 👖";
    } else if ([category isEqualToString:@"Concerts"]) {
        return @"Concerts 🎟";
    } else if ([category isEqualToString:@"Food"]) {
        return @"Food 🍽";
    } else {
        return @"Electronics 🖥";
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
