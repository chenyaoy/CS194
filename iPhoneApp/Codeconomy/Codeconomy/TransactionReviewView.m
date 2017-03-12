//
//  TransactionReviewView.m
//  Codeconomy
//
//  Created by studio on 3/11/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import "TransactionReviewView.h"
#import "Util.h"

@interface TransactionReviewView ()
@property (nonatomic, strong) Transaction *transaction;
@property (nonatomic, strong) UILabel *review;
@property (nonatomic, strong) UILabel *workedText;
@property (nonatomic, strong) UILabel *extraComment;
@end

@implementation TransactionReviewView

- (instancetype)initWithTransaction:(Transaction *)transaction {
    self = [super init];
    if (self) {
        _transaction = transaction;
        self.backgroundColor = [[Util sharedManager] colorWithHexString:[Util getWhiteColorHex]];
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
        
        _review = [[UILabel alloc] init];
        _review.font = [UIFont systemFontOfSize:20.0f weight:UIFontWeightRegular];
        _review.text = @"Review";
        [self addSubview:_review];
        
        _workedText = [[UILabel alloc] init];
        if (transaction.stars == -1) {
            NSMutableAttributedString *reviewString = [[NSMutableAttributedString alloc] initWithString:@"The code did not work.\nComment:"];
            NSRange selectedRange = NSMakeRange(9, 13);
            [reviewString beginEditing];
            [reviewString addAttribute:NSFontAttributeName
                                 value:[UIFont systemFontOfSize:20.0 weight:UIFontWeightLight]
                                 range:NSMakeRange(0, reviewString.length)];
            [reviewString addAttribute:NSFontAttributeName
                                 value:[UIFont systemFontOfSize:20.0 weight:UIFontWeightRegular]
                                 range:selectedRange];
            [reviewString endEditing];
            _workedText.attributedText = reviewString;
            _workedText.numberOfLines = 0;
        } else {
            NSMutableAttributedString *reviewString = [[NSMutableAttributedString alloc] initWithString:@"The code did work.\nComment:"];
            NSRange selectedRange = NSMakeRange(9, 9);
            [reviewString beginEditing];
            [reviewString addAttribute:NSFontAttributeName
                                 value:[UIFont systemFontOfSize:20.0 weight:UIFontWeightLight]
                                 range:NSMakeRange(0, reviewString.length)];
            [reviewString addAttribute:NSFontAttributeName
                                 value:[UIFont systemFontOfSize:20.0 weight:UIFontWeightRegular]
                                 range:selectedRange];
            [reviewString endEditing];
            _workedText.attributedText = reviewString;
            _workedText.numberOfLines = 0;
        }
        [self addSubview:_workedText];
        
        _extraComment = [[UILabel alloc] init];
        _extraComment.text = self.transaction.reviewDescription;
        _extraComment.font = [UIFont systemFontOfSize:20.0f weight:UIFontWeightRegular];
        [self addSubview:_extraComment];
    }
    return self;
}

- (void)layoutSubviews {
    [self.review sizeToFit];
    [self.extraComment sizeToFit];
    self.review.frame = CGRectMake(self.frame.size.width / 2.0 - self.review.frame.size.width / 2.0, 12.0, self.review.frame.size.width, self.review.frame.size.height);
    CGSize textSize = [self.workedText.text sizeWithFont:self.workedText.font
                                      constrainedToSize:CGSizeMake(self.workedText.frame.size.width, MAXFLOAT)
                                          lineBreakMode:self.workedText.lineBreakMode];
    self.workedText.frame = CGRectMake(20.0, self.review.frame.origin.y + self.review.frame.size.height + 12.0, self.frame.size.width - 40.0, textSize.height);
    self.extraComment.frame = CGRectMake(36.0, self.workedText.frame.origin.y + self.workedText.frame.size.height + 8.0, self.extraComment.frame.size.width, self.extraComment.frame.size.height);
}

@end
