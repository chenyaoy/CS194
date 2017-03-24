//
//  ListingsViewController.m
//  Codeconomy
//
//  Created by studio on 2/12/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import "ListingsViewController.h"
#import "ListingsTableViewCell.h"
#import "ListingsDetailViewController.h"
#import "NewListingViewController.h"
#import "Coupon.h"
#import "Util.h"
#import <Parse/Parse.h>

@interface ListingsViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) UITableView *listings;
@property (nonatomic, strong) NSMutableArray *allListings;
@end

@implementation ListingsViewController

- (instancetype)initWithUser:(User *)user {
    self = [super init];
    if (self) {
        _user = user;
        
        UIBarButtonItem *postListing = [[UIBarButtonItem alloc] initWithTitle:@"New" style:UIBarButtonItemStylePlain target:self action:@selector(refreshPropertyList:)];
        self.navigationItem.rightBarButtonItem = postListing;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(reloadUserData:)
                                                     name:@"postedCoupon"
                                                   object:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _listings = [[UITableView alloc] init];
    _listings.delegate = self;
    _listings.dataSource = self;
    [_listings setBackgroundColor:[[Util sharedManager] colorWithHexString:@"F7F7F7"]];
    _listings.separatorStyle = UITableViewCellSeparatorStyleNone;
    _listings.contentInset = UIEdgeInsetsMake(-36, 0, 0, 0);
    [self.view addSubview:_listings];
    _allListings = [[NSMutableArray alloc] init];
    [self.view setBackgroundColor: [[Util sharedManager] colorWithHexString:@"F7F7F7"]];
    
    [self generateMockData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self generateMockData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews {
    self.listings.frame = CGRectMake(20.0, self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.frame.size.height - 8.0, self.view.frame.size.width - 40.0, self.tabBarController.tabBar.frame.origin.y - (self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.frame.size.height + 30.0));
}

- (void)generateMockData {
    PFQuery *query = [PFQuery queryWithClassName:@"Coupon"];
    [query whereKey:@"seller" equalTo:self.user];
    [query whereKey:@"status" equalTo:@1];
    [query whereKey:@"deleted" equalTo:@NO];
    [query includeKey:@"seller"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError * error) {
        if(!error) {
            self.allListings = objects.mutableCopy;
            [self.listings reloadData];
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.allListings count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[ListingsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [(ListingsTableViewCell *)cell setCoupon:[self.allListings objectAtIndex:indexPath.section]];
    return cell;
}

#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ListingsDetailViewController *listingDetailsVC = [[ListingsDetailViewController alloc] initWithCoupon:[self.allListings objectAtIndex:indexPath.section] buy:NO user:self.user];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] init];
    barButton.title = @"Back";
    self.navigationItem.backBarButtonItem = barButton;
    [self.navigationController pushViewController:listingDetailsVC animated:YES];
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
    [self generateMockData];
}

#pragma mark - Segue

- (void)refreshPropertyList:(UIBarButtonItem *)button {
    NewListingViewController *newListing = [[NewListingViewController alloc] initWithUser:self.user];
    [self presentViewController:newListing animated:YES completion:nil];
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
