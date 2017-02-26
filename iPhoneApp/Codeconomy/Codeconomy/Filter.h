//
//  Filter.h
//  Codeconomy
//
//  Created by studio on 2/26/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import <Parse/Parse.h>

@interface Filter : PFObject<PFSubclassing>
+ (NSString *)parseClassName;
@property int category;
@property (retain) NSString *couponId;
- (instancetype)initWithCategory:(int)category
                       couponId:(NSString *)couponId;
@end
