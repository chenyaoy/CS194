//
//  User.m
//  Codeconomy
//
//  Created by studio on 2/26/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import "User.h"

@implementation User
@dynamic displayName;
@dynamic status;
@dynamic credits;
@dynamic rating;

+ (void)load {
    [self registerSubclass];
}

- (instancetype)initWithUsername:(NSString *)username
                        password:(NSString *)password
                          status:(int)status
                         credits:(int)credits
                          rating:(float)rating {
    self = [super init];
    if (self) {
        self.username = username;
        self.password = password;
        self.status = status;
        self.credits = credits;
        self.rating = rating;
    }
    return self;
}
@end
