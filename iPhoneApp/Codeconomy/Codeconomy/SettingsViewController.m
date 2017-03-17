//
//  SettingsViewController.m
//  Codeconomy
//
//  Created by Gary on 03/09/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import "SettingsViewController.h"
#import "Util.h"

@interface SettingsViewController ()
@property (nonatomic, strong) User *user;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UILabel *displayName;
@property (nonatomic, strong) UITextField *displayNameField;
@property (nonatomic, strong) UILabel *username;
@property (nonatomic, strong) UITextField *usernameField;
@property (nonatomic, strong) UILabel *currentPassword;
@property (nonatomic, strong) UITextField *currentPasswordField;
@property (nonatomic, strong) UILabel *updatePassword;
@property (nonatomic, strong) UITextField *updatePasswordField;

@property (nonatomic, strong) UIButton *saveProfile;
@property (nonatomic, strong) UIButton *savePassword;

@property (nonatomic, strong) UITapGestureRecognizer *scrollViewTap;

@end

@implementation SettingsViewController

- (instancetype)initWithUser:(User *)user {
    self = [super init];
    if (self) {
        _user = user;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[[Util sharedManager] colorWithHexString:[Util getLightGrayColorHex]]];
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    
    _displayName = [[UILabel alloc] init];
    _displayName.text = @"🙂";
    _displayName.numberOfLines = 1;
    _displayName.font = [UIFont systemFontOfSize:24.0f];
    [_scrollView addSubview:_displayName];
    _displayNameField = [[UITextField alloc] init];
    _displayNameField.layer.cornerRadius = 10;
    _displayNameField.layer.masksToBounds = YES;
    _displayNameField.layer.borderWidth = 1.0f;
    _displayNameField.layer.borderColor = [[UIColor blackColor] CGColor];
    _displayNameField.backgroundColor = [UIColor whiteColor];
    _displayNameField.layer.sublayerTransform = CATransform3DMakeTranslation(12.0, 0, 0);
    _displayNameField.text = _user.displayName;
    [_scrollView addSubview:_displayNameField];
    
    _username = [[UILabel alloc] init];
    _username.text = @"👤";
    _username.numberOfLines = 1;
    _username.font = [UIFont systemFontOfSize:24.0f];
    [_scrollView addSubview:_username];
    _usernameField = [[UITextField alloc] init];
    _usernameField.layer.cornerRadius = 10;
    _usernameField.layer.masksToBounds = YES;
    _usernameField.layer.borderWidth = 1.0f;
    _usernameField.layer.borderColor = [[UIColor blackColor] CGColor];
    _usernameField.backgroundColor = [UIColor whiteColor];
    _usernameField.layer.sublayerTransform = CATransform3DMakeTranslation(12.0, 0, 0);
    _usernameField.text = _user.username;
    [_scrollView addSubview:_usernameField];
    
    _saveProfile = [[UIButton alloc] init];
    [_saveProfile setTitle: @"Save Profile" forState: UIControlStateNormal];
    _saveProfile.backgroundColor = [[Util sharedManager] colorWithHexString:[Util getBlueColorHex]];
    _saveProfile.titleLabel.font = [UIFont systemFontOfSize:30.0f weight:UIFontWeightMedium];
    _saveProfile.layer.cornerRadius = 10;
    _saveProfile.layer.masksToBounds = YES;
    [_saveProfile addTarget:self action:@selector(tapSaveProfile:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_saveProfile];
    
    _currentPassword = [[UILabel alloc] init];
    _currentPassword.text = @"🔓";
    _currentPassword.numberOfLines = 1;
    _currentPassword.font = [UIFont systemFontOfSize:24.0f];
    [_scrollView addSubview:_currentPassword];
    _currentPasswordField = [[UITextField alloc] init];
    _currentPasswordField.layer.cornerRadius = 10;
    _currentPasswordField.layer.masksToBounds = YES;
    _currentPasswordField.layer.borderWidth = 1.0f;
    _currentPasswordField.layer.borderColor = [[UIColor blackColor] CGColor];
    _currentPasswordField.backgroundColor = [UIColor whiteColor];
    _currentPasswordField.layer.sublayerTransform = CATransform3DMakeTranslation(12.0, 0, 0);
    _currentPasswordField.placeholder = @"Current Password";
    [_scrollView addSubview:_currentPasswordField];
    
    _updatePassword = [[UILabel alloc] init];
    _updatePassword.text = @"🔐";
    _updatePassword.numberOfLines = 1;
    _updatePassword.font = [UIFont systemFontOfSize:24.0f];
    [_scrollView addSubview:_updatePassword];
    _updatePasswordField = [[UITextField alloc] init];
    _updatePasswordField.layer.cornerRadius = 10;
    _updatePasswordField.layer.masksToBounds = YES;
    _updatePasswordField.layer.borderWidth = 1.0f;
    _updatePasswordField.layer.borderColor = [[UIColor blackColor] CGColor];
    _updatePasswordField.backgroundColor = [UIColor whiteColor];
    _updatePasswordField.layer.sublayerTransform = CATransform3DMakeTranslation(12.0, 0, 0);
    _updatePasswordField.placeholder = @"New Password";
    [_scrollView addSubview:_updatePasswordField];
    
    _savePassword = [[UIButton alloc] init];
    [_savePassword setTitle: @"Save Password" forState: UIControlStateNormal];
    _savePassword.backgroundColor = [[Util sharedManager] colorWithHexString:[Util getBlueColorHex]];
    _savePassword.titleLabel.font = [UIFont systemFontOfSize:30.0f weight:UIFontWeightMedium];
    _savePassword.layer.cornerRadius = 10;
    _savePassword.layer.masksToBounds = YES;
    [_savePassword addTarget:self action:@selector(tapSavePassword:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_savePassword];

}

- (void)viewWillLayoutSubviews {
    self.scrollView.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height);
    [self.displayName sizeToFit];
    [self.username sizeToFit];
    [self.currentPassword sizeToFit];
    [self.updatePassword sizeToFit];

    CGSize textSize = [self.displayName.text boundingRectWithSize:CGSizeMake(self.displayName.frame.size.width, MAXFLOAT)
                                                          options:NSStringDrawingUsesLineFragmentOrigin
                                                       attributes:@{NSFontAttributeName:self.displayName.font}
                                                          context:nil].size;
    self.displayNameField.frame = CGRectMake(20.0 + self.displayName.frame.size.width + 12.0,
                                             15.0,
                                             self.view.frame.size.width - 20.0 - self.displayName.frame.size.width - 12.0 - self.displayName.frame.origin.x,
                                             40.0);
    self.displayName.frame = CGRectMake(20.0,
                                        self.displayNameField.frame.origin.y + (self.displayNameField.frame.size.height - self.displayName.frame.size.height) / 2,
                                        self.displayName.frame.size.width,
                                        textSize.height);
    
    textSize = [self.username.text boundingRectWithSize:CGSizeMake(self.username.frame.size.width, MAXFLOAT)
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:@{NSFontAttributeName:self.username.font}
                                                context:nil].size;
    self.usernameField.frame = CGRectMake(self.displayNameField.frame.origin.x,
                                          self.displayNameField.frame.origin.y + self.displayNameField.frame.size.height + 8.0,
                                          self.view.frame.size.width - 20.0 - self.username.frame.size.width - 12.0 - self.username.frame.origin.x,
                                          40.0);
    self.username.frame = CGRectMake(20.0,
                                     self.usernameField.frame.origin.y + (self.usernameField.frame.size.height - self.username.frame.size.height) / 2,
                                     self.username.frame.size.width,
                                     textSize.height);
    self.saveProfile.frame = CGRectMake(20.0,
                                 self.usernameField.frame.origin.y + self.usernameField.frame.size.height + 25.0,
                                 self.view.frame.size.width - 40.0,
                                 50.0);
    
    textSize = [self.currentPassword.text boundingRectWithSize:CGSizeMake(self.currentPassword.frame.size.width, MAXFLOAT)
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:@{NSFontAttributeName:self.currentPassword.font}
                                                context:nil].size;
    self.currentPasswordField.frame = CGRectMake(self.currentPassword.frame.origin.x + self.currentPassword.frame.size.width + 12.0,
                                                 self.saveProfile.frame.origin.y + self.saveProfile.frame.size.height + 20.0,
                                                 self.view.frame.size.width - 20.0 - self.currentPassword.frame.size.width - 12.0 - self.currentPassword.frame.origin.x,
                                                 40.0);
    self.currentPassword.frame = CGRectMake(20.0,
                                     self.currentPasswordField.frame.origin.y + (self.currentPasswordField.frame.size.height - self.currentPassword.frame.size.height) / 2,
                                     self.currentPassword.frame.size.width,
                                     textSize.height);
    textSize = [self.updatePassword.text boundingRectWithSize:CGSizeMake(self.updatePassword.frame.size.width, MAXFLOAT)
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:@{NSFontAttributeName:self.updatePassword.font}
                                                context:nil].size;
    self.updatePasswordField.frame = CGRectMake(self.updatePassword.frame.origin.x + self.updatePassword.frame.size.width + 12.0,
                                                self.currentPasswordField.frame.origin.y + self.currentPasswordField.frame.size.height + 8.0,
                                                self.view.frame.size.width - 20.0 - self.updatePassword.frame.size.width - 12.0 - self.updatePassword.frame.origin.x,
                                                40.0);
    self.updatePassword.frame = CGRectMake(20.0,
                                     self.updatePasswordField.frame.origin.y + (self.updatePasswordField.frame.size.height - self.currentPassword.frame.size.height) / 2,
                                     self.updatePassword.frame.size.width,
                                     textSize.height);
    
    self.savePassword.frame = CGRectMake(20.0,
                                 self.updatePasswordField.frame.origin.y + self.updatePasswordField.frame.size.height + 25.0,
                                 self.view.frame.size.width - 40.0,
                                 50.0);
    
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.savePassword.frame.origin.y + self.savePassword.frame.size.height + 12.0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Listeners

- (void)tapSaveProfile:(UIButton *)sender {
    NSString *displayName = _displayNameField.text;
    NSString *username = _usernameField.text;
    if (displayName != _user.displayName || username != _user.username) {
        _user.displayName = displayName;
        _user.username = username;
        [_user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (succeeded) {
                [self dismissViewControllerAnimated:YES completion:nil];
            } else {
                NSLog(@"%@", error);
            }
        }];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)tapSavePassword:(UIButton *)sender {
    NSString *currentPassword = _currentPasswordField.text;
    if (currentPassword != _user.password) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Current Password"
                                                                       message:@"The current password is incorrect."
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        NSString *newPassword = _updatePasswordField.text;
        if (newPassword == currentPassword) {
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"New Password"
                                                                           message:@"Enter a password that is different than your current password."
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {}];
            [alert addAction:okAction];
            [self presentViewController:alert animated:YES completion:nil];
        } else {
            [_user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if (succeeded) {
                    [self dismissViewControllerAnimated:YES completion:nil];
                } else {
                    NSLog(@"%@", error);
                }
            }];
        }
    }
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
