//
//  LoginSignupViewController.m
//  Codeconomy
//
//  Created by studio on 3/12/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import "LoginSignupViewController.h"
#import "Util.h"
#import "User.h"
#import <Parse/Parse.h>

@interface LoginSignupViewController ()

@property (nonatomic, strong) UILabel *codeconomy;
@property (nonatomic, strong) UILabel *codeconomyDescription;

@property (nonatomic, strong) UIButton *signUp;
@property (nonatomic, strong) UIButton *login;
@property (nonatomic, strong) UIButton *currentButton;

@property (nonatomic, strong) UITextField *username;
@property (nonatomic, strong) UITextField *password;
@property (nonatomic, strong) UITextField *displayName;
@property (nonatomic, strong) UIButton *go;

@end

@implementation LoginSignupViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        _codeconomy = [[UILabel alloc] init];
        _codeconomy.text = @"Codeconomy";
        _codeconomy.font = [UIFont systemFontOfSize:48.0 weight:UIFontWeightMedium];
        _codeconomyDescription = [[UILabel alloc] init];
        _codeconomyDescription.text = @"Get the codes that\nyou want and make\nuse of the ones that\nyou don't need.";
        _codeconomyDescription.font = [UIFont systemFontOfSize:24.0 weight:UIFontWeightRegular];
        _codeconomyDescription.textAlignment = NSTextAlignmentCenter;
        _codeconomyDescription.numberOfLines = 4;
        
        _signUp = [[UIButton alloc] init];
        [_signUp setTitle:@"Sign Up" forState:UIControlStateNormal];
        [_signUp setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_signUp addTarget:self action:@selector(tapSignUpLogin:) forControlEvents:UIControlEventTouchUpInside];
        _signUp.titleLabel.textAlignment = NSTextAlignmentCenter;
        _signUp.titleLabel.font = [UIFont systemFontOfSize:30.0];
        _signUp.layer.cornerRadius = 10;
        _signUp.layer.masksToBounds = YES;
        _signUp.layer.borderWidth = 2.0f;
        _signUp.layer.borderColor = [UIColor grayColor].CGColor;
        _signUp.backgroundColor = [UIColor whiteColor];
        _login = [[UIButton alloc] init];
        [_login setTitle:@"Login" forState:UIControlStateNormal];
        [_login setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_login addTarget:self action:@selector(tapSignUpLogin:) forControlEvents:UIControlEventTouchUpInside];
        _login.titleLabel.textAlignment = NSTextAlignmentCenter;
        _login.titleLabel.font = [UIFont systemFontOfSize:30.0];
        _login.layer.cornerRadius = 10;
        _login.layer.masksToBounds = YES;
        _login.layer.borderWidth = 2.0f;
        _login.layer.borderColor = [UIColor grayColor].CGColor;
        _login.layer.opacity = 0.33;
        _login.backgroundColor = [UIColor whiteColor];
        _currentButton = _signUp;
        
        _username = [[UITextField alloc] init];
        _username.placeholder = @"Username";
        _username.layer.cornerRadius = 10;
        _username.layer.masksToBounds = YES;
        _username.layer.borderWidth = 2.0f;
        _username.layer.borderColor = [UIColor grayColor].CGColor;
        _username.backgroundColor = [UIColor whiteColor];
        _username.layer.sublayerTransform = CATransform3DMakeTranslation(12.0, 0, 0);
        _password = [[UITextField alloc] init];
        _password.placeholder = @"Password";
        _password.layer.cornerRadius = 10;
        _password.layer.masksToBounds = YES;
        _password.layer.borderWidth = 2.0f;
        _password.layer.borderColor = [UIColor grayColor].CGColor;
        _password.backgroundColor = [UIColor whiteColor];
        _password.layer.sublayerTransform = CATransform3DMakeTranslation(12.0, 0, 0);
        _displayName = [[UITextField alloc] init];
        _displayName.placeholder = @"Display Name";
        _displayName.layer.cornerRadius = 10;
        _displayName.layer.masksToBounds = YES;
        _displayName.layer.borderWidth = 2.0f;
        _displayName.layer.borderColor = [UIColor grayColor].CGColor;
        _displayName.backgroundColor = [UIColor whiteColor];
        _displayName.layer.sublayerTransform = CATransform3DMakeTranslation(12.0, 0, 0);
        
        _go = [[UIButton alloc] init];
        [_go setTitle:@"Go!" forState:UIControlStateNormal];
        [_go setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_go addTarget:self action:@selector(tapGo:) forControlEvents:UIControlEventTouchUpInside];
        _go.titleLabel.textAlignment = NSTextAlignmentCenter;
        _go.titleLabel.font = [UIFont systemFontOfSize:24.0 weight:UIFontWeightMedium];
        _go.layer.cornerRadius = 10;
        _go.layer.masksToBounds = YES;
        _go.backgroundColor = [[Util sharedManager] colorWithHexString:@"9FCBFE"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor: [[Util sharedManager] colorWithHexString:@"F7F7F7"]];
    [self.view addSubview:self.codeconomy];
    [self.view addSubview:self.codeconomyDescription];
    [self.view addSubview:self.signUp];
    [self.view addSubview:self.login];
    [self.view addSubview:self.username];
    [self.view addSubview:self.password];
    [self.view addSubview:self.displayName];
    [self.view addSubview:self.go];
}

- (void)viewWillLayoutSubviews {
    [self.codeconomy sizeToFit];
    self.codeconomy.frame = CGRectMake(self.view.frame.size.width / 2.0 - self.codeconomy.frame.size.width / 2.0, [UIApplication sharedApplication].statusBarFrame.size.height + 12.0, self.codeconomy.frame.size.width, self.codeconomy.frame.size.height);
    CGSize textSize = [self.codeconomyDescription.text sizeWithFont:self.codeconomyDescription.font
                                      constrainedToSize:CGSizeMake(self.codeconomyDescription.frame.size.width, MAXFLOAT)
                                          lineBreakMode:self.codeconomyDescription.lineBreakMode];
    self.codeconomyDescription.frame = CGRectMake(self.view.frame.size.width / 2.0 - self.codeconomyDescription.frame.size.width / 2.0, self.codeconomy.frame.origin.y + self.codeconomy.frame.size.height + 20.0, self.view.frame.size.width - 40.0, textSize.height);
    self.signUp.frame = CGRectMake(20.0, self.codeconomyDescription.frame.origin.y + self.codeconomyDescription.frame.size.height + 50.0, 163.0, 60.0);
    self.login.frame = CGRectMake(self.view.frame.size.width - 20.0 - 163.0, self.signUp.frame.origin.y, 163.0, 60.0);
    self.username.frame = CGRectMake(20.0, self.signUp.frame.origin.y + self.signUp.frame.size.height + 20.0, self.view.frame.size.width - 40.0, 40.0);
    self.password.frame = CGRectMake(20.0, self.username.frame.origin.y + self.username.frame.size.height + 8.0, self.view.frame.size.width - 40.0, 40.0);
    if (self.currentButton == self.signUp) {
        self.displayName.hidden = NO;
        self.displayName.frame = CGRectMake(20.0, self.password.frame.origin.y + self.password.frame.size.height + 8.0, self.view.frame.size.width - 40.0, 40.0);
        self.go.frame = CGRectMake(self.view.frame.size.width - 110.0, self.displayName.frame.origin.y + self.displayName.frame.size.height + 8.0, 90.0, 40.0);
    } else {
        self.displayName.hidden = YES;
        self.go.frame = CGRectMake(self.view.frame.size.width - 110.0, self.password.frame.origin.y + self.password.frame.size.height + 8.0, 90.0, 40.0);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Listeners

- (void)tapSignUpLogin:(UIButton *)sender {
    if (sender == self.signUp) {
        self.signUp.layer.opacity = 1.0;
        self.login.layer.opacity = 0.33;
        self.currentButton = self.signUp;
    } else {
        self.login.layer.opacity = 1.0;
        self.signUp.layer.opacity = 0.33;
        self.currentButton = self.login;
    }
    [self.view setNeedsLayout];
}

- (void)tapGo:(UIButton *)sender {
    
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
