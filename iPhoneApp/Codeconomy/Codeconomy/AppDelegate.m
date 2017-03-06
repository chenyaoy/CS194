//
//  AppDelegate.m
//  Codeconomy
//
//  Created by studio on 2/5/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import "AppDelegate.h"
#import "ExploreViewController.h"
#import "ProfileViewController.h"
#import "ListingsViewController.h"
#import "User.h"
#import "Coupon.h"
#import "Transaction.h"
#import <Parse/Parse.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Parse initializeWithConfiguration:[ParseClientConfiguration configurationWithBlock:^(id<ParseMutableClientConfiguration> configuration) {
        configuration.applicationId = @"codeconomy";
        configuration.clientKey = @"";
        configuration.server = @"http://codeconomy.herokuapp.com/parse";
    }]];
    // [self addMockUser];
    User *currentUser = [[[PFQuery queryWithClassName:@"_User"] whereKey:@"username" equalTo:@"garythung"] getFirstObject];
    [PFUser logInWithUsername:@"garythung" password:@"garythung"];
//    [self addMockTransaction];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UINavigationController *exploreViewController = [[UINavigationController alloc] initWithRootViewController:[[ExploreViewController alloc] initWithUser:currentUser]];
    UINavigationController *couponsViewController = [[UINavigationController alloc] initWithRootViewController:[[ListingsViewController alloc] initWithUser:currentUser]];
    UINavigationController *profileViewController = [[UINavigationController alloc] initWithRootViewController:[[ProfileViewController alloc] initWithUser:currentUser]];
    
    exploreViewController.navigationBar.topItem.title = @"Explore";
    couponsViewController.navigationBar.topItem.title = @"My Listings";
    profileViewController.navigationBar.topItem.title = @"Me";
    
    NSString *exploreEmoji = @"🏬";
    NSString *couponsEmoji = @"🏷";
    NSString *profileEmoji = @"🌚";
    
    exploreViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Explore" image:[self hg_imageFromString:exploreEmoji] tag:1];
    couponsViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Coupons" image:[self hg_imageFromString:couponsEmoji] tag:2];
    profileViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Profile" image:[self hg_imageFromString:profileEmoji] tag:3];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[exploreViewController, couponsViewController, profileViewController];
    
    self.window.rootViewController = tabBarController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (UIImage *) hg_imageFromView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (UIImage *) hg_imageFromString:(NSString *)str
{
    UILabel *label = [[UILabel alloc] init];
    label.text = str;
    label.opaque = NO;
    label.backgroundColor = UIColor.clearColor;
    CGSize measuredSize = [str sizeWithAttributes:@{NSFontAttributeName: label.font}];
    label.frame = CGRectMake(0, 0, measuredSize.width, measuredSize.height);
    return [self hg_imageFromView:label];
}

- (void) addMockUser {
    User *gary = [[User alloc] initWithUsername:@"garythung" password:@"garythung" displayName:@"Gary Thung" status:0 credits:36 rating:5.0];
    [gary signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"sick");
        } else {
            NSLog(@"fuck");
        }
    }];
    User *will = [[User alloc] initWithUsername:@"whuang" password:@"whuang" displayName:@"Will Huang" status:0 credits:5 rating:5.0];
    [will signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"sick");
        } else {
            NSLog(@"fuck");
        }
    }];
}

- (void) addMockTransaction {
    User *buyer = [[[PFQuery queryWithClassName:@"_User"] whereKey:@"username" equalTo:@"garythung"] getFirstObject];
    User *seller = [[[PFQuery queryWithClassName:@"_User"] whereKey:@"username" equalTo:@"whuang"] getFirstObject];
    Coupon *coupon = [[Coupon alloc] initWithSeller:seller status:0 price:3 expirationDate:[NSDate date] storeName:@"testStore" couponDescription:@"1 free item" additionalInfo:@"less than $50" code:@"freeitem50" category:@"Clothing" deleted:false];
    
    [coupon saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"sick");
        } else {
            NSLog(@"fuck");
        }
    }];
    Transaction *transaction = [[Transaction alloc] initWithBuyer:buyer seller:seller coupon:coupon transactionDate:[NSDate date] reviewDescription:nil stars:-1];
    [transaction saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"sick");
        } else {
            NSLog(@"fuck");
        }
    }];
}

@end
