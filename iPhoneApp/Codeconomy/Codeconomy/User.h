//
//  User.h
//  Codeconomy
//
//  Created by studio on 2/26/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import <Parse/Parse.h>

@interface User : PFUser <PFSubclassing>
@property (retain) NSString *displayName;
@property int status;
@property int credits;
@property float rating;
- (instancetype)initWithUsername:(NSString *)username
                        password:(NSString *)password
                     displayName:(NSString *)displayName
                          status:(int)status
                         credits:(int)credits
                          rating:(float)rating;
@end
