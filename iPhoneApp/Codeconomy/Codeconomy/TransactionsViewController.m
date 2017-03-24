//
//  TransactionsViewController.m
//  Codeconomy
//
//  Created by Gary on 03/05/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import "TransactionsViewController.h"
#import "TransactionsTableViewCell.h"
#import "TransactionsDetailViewController.h"
#import "Transaction.h"
#import "Util.h"

@interface TransactionsViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UITableView *transactions;
@property (nonatomic, strong) NSMutableArray *allTransactions;
@end

@implementation TransactionsViewController

- (instancetype)initWithUser:(User *)user {
    self = [super init];
    if (self) {
        _user = user;
        
        _price = [[UILabel alloc] init];
        _price.text = [NSString stringWithFormat:@"%d🔑", self.user.credits];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(reloadUserData:)
                                                     name:@"reloadUserData"
                                                   object:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.price setFont:[Util getRegularFont:17.0]];
    [_price sizeToFit];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.price];
    self.navigationItem.rightBarButtonItem = item;
    _transactions = [[UITableView alloc] init];
    _transactions.delegate = self;
    _transactions.dataSource = self;
    [_transactions setBackgroundColor:[[Util sharedManager] colorWithHexString:[Util getLightGrayColorHex]]];
    _transactions.separatorStyle = UITableViewCellSeparatorStyleNone;
    _transactions.contentInset = UIEdgeInsetsMake(-36, 0, 0, 0);
    [self.view addSubview:_transactions];
    _allTransactions = [[NSMutableArray alloc] init];
    [self.view setBackgroundColor: [[Util sharedManager] colorWithHexString:[Util getLightGrayColorHex]]];
    
    [self loadTransactions];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews {
    self.transactions.frame = CGRectMake(20.0, self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.frame.size.height - 8.0, self.view.frame.size.width - 40.0, self.tabBarController.tabBar.frame.origin.y - (self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.frame.size.height + 30.0));
}

- (void)loadTransactions {
    PFQuery *query1 = [PFQuery queryWithClassName:[Transaction parseClassName]];
    [query1 whereKey:@"buyer" equalTo:self.user];
    PFQuery *query2 = [PFQuery queryWithClassName:[Transaction parseClassName]];
    [query2 whereKey:@"seller" equalTo:self.user];
    NSArray *arrQuery = [[NSArray alloc] initWithObjects:query1, query2, nil];
    PFQuery *query = [PFQuery orQueryWithSubqueries:arrQuery];
    [query includeKey:@"buyer"];
    [query includeKey:@"seller"];
    [query includeKey:@"coupon"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError * error) {
        if(!error) {
            self.allTransactions = objects.mutableCopy;
            [self.transactions reloadData];
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.allTransactions count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[TransactionsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [(TransactionsTableViewCell *)cell setTransaction:[_allTransactions objectAtIndex:indexPath.section] user:self.user];
    return cell;
}

#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TransactionsDetailViewController *transactionDetailsVC = [[TransactionsDetailViewController alloc] initWithTransaction:[_allTransactions objectAtIndex:indexPath.section] user:self.user];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] init];
    barButton.title = @"Back";
    self.navigationItem.backBarButtonItem = barButton;
    [self.navigationController pushViewController:transactionDetailsVC animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 89.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 8.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

#pragma mark - Helpers

- (void)reloadUserData:(NSNotification *) notification {
    [self.user fetch];
    self.price.text = [NSString stringWithFormat:@"%d🔑", self.user.credits];
    [self.price sizeToFit];
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
