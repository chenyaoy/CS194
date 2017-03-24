//
//  ProfileViewController.m
//  Codeconomy
//
//  Created by studio on 2/12/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import "ProfileViewController.h"
#import "KeysViewController.h"
#import "SettingsViewController.h"
#import "TransactionsViewController.h"
#import "ProfileTile.h"
#import "Transaction.h"
#import "Util.h"

@interface ProfileViewController ()
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *memberSince;
@property float sellerRating;
@property (nonatomic, strong) UILabel *ratingLabel;
@property (nonatomic, strong) ProfileTile *manageKeys;
@property (nonatomic, strong) ProfileTile *transactionHistory;
@property (nonatomic, strong) ProfileTile *accountSettings;
@property (nonatomic, strong) ProfileTile *logOut;
@property (nonatomic, strong) UITapGestureRecognizer *manageKeysTap;
@property (nonatomic, strong) UITapGestureRecognizer *accountSettingsTap;
@property (nonatomic, strong) UITapGestureRecognizer *transactionHistoryTap;
@property (nonatomic, strong) UITapGestureRecognizer *logOutTap;

@property (nonatomic, strong) NSMutableArray *allListings;
@end

@implementation ProfileViewController

- (instancetype)initWithUser:(User *)user {
    self = [super init];
    if (self) {
        _user = user;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(reloadUserData:)
                                                     name:@"reloadUserData"
                                                   object:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor: [[Util sharedManager] colorWithHexString:@"F7F7F7"]];
    
    self.name = [[UILabel alloc] init];
    [self.name setText:self.user.displayName];
    [self.name setFont:[UIFont systemFontOfSize:40.0f]];
    [self.name sizeToFit];
    [self.view addSubview:self.name];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"MMMM d, yyyy";
    NSMutableString *dateString = [[dateFormatter stringFromDate: self.user.createdAt] mutableCopy];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger dayOfMonth = components.day;
    NSString *ordinalSuffix;
    switch (dayOfMonth) {
        case 1:
        case 21:
        case 31: ordinalSuffix = @"st";
        case 2:
        case 22: ordinalSuffix = @"nd";
        case 3:
        case 23: ordinalSuffix = @"rd";
        default: ordinalSuffix = @"th";
    }
    [dateString insertString:ordinalSuffix atIndex:dateString.length - 6];
    
    self.memberSince = [[UILabel alloc] init];
    [self.memberSince setText:[NSString stringWithFormat:@"Member since %@", dateString]];
    self.memberSince.font = [UIFont systemFontOfSize:20.0f];
    self.memberSince.textAlignment = NSTextAlignmentCenter;
    [self.memberSince sizeToFit];
    [self.view addSubview:self.memberSince];
    
    self.sellerRating = 0;
    PFQuery *query = [PFQuery queryWithClassName:[Transaction parseClassName]];
    [query whereKey:@"seller" equalTo:_user];
    [query includeKey:@"stars"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError * error) {
        if (!error) {
            int total = 0;
            for (Transaction *t in objects) {
                if (t.stars != 0) {
                    self.sellerRating += MAX(0, t.stars);
                    total += 1;
                }
            }
            self.sellerRating /= total;
            self.sellerRating *= 100;
            self.ratingLabel = [[UILabel alloc] init];
            if (total > 0) {
                [self.ratingLabel setText:[NSString stringWithFormat:@"Seller rating: %d%%", (int) (self.sellerRating + 0.5)]];
            } else {
                [self.ratingLabel setText:@"You don't have a seller rating yet."];
            }
            self.ratingLabel.font = [UIFont systemFontOfSize:20.0f];
            self.ratingLabel.textAlignment = NSTextAlignmentCenter;
            [self.ratingLabel sizeToFit];
            [self.view addSubview:self.ratingLabel];
            
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    self.manageKeys = [[ProfileTile alloc] init];
    [self.view addSubview:self.manageKeys];
    [self.manageKeys setLeftLabel:[NSString stringWithFormat:@"%d 🔑", self.user.credits]];
    [self.manageKeys setRightLabel:@"Manage Keys ➡️"];
    _manageKeysTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapManageKeys)];
    [_manageKeys addGestureRecognizer:_manageKeysTap];
    
    self.transactionHistory = [[ProfileTile alloc] init];
    [self.view addSubview:self.transactionHistory];
    [self.transactionHistory setLeftLabel:@"📜"];
    [self.transactionHistory setRightLabel:@"Transaction History ➡️"];
    _transactionHistoryTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTransactionHistory)];
    [_transactionHistory addGestureRecognizer:_transactionHistoryTap];
    
    self.accountSettings = [[ProfileTile alloc] init];
    [self.view addSubview:self.accountSettings];
    [self.accountSettings setLeftLabel:@"⚙"];
    [self.accountSettings setRightLabel:@"Account Settings ➡️"];
    _accountSettingsTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAccountSettings)];
    [_accountSettings addGestureRecognizer:_accountSettingsTap];
    
    self.logOut = [[ProfileTile alloc] init];
    [self.view addSubview:self.logOut];
    [self.logOut setLeftLabel:@"✌️"];
    [self.logOut setRightLabelBold:@"Log Out ➡️"];
    _logOutTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLogOut)];
    [_logOut addGestureRecognizer:_logOutTap];
    
    _allListings = [[NSMutableArray alloc] init];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.name.center = CGPointMake(self.view.frame.size.width / 2.0, self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.frame.size.height + 50.0);
    self.memberSince.frame = CGRectMake(0, 0, self.memberSince.frame.size.width + 10.0, self.memberSince.frame.size.height);
    self.memberSince.center = CGPointMake(self.view.frame.size.width / 2.0, self.name.frame.origin.y + self.name.frame.size.height + 16.0);
    
    self.ratingLabel.frame = CGRectMake(0, 0, self.ratingLabel.frame.size.width + 10.0, self.ratingLabel.frame.size.height);
    self.ratingLabel.center = CGPointMake(self.view.frame.size.width / 2.0, self.memberSince.frame.origin.y + self.memberSince.frame.size.height + 15.0);
    
    self.manageKeys.frame = CGRectMake(self.view.frame.origin.x + 20.0, self.ratingLabel.frame.origin.y + self.ratingLabel.frame.size.height + 25.0, self.view.frame.size.width - 40.0, 60.0);
    self.transactionHistory.frame = CGRectMake(self.manageKeys.frame.origin.x, self.manageKeys.frame.origin.y + self.manageKeys.frame.size.height + 8.0, self.manageKeys.frame.size.width, self.manageKeys.frame.size.height);
    self.accountSettings.frame = CGRectMake(self.transactionHistory.frame.origin.x, self.transactionHistory.frame.origin.y + self.transactionHistory.frame.size.height + 8.0, self.transactionHistory.frame.size.width, self.transactionHistory.frame.size.height);
    self.logOut.frame = CGRectMake(self.accountSettings.frame.origin.x, self.accountSettings.frame.origin.y + self.accountSettings.frame.size.height + 8.0, self.accountSettings.frame.size.width, self.accountSettings.frame.size.height);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Listeners

- (void)tapManageKeys {
    KeysViewController *keysVC = [[KeysViewController alloc] initWithUser:self.user];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] init];
    barButton.title = @"Back";
    self.navigationItem.backBarButtonItem = barButton;
    keysVC.navigationItem.title = @"Manage Keys";
    [self.navigationController pushViewController:keysVC animated:YES];
}

- (void)tapAccountSettings {
    SettingsViewController *settingsVC = [[SettingsViewController alloc] initWithUser:self.user];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] init];
    barButton.title = @"Back";
    self.navigationItem.backBarButtonItem = barButton;
    settingsVC.navigationItem.title = @"Account Settings";
    [self.navigationController pushViewController:settingsVC animated:YES];
}

- (void)tapTransactionHistory {
    TransactionsViewController *transactionsVC = [[TransactionsViewController alloc] initWithUser:self.user];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] init];
    barButton.title = @"Back";
    self.navigationItem.backBarButtonItem = barButton;
    transactionsVC.navigationItem.title = @"Transaction History";
    [self.navigationController pushViewController:transactionsVC animated:YES];
}

- (void)tapLogOut {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Log out of Codeconomy?"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* yesAction = [UIAlertAction actionWithTitle:@"Log Out"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * action) {
                                                          [self logUserOut];
                                                          // redirect to the login/signup page
                                                      }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                       style:UIAlertActionStyleCancel
                                                     handler:^(UIAlertAction * action) {}];
    [alert addAction:yesAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)logUserOut {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        if (!error) {
            [self.tabBarController dismissViewControllerAnimated:NO completion:nil];
        } else {
            NSLog(@"%@", error);
        }
    }];
}

- (void)reloadUserData:(NSNotification *) notification {
    [self.user fetch];
    [self.manageKeys setLeftLabel:[NSString stringWithFormat:@"%d 🔑", self.user.credits]];
    [self.view setNeedsLayout];
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
