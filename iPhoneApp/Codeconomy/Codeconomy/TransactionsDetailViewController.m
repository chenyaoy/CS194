//
//  TransactionsDetailViewController.m
//  Codeconomy
//
//  Created by Gary on 03/05/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import "TransactionsDetailViewController.h"
#import "ListingHeaderView.h"
#import "ListingDetailView.h"
#import "TransactionTimeView.h"
#import "TransactionCodeView.h"
#import "Util.h"
#import "Coupon.h"

@interface TransactionsDetailViewController ()
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) Transaction *transactionData;
@property (nonatomic, strong) Coupon *couponData;
@property (nonatomic, strong) UILabel *creditsLabel;
@property (nonatomic, strong) ListingHeaderView *headerView;
@property (nonatomic, strong) ListingDetailView *detailView;
@property (nonatomic, strong) TransactionTimeView *timeView;
@property (nonatomic, strong) TransactionCodeView *codeView;
@property (nonatomic, strong) UIButton *writeReview;
@property BOOL userBought;
@end

@implementation TransactionsDetailViewController

- (instancetype)initWithTransaction:(Transaction *)transactionData user:(User *)user {
    self = [super init];
    if (self) {
        _user = user;
        
        _creditsLabel = [[UILabel alloc] init];
        _creditsLabel.text = [NSString stringWithFormat:@"%d🔑", self.user.credits];
        _transactionData = transactionData;
        _couponData = transactionData.coupon;
        _userBought = _transactionData.buyer.username == self.user.username;
        _headerView = [[ListingHeaderView alloc] initWithStoreName:_couponData.storeName title:_couponData.couponDescription description:_couponData.additionalInfo];
        _detailView = [[ListingDetailView alloc] initWithPrice:_couponData.price expirationDate:_couponData.expirationDate category:@"Clothing 👖"];
        //        _createdView = [[ListingTimeCreatedView alloc] initWithCreatedDate:_couponData.createdAt seller:[NSString stringWithFormat:@"%d", _couponData.sellerId]];
        if (_userBought) {
            _timeView = [[TransactionTimeView alloc] initWithTransactionDate:transactionData.transactionDate otherUser:transactionData.seller userBought:_userBought];
        } else {
            _timeView = [[TransactionTimeView alloc] initWithTransactionDate:transactionData.transactionDate otherUser:transactionData.buyer userBought:_userBought];
        }
        if (_userBought) {
            _codeView = [[TransactionCodeView alloc] initWithCode:transactionData.coupon.code];
        }
        _writeReview = [[UIButton alloc] init];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[Util sharedManager] colorWithHexString:[Util getLightGrayColorHex]];

    [_creditsLabel sizeToFit];
    [self.view addSubview:_headerView];
    [self.view addSubview:_detailView];
    [self.view addSubview:_timeView];
    if (_userBought) {
        [self.view addSubview:_codeView];
    }
    [self.view addSubview:_writeReview];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.creditsLabel];
    self.navigationItem.rightBarButtonItem = item;
    self.navigationItem.title = @"Transaction";
    if (_userBought) {
        [_writeReview setTitle: @"Write a review" forState: UIControlStateNormal];
        _writeReview.backgroundColor = [[Util sharedManager] colorWithHexString:[Util getBlueColorHex]];
        [_writeReview addTarget:self action:@selector(tapWriteReview:) forControlEvents:UIControlEventTouchUpInside];
        _writeReview.titleLabel.font = [UIFont systemFontOfSize:30.0f weight:UIFontWeightMedium];
        _writeReview.layer.cornerRadius = 10;
        _writeReview.layer.masksToBounds = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews {
    self.headerView.frame = CGRectMake(20.0, self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.frame.size.height + 15.0, self.view.frame.size.width - 40.0, 147.0);
    self.detailView.frame = CGRectMake(20.0, self.headerView.frame.origin.y + self.headerView.frame.size.height + 8.0, self.view.frame.size.width - 40.0, 127.0);
    self.timeView.frame = CGRectMake(20.0, self.detailView.frame.origin.y + self.detailView.frame.size.height + 8.0, self.view.frame.size.width - 40.0, 72.0);
    if (_userBought) {
        self.codeView.frame = CGRectMake(20.0, self.timeView.frame.origin.y + self.timeView.frame.size.height + 8.0, self.view.frame.size.width - 40.0, 50.0);
        self.writeReview.frame = CGRectMake(20.0, self.codeView.frame.origin.y + self.codeView.frame.size.height + 25.0, self.view.frame.size.width - 40.0, 50.0);
    } else {
        self.writeReview.frame = CGRectMake(20.0, self.timeView.frame.origin.y + self.timeView.frame.size.height + 25.0, self.view.frame.size.width - 40.0, 50.0);
    }
}

- (void)tapWriteReview:(UIButton *)sender {
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
