//
//  KeysViewController.m
//  Codeconomy
//
//  Created by Gary on 03/12/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import "KeysViewController.h"
#import "KeysOwnedView.h"
#import "KeysBuyingOptionsView.h"
#import "Util.h"

@interface KeysViewController ()
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) KeysOwnedView *ownedView;
@property (nonatomic, strong) KeysBuyingOptionsView *buyingOptionsView;

@property (nonatomic, strong) UIButton *buy;
@end

@implementation KeysViewController

- (instancetype)initWithUser:(User *)user {
    self = [super init];
    if (self) {
        _user = user;
        
        _ownedView = [[KeysOwnedView alloc] initWithCredits:user.credits];
        _buyingOptionsView = [[KeysBuyingOptionsView alloc] init];
        
        _buy = [[UIButton alloc] init];
        [_buy addTarget:self action:@selector(tapBuy:) forControlEvents:UIControlEventTouchUpInside];
        [_buy setTitle: @"Buy" forState: UIControlStateNormal];
        _buy.titleLabel.font = [UIFont systemFontOfSize:24.0 weight:UIFontWeightRegular];
        _buy.backgroundColor = [[Util sharedManager] colorWithHexString:[Util getBlueColorHex]];
        _buy.layer.cornerRadius = 10;
        _buy.layer.masksToBounds = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[[Util sharedManager] colorWithHexString:[Util getLightGrayColorHex]]];
    
    [self.view addSubview:_ownedView];
    [self.view addSubview:_buyingOptionsView];
    [self.view addSubview:_buy];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews {
    [self.buy sizeToFit];
    self.ownedView.frame = CGRectMake(20.0,
                                      self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.frame.size.height + 15.0,
                                      self.view.frame.size.width - 40.0,
                                      12.0 + [self.ownedView getKeysLabelSize].height + 12.0);
    self.buyingOptionsView.frame = CGRectMake(20.0,
                                      self.ownedView.frame.origin.y + self.ownedView.frame.size.height + 8.0,
                                      self.view.frame.size.width - 40.0,
                                      384.0);
    self.buy.frame = CGRectMake(20.0,
                                self.buyingOptionsView.frame.origin.y + self.buyingOptionsView.frame.size.height + 15.0,
                                self.view.frame.size.width - 40.0,
                                40.0);

}

#pragma mark - Helpers


#pragma mark - Listeners

- (void)tapBuy:(UIButton *)sender {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Purchase"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    int keyQuantity = self.buyingOptionsView.getKeyQuantity;
    if (keyQuantity == -1) {
        [alert setMessage:@"You haven't selected how many keys you want to buy!"];
        UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
                                                             return;
                                                         }];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
    } else if (!self.buyingOptionsView.hasValidCardEntry) {
        [alert setMessage:@"The card information is not complete."];
        UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
                                                             return;
                                                         }];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        [alert setMessage:[NSString stringWithFormat:@"Are you sure you want to buy %d🔑?", keyQuantity]];
        
        UIAlertAction* yesAction = [UIAlertAction actionWithTitle:@"Yes"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              User *user = [User currentUser];
                                                              user.credits += keyQuantity;
                                                              [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                                                                  if (succeeded) {
                                                                      [[NSNotificationCenter defaultCenter]
                                                                       postNotificationName:@"reloadUserData"
                                                                       object:self];
                                                                      [[self navigationController] popViewControllerAnimated:YES];
                                                                      self.tabBarController.selectedIndex = 0;
                                                                  } else {
                                                                      NSLog(@"failed to buy keys");
                                                                  }
                                                              }];
                                                          }];
        UIAlertAction* noAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action) {}];
        [alert addAction:yesAction];
        [alert addAction:noAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark - Keyboard
- (void)keyboardWillShow:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = -keyboardSize.height;
        self.view.frame = f;
    }];
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = 0.0f;
        self.view.frame = f;
    }];
}

-(void)dismissKeyboard
{
    [self.view endEditing:YES];
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
