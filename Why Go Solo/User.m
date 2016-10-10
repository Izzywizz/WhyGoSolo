//
//  User.m
//  Why Go Solo
//
//  Created by Andy Chamberlain on 19/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "User.h"

@implementation User

-(User*)initWithDict:(NSDictionary*)dict
{
    if (self)
    {
        self.userID = (int)[[dict valueForKey:@"id"]integerValue];

        self.firstName = [dict valueForKey:@"first_name"];
        self.lastName = [dict valueForKey:@"last_name"];
        
        self.userName = [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
    }
    return self;
}


@end
