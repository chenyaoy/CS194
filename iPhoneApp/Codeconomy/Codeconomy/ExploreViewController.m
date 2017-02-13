//
//  ViewController.m
//  Codeconomy
//
//  Created by studio on 2/5/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import "ExploreViewController.h"
#import "Util.h"

@interface ExploreViewController ()

@end

@implementation ExploreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor: [[Util sharedManager] colorWithHexString:@"F7F7F7"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
