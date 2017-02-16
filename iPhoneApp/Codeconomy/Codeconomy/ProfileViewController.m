//
//  ProfileViewController.m
//  Codeconomy
//
//  Created by studio on 2/12/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import "ProfileViewController.h"
#import "ListingsViewController.h"
#import "ProfileTile.h"
#import "Util.h"

@interface ProfileViewController ()
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *memberSince;
@property (nonatomic, strong) ProfileTile *manageKeys;
@property (nonatomic, strong) ProfileTile *transactionHistory;
@property (nonatomic, strong) ProfileTile *accountSettings;
@property (nonatomic, strong) UITapGestureRecognizer *transactionHistoryTap;

@property (nonatomic, strong) NSMutableArray *allListings;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor: [[Util sharedManager] colorWithHexString:@"F7F7F7"]];
    
    self.name = [[UILabel alloc] init];
    [self.name setText:@"Gary Thung"];
    [self.name setFont:[UIFont systemFontOfSize:40.0f]];
    [self.name sizeToFit];
    [self.view addSubview:self.name];
    
    self.memberSince = [[UILabel alloc] init];
    [self.memberSince setText:@"Member since 01/13/17"];
    self.memberSince.font = [UIFont italicSystemFontOfSize:20.0f];
    [self.memberSince sizeToFit];
    [self.view addSubview:self.memberSince];
    
    self.manageKeys = [[ProfileTile alloc] init];
    [self.view addSubview:self.manageKeys];
    [self.manageKeys setLeftLabel:@"36 🔑"];
    [self.manageKeys setRightLabel:@"Manage Keys ➡️"];
    
    self.transactionHistory = [[ProfileTile alloc] init];
    [self.view addSubview:self.transactionHistory];
    [self.transactionHistory setLeftLabel:@"📜"];
    [self.transactionHistory setRightLabel:@"Transaction History ➡️"];
    _transactionHistoryTap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTransactionHistory)];
    [_transactionHistory addGestureRecognizer:_transactionHistoryTap];
    
    self.accountSettings = [[ProfileTile alloc] init];
    [self.view addSubview:self.accountSettings];
    [self.accountSettings setLeftLabel:@"⚙"];
    [self.accountSettings setRightLabel:@"Account Settings ➡️"];
    
    _allListings = [[NSMutableArray alloc] init];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.name.center = CGPointMake(self.view.frame.size.width / 2.0, self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.frame.size.height + 50.0);
    self.memberSince.frame = CGRectMake(0, 0, self.memberSince.frame.size.width + 10.0, self.memberSince.frame.size.height);
    self.memberSince.textAlignment = NSTextAlignmentCenter;
    self.memberSince.center = CGPointMake(self.view.frame.size.width / 2.0, self.name.frame.origin.y + self.name.frame.size.height + 16.0);
    self.manageKeys.frame = CGRectMake(self.view.frame.origin.x + 40.0, self.memberSince.frame.origin.y + self.memberSince.frame.size.height + 25.0, self.view.frame.size.width - 80.0, 60.0);
    self.transactionHistory.frame = CGRectMake(self.manageKeys.frame.origin.x, self.manageKeys.frame.origin.y + self.manageKeys.frame.size.height + 15.0, self.manageKeys.frame.size.width, self.manageKeys.frame.size.height);
    self.accountSettings.frame = CGRectMake(self.transactionHistory.frame.origin.x, self.transactionHistory.frame.origin.y + self.transactionHistory.frame.size.height + 15.0, self.transactionHistory.frame.size.width, self.transactionHistory.frame.size.height);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Listeners

- (void)tapTransactionHistory {
    ListingsViewController *listingsVC = [[ListingsViewController alloc] init];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] init];
    barButton.title = @"Back";
    self.navigationItem.backBarButtonItem = barButton;
    listingsVC.navigationItem.title = @"Transaction History";
    [self.navigationController pushViewController:listingsVC animated:YES];
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
