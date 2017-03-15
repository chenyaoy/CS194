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
#import "KeysCardEntryView.h"
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
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[[Util sharedManager] colorWithHexString:[Util getLightGrayColorHex]]];
    
    [self.view addSubview:_ownedView];
    [self.view addSubview:_buyingOptionsView];
    
    _buy.titleLabel.font = [UIFont systemFontOfSize:30.0f weight:UIFontWeightMedium];
    _buy.layer.cornerRadius = 10;
    _buy.layer.masksToBounds = YES;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews {
    self.ownedView.frame = CGRectMake(20.0,
                                      self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.frame.size.height + 15.0,
                                      self.view.frame.size.width - 40.0,
                                      12.0 + [self.ownedView getKeysLabelSize].height + 12.0);
    self.buyingOptionsView.frame = CGRectMake(20.0,
                                      self.ownedView.frame.origin.y + self.ownedView.frame.size.height + 8.0,
                                      self.view.frame.size.width - 40.0,
                                      404.0);
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
