//
//  ListingTimeCreatedView.m
//  Codeconomy
//
//  Created by studio on 2/12/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import "ListingTimeCreatedView.h"
#import "Util.h"
#import "Transaction.h"

@interface ListingTimeCreatedView ()
@property (nonatomic, strong) User *seller;
@property (nonatomic, strong) UILabel *createdLabel;
@property float sellerRating;
@end

@implementation ListingTimeCreatedView

- (instancetype)initWithCreatedDate:(NSDate *)createdDate seller:(User *)seller userOwns:(bool)userOwns {
    self = [super init];
    if (self) {
        _seller = seller;
        self.backgroundColor = [[Util sharedManager] colorWithHexString:@"FFFFFF"];
        
        _sellerRating = 0;
        NSTimeInterval distanceBetweenDates = [[NSDate date] timeIntervalSinceDate:createdDate];
        int hoursBetweenDates = distanceBetweenDates / 3600;
        _createdLabel = [[UILabel alloc] init];
        if (userOwns) {
            _createdLabel.text = [NSString stringWithFormat:@"You posted this code %d hours ago.", hoursBetweenDates];
            _createdLabel.numberOfLines = 0;
            [self addSubview:_createdLabel];
        } else {
            PFQuery *query = [PFQuery queryWithClassName:[Transaction parseClassName]];
            [query whereKey:@"seller" equalTo:_seller];
            [query includeKey:@"stars"];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError * error) {
                if (!error) {
                    int total = 0;
                    for (Transaction *t in objects) {
                        if (t.stars != 0) {
                            _sellerRating += MAX(0, t.stars);
                            total += 1;
                        }
                    }
                    _sellerRating /= total;
                    _sellerRating *= 100;
                    NSMutableAttributedString *createdString = [[NSMutableAttributedString alloc] initWithString:seller.username];
                    if (total > 0) {
                        [createdString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@", whose seller rating is %d%%,",  (int) (_sellerRating + 0.5)]]];
                    }
                    [createdString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" posted this code %d hours ago.", hoursBetweenDates]]];
                    [createdString addAttribute:NSFontAttributeName value:[Util getMediumFont:18.0] range:NSMakeRange(0, seller.username.length)];
                    _createdLabel.attributedText = createdString;
                    _createdLabel.numberOfLines = 0;
                    [self addSubview:_createdLabel];
                } else {
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];
        }
        
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)layoutSubviews {
    [self.createdLabel sizeToFit];
    self.createdLabel.frame = CGRectMake(20.0,
                                         12.0,
                                         self.frame.size.width - 40.0,
                                         self.frame.size.height - 24.0);
}

#pragma mark - Helpers

- (CGSize)getLabelSize {
    return self.createdLabel.frame.size;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
