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

- (instancetype)initWithCreatedDate:(NSDate *)createdDate seller:(User *)seller {
    self = [super init];
    if (self) {
        _seller = seller;
        self.backgroundColor = [[Util sharedManager] colorWithHexString:@"FFFFFF"];
        
        _sellerRating = 0;
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
                _createdLabel = [[UILabel alloc] init];
                NSTimeInterval distanceBetweenDates = [[NSDate date] timeIntervalSinceDate:createdDate];
                int hoursBetweenDates = distanceBetweenDates / 3600;
                NSMutableAttributedString *createdString = [[NSMutableAttributedString alloc] initWithString:seller.username];
                if (total > 0) {
                    [createdString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@", whose seller rating is %d%%,",  (int) (_sellerRating + 0.5)]]];
                }
                [createdString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" posted this code %d hours ago.", hoursBetweenDates]]];
                [createdString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:18.0f] range:NSMakeRange(0, seller.username.length)];
                _createdLabel.attributedText = createdString;
//                UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCreatedLabel)];
//                tapGestureRecognizer.numberOfTapsRequired = 1;
//                [_createdLabel addGestureRecognizer:tapGestureRecognizer];
//                _createdLabel.userInteractionEnabled = YES;
                _createdLabel.numberOfLines = 0;
//                _createdLabel.lineBreakMode = NSLineBreakByWordWrapping;
                [self addSubview:_createdLabel];

            } else {
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];
        
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)layoutSubviews {
    self.createdLabel.frame = CGRectMake(20.0, 12.0, self.frame.size.width - 40.0, self.frame.size.height - 24.0);
}

#pragma mark - Listeners

- (void)tapCreatedLabel {
    NSString *sellerUsername = self.seller.username;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
