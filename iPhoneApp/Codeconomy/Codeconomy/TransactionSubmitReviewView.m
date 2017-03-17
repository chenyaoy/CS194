//
//  TransactionSubmitReviewView.m
//  Codeconomy
//
//  Created by studio on 3/9/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import "Util.h"
#import "TransactionSubmitReviewView.h"

@interface TransactionSubmitReviewView () <UITextViewDelegate>

@property (nonatomic, strong) Transaction *transaction;

@property (nonatomic, strong) UILabel *leaveReview;

@property (nonatomic, strong) UIButton *checkMark;
@property (nonatomic, strong) UIButton *xMark;
@property (nonatomic, strong) UIButton *selectWork;
@property (nonatomic, strong) UILabel *didCodeWork;

@property (nonatomic, strong) UITextView *commentView;
@property (nonatomic, strong) UILabel *defaultLabel;

@property (nonatomic, strong) UIButton *submitReview;

@end

@implementation TransactionSubmitReviewView

- (instancetype)initWithTransaction:(Transaction *)transaction {
    self = [super init];
    if (self) {
        _transaction = transaction;
        self.backgroundColor = [[Util sharedManager] colorWithHexString:[Util getWhiteColorHex]];
        
        _leaveReview = [[UILabel alloc] init];
        _leaveReview.font = [UIFont systemFontOfSize:20.0f weight:UIFontWeightMedium];
        _leaveReview.text = @"Leave a Review!";
        [self addSubview:_leaveReview];
        
        _checkMark = [[UIButton alloc] init];
        [_checkMark setTitle:@"✔" forState:UIControlStateNormal];
        [_checkMark addTarget:self action:@selector(tapWorks:) forControlEvents:UIControlEventTouchUpInside];
        _checkMark.titleLabel.textAlignment = NSTextAlignmentCenter;
        _checkMark.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
        _checkMark.layer.borderWidth = 6.0f;
        _checkMark.layer.borderColor = [[UIColor blackColor] CGColor];
        _checkMark.layer.opacity = 0.33;
        _checkMark.layer.cornerRadius = 10;
        _checkMark.layer.masksToBounds = YES;
        [self addSubview:_checkMark];
        _xMark = [[UIButton alloc] init];
        [_xMark setTitle:@"✕" forState:UIControlStateNormal];
        [_xMark setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_xMark addTarget:self action:@selector(tapWorks:) forControlEvents:UIControlEventTouchUpInside];
        _xMark.titleLabel.textAlignment = NSTextAlignmentCenter;
        _xMark.titleLabel.font = [UIFont boldSystemFontOfSize:24.0f];
        _xMark.layer.borderWidth = 6.0f;
        _xMark.layer.borderColor = [[UIColor blackColor] CGColor];
        _xMark.layer.opacity = 0.33;
        _xMark.layer.cornerRadius = 10;
        _xMark.layer.masksToBounds = YES;
        [self addSubview:_xMark];
        
        _didCodeWork = [[UILabel alloc] init];
        _didCodeWork.font = [UIFont systemFontOfSize:20.0f weight:UIFontWeightMedium];
        _didCodeWork.text = @"Did this code work?";
        [self addSubview:_didCodeWork];
        
        _commentView = [[UITextView alloc] init];
        _commentView.font = [UIFont systemFontOfSize:20.0 weight:UIFontWeightLight];
        UIColor *borderColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.33];
        _commentView.layer.borderColor = borderColor.CGColor;
        _commentView.layer.borderWidth = 1.0;
        _commentView.delegate = self;
        [self addSubview:_commentView];
        
        _defaultLabel = [[UILabel alloc] init];
        _defaultLabel.font = [UIFont systemFontOfSize:20.0 weight:UIFontWeightLight];
        _defaultLabel.text = @"Leave a comment (optional).";
        [_defaultLabel setAlpha:0.33];
        [self.commentView addSubview:_defaultLabel];
        
        _submitReview = [[UIButton alloc] init];
        [_submitReview setTitle: @"Write a review" forState: UIControlStateNormal];
        _submitReview.backgroundColor = [[Util sharedManager] colorWithHexString:[Util getBlueColorHex]];
        [_submitReview addTarget:self action:@selector(tapSubmitReview:) forControlEvents:UIControlEventTouchUpInside];
        _submitReview.titleLabel.font = [UIFont systemFontOfSize:24.0f weight:UIFontWeightMedium];
        _submitReview.layer.cornerRadius = 10;
        _submitReview.layer.masksToBounds = YES;
        [self addSubview:_submitReview];
        
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)layoutSubviews {
    [self.leaveReview sizeToFit];
    [self.didCodeWork sizeToFit];
    [self.defaultLabel sizeToFit];
    self.leaveReview.frame = CGRectMake(self.frame.size.width / 2.0 - self.leaveReview.frame.size.width / 2.0, 12.0, self.leaveReview.frame.size.width, self.leaveReview.frame.size.height);
    self.checkMark.frame = CGRectMake(self.frame.size.width - 108.0, self.leaveReview.frame.origin.y + self.leaveReview.frame.size.height + 8.0, 40.0, 40.0);
    self.xMark.frame = CGRectMake(self.checkMark.frame.origin.x + self.checkMark.frame.size.width + 8.0, self.checkMark.frame.origin.y, 40.0, 40.0);
    self.didCodeWork.frame = CGRectMake(20.0, self.xMark.frame.origin.y + self.xMark.frame.size.height / 2.0 - self.didCodeWork.frame.size.height / 2.0, self.didCodeWork.frame.size.width, self.didCodeWork.frame.size.height);
    self.commentView.frame = CGRectMake(20.0, self.xMark.frame.origin.y + self.xMark.frame.size.height + 12.0, self.frame.size.width - 40.0, 100.0);
    self.defaultLabel.frame = CGRectMake(12.0, 8.0, self.defaultLabel.frame.size.width, self.defaultLabel.frame.size.height);
    self.submitReview.frame = CGRectMake(20.0, self.commentView.frame.origin.y + self.commentView.frame.size.height + 8.0, self.frame.size.width - 40.0, 50.0);
}

#pragma mark - UITextView Delegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.defaultLabel.hidden = YES;
}

- (void)textViewDidChange:(UITextView *)txtView
{
    self.defaultLabel.hidden = ([txtView.text length] > 0);
}

- (void)textViewDidEndEditing:(UITextView *)txtView
{
    self.defaultLabel.hidden = ([txtView.text length] > 0);
}

#pragma mark - Listeners

- (void)tapSubmitReview:(UIButton *)sender {
    if(self.selectWork == self.xMark) {
        self.transaction.stars = -1;
    } else {
        self.transaction.stars = 1;
    }
    self.transaction.reviewDescription = self.commentView.text;
    [self.transaction saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            [self.delegate updateTransaction];
        } else {
            NSLog(@"%@", error);
        }
    }];
}

- (void)tapWorks:(UIButton *)sender {
    if (sender == self.xMark) {
        self.xMark.layer.opacity = 1.0;
        self.checkMark.layer.opacity = 0.33;
        self.selectWork = self.xMark;
    } else {
        self.checkMark.layer.opacity = 1.0;
        self.xMark.layer.opacity = 0.33;
        self.selectWork = self.checkMark;
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
