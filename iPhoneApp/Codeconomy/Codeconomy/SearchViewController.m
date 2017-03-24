//
//  SearchViewController.m
//  Codeconomy
//
//  Created by studio on 3/22/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import "SearchViewController.h"
#import "ListingsTableViewCell.h"
#import "ListingsDetailViewController.h"
#import "Coupon.h"
#import "Util.h"
#import <Parse/Parse.h>

@interface SearchViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSString *searchString;
@property (nonatomic, strong) UITableView *listings;
@property (nonatomic, strong) NSMutableArray *allListings;
@end

@implementation SearchViewController

- (instancetype)initWithUser:(User *)user withCategory:(NSString *)category {
    self = [super init];
    if (self) {
        _user = user;
        _category = category;
    }
    return self;
}

- (instancetype)initWithUser:(User *)user withSearchString:(NSString *)str {
    self = [super init];
    if (self) {
        _user = user;
        _searchString = str;
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
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self pullData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews {
    self.listings.frame = CGRectMake(20.0, self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.frame.size.height + 15.0, self.view.frame.size.width - 40.0, self.tabBarController.tabBar.frame.origin.y - (self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.frame.size.height + 30.0));
}

- (void)pullData {
    if (self.category) {
        PFQuery *query = [PFQuery queryWithClassName:@"Coupon"];
        [query whereKey:@"seller" notEqualTo:self.user];
        [query whereKey:@"status" equalTo:@1];
        [query whereKey:@"deleted" equalTo:@NO];
        [query whereKey:@"category" equalTo:self.category];
        [query includeKey:@"seller"];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError * error) {
            if(!error) {
                self.allListings = objects.mutableCopy;
                [self.listings reloadData];
            } else {
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];
    } else {
        PFQuery *query1 = [PFQuery queryWithClassName:@"Coupon"];
        [query1 whereKey:@"storeName" containsString:self.searchString];
        [query1 whereKey:@"seller" notEqualTo:self.user];
        [query1 whereKey:@"status" equalTo:@1];
        [query1 whereKey:@"deleted" equalTo:@NO];
        
        PFQuery *query2 = [PFQuery queryWithClassName:@"Coupon"];
        [query2 whereKey:@"couponDescription" containsString:self.searchString];
        [query2 whereKey:@"seller" notEqualTo:self.user];
        [query2 whereKey:@"status" equalTo:@1];
        [query2 whereKey:@"deleted" equalTo:@NO];
        
        PFQuery *query3 = [PFQuery queryWithClassName:@"Coupon"];
        [query3 whereKey:@"additionalInfo" containsString:self.searchString];
        [query3 whereKey:@"seller" notEqualTo:self.user];
        [query3 whereKey:@"status" equalTo:@1];
        [query3 whereKey:@"deleted" equalTo:@NO];
        
        NSArray *arrQuery = [[NSArray alloc] initWithObjects:query1, query2, query3, nil];
        PFQuery *query = [PFQuery orQueryWithSubqueries:arrQuery];
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
    ListingsDetailViewController *listingDetailsVC = [[ListingsDetailViewController alloc] initWithCoupon:[self.allListings objectAtIndex:indexPath.section] buy:YES user:self.user];
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
