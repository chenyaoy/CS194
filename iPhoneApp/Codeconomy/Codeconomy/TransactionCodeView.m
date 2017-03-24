//
//  TransactionCodeView.m
//  Codeconomy
//
//  Created by Gary on 03/05/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import "TransactionCodeView.h"
#import "Util.h"

@interface TransactionCodeView ()
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) UILabel *transactionCodeLabel;
//@property (nonatomic, strong) UITapGestureRecognizer *codeTap;
@end

@implementation TransactionCodeView

- (instancetype)initWithCode:(NSString *)code {
    self = [super init];
    if (self) {
        self.backgroundColor = [[Util sharedManager] colorWithHexString:[Util getWhiteColorHex]];
        
        _code = code;
        _transactionCodeLabel = [[UILabel alloc] init];
        NSMutableAttributedString *codeString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"The code is %@", code]];
        NSRange selectedRange = NSMakeRange(12, code.length);
        
        [codeString beginEditing];
        [codeString addAttribute:NSFontAttributeName
                           value:[Util getBoldFont:16.0]
                           range:selectedRange];
        [codeString endEditing];
        _transactionCodeLabel.attributedText = codeString;
        _transactionCodeLabel.numberOfLines = 0;
        [self addSubview:_transactionCodeLabel];
        
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;

        // Tap the code label to copy to clipboard
//        _codeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCode)];
//         [_transactionCodeLabel addGestureRecognizer:_codeTap];
    }
    return self;
}

- (void)layoutSubviews {
    self.transactionCodeLabel.frame = CGRectMake(20.0, 12.0, self.frame.size.width - 40.0, self.frame.size.height - 24.0);
}

//#pragma mark - Listeners
//
//- (void)tapCode {
//    [UIPasteboard generalPasteboard].string = _code;
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
