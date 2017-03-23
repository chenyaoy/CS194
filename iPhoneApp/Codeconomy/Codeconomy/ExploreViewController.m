//
//  ViewController.m
//  Codeconomy
//
//  Created by studio on 2/5/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import "ExploreViewController.h"
#import "ExploreCollectionViewCell.h"
#import "ListingsDetailViewController.h"
#import "ListingsTableViewCell.h"
#import "SearchViewController.h"
#import "Coupon.h"
#import "Util.h"
#import <Parse/Parse.h>

@interface ExploreViewController () <UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSMutableArray *allListings;
@property (nonatomic, strong) NSMutableArray *allCategories;
@property (nonatomic, strong) NSMutableArray *allEmojis;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UICollectionView *categories;
@property (nonatomic, strong) UILabel *whatsNew;
@property (nonatomic, strong) UITableView *couponTableView;
@end

@implementation ExploreViewController

- (instancetype)initWithUser:(User *)user {
    self = [super init];
    if (self) {
        _user = user;
        
        _price = [[UILabel alloc] init];
        _price.text = [NSString stringWithFormat:@"%d🔑", self.user.credits];
        _searchBar = [[UISearchBar alloc] init];
        _searchBar.delegate = self;
        _searchBar.backgroundImage = [[UIImage alloc] init];
        _searchBar.placeholder = @"Search for coupons";
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setItemSize:CGSizeMake(160.0, 100.0)];
        flowLayout.minimumInteritemSpacing = 15.0;
        flowLayout.minimumLineSpacing = 15.0;
        [self.categories setCollectionViewLayout:flowLayout];
        _categories = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _categories.delegate = self;
        _categories.dataSource = self;
        
        _whatsNew = [[UILabel alloc] init];
        _whatsNew.text = @"What's New";
        _whatsNew.font = [UIFont systemFontOfSize:18.0f];
        
        _couponTableView = [[UITableView alloc] init];
        _couponTableView.delegate = self;
        _couponTableView.dataSource = self;
        [_couponTableView setBackgroundColor:[[Util sharedManager] colorWithHexString:@"F7F7F7"]];
        _couponTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _couponTableView.showsVerticalScrollIndicator = NO;
        _allListings = [[NSMutableArray alloc] init];
        _allCategories = [[NSMutableArray alloc] init];
        _allEmojis = [[NSMutableArray alloc] init];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(reloadUserData:)
                                                     name:@"reloadUserData"
                                                   object:nil];
        [self loadMockData];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor: [[Util sharedManager] colorWithHexString:@"F7F7F7"]];
    [_price sizeToFit];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.price];
    self.navigationItem.rightBarButtonItem = item;
    [self.view addSubview:_searchBar];
    [[UITextField appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_categories];
    [self.categories setBackgroundColor:[[Util sharedManager] colorWithHexString:@"F7F7F7"]];
    [self.categories registerClass:[ExploreCollectionViewCell class] forCellWithReuseIdentifier:@"cvCell"];
    
    [self.view addSubview:_whatsNew];
    [_whatsNew sizeToFit];
    [self.view addSubview:_couponTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadMockData];
}

- (void)viewWillLayoutSubviews {
    self.searchBar.frame = CGRectMake(20.0, self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.frame.size.height + 15.0, self.view.frame.size.width - 40.0, 28.0);
    self.categories.frame = CGRectMake(20.0, self.searchBar.frame.origin.y + self.searchBar.frame.size.height + 15.0, self.view.frame.size.width - 40.0, 215.0);
    self.whatsNew.frame = CGRectMake(20.0, self.categories.frame.origin.y + self.categories.frame.size.height + 25.0, self.whatsNew.frame.size.width, self.whatsNew.frame.size.height);
    self.couponTableView.frame = CGRectMake(20.0, self.whatsNew.frame.origin.y + self.whatsNew.frame.size.height + 15.0, self.view.frame.size.width - 40.0, self.tabBarController.tabBar.frame.origin.y - (self.whatsNew.frame.origin.y + self.whatsNew.frame.size.height + 30.0));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cvCell";
    
    ExploreCollectionViewCell *cell = (ExploreCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    NSString *categoryName = [self.allCategories objectAtIndex:indexPath.section * 2 + indexPath.row];
    NSString *emojiName = [self.allEmojis objectAtIndex:indexPath.section * 2 + indexPath.row];
    [(ExploreCollectionViewCell *)cell setCategory:categoryName emoji:emojiName];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(collectionView.frame.size.width, 15.0);
    }
    return CGSizeZero;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    SearchViewController *searchVC = [[SearchViewController alloc] initWithUser:self.user withCategory:[self.allCategories objectAtIndex:indexPath.section * 2 + indexPath.row]];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] init];
    barButton.title = @"Back";
    self.navigationItem.backBarButtonItem = barButton;
    searchVC.navigationItem.title = [self.allCategories objectAtIndex:indexPath.section * 2 + indexPath.row];
    [self.navigationController pushViewController:searchVC animated:YES];
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
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
    return 60.0;
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

#pragma mark - Mock Data

- (void)loadMockData {
    [self.allCategories addObject:@"Clothing"];
    [self.allCategories addObject:@"Concerts"];
    [self.allCategories addObject:@"Food"];
    [self.allCategories addObject:@"Electronics"];
    
    [self.allEmojis addObject:@"👖"];
    [self.allEmojis addObject:@"🎟"];
    [self.allEmojis addObject:@"🍽"];
    [self.allEmojis addObject:@"🖥"];
    
//    Coupon *coupon1 = [[Coupon alloc] initWithCouponId:1 sellerId:1 status:1 price:2 expirationDate:[NSDate date] createdDate:[[NSDate date] dateByAddingTimeInterval:-3600*4] storeName:@"J.Crew" title:@"30% off ANY ITEM" couponDescription:@"excludes sale items" code:@"adsfkljsdfjksdhf" deleted:0];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Coupon"];
    [query whereKey:@"status" equalTo:@1];
    [query whereKey:@"seller" notEqualTo:self.user];
    [query includeKey:@"seller"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError * error) {
        if(!error) {
            self.allListings = objects.mutableCopy;
            [self.couponTableView reloadData];
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

@end
