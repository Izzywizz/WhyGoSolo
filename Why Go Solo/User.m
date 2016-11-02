//
//  User.m
//  Why Go Solo
//
//  Created by Andy Chamberlain on 19/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "User.h"
#import "University.h"
#import "Residence.h"
#import "WebService.h"
@implementation User

-(User*)initWithDict:(NSDictionary*)dict
{
    if (self)
    {
        
        NSLog(@"USERINIT DICT = %@", dict);
        self.userID = [NSString stringWithFormat:@"%i",(int)[[dict valueForKey:@"id"]integerValue]];//(int)[[dict valueForKey:USER_PARAM_ID]integerValue];

        self.firstName = [dict valueForKey:USER_FIRST_NAME_KEY];
        self.lastName = [dict valueForKey:USER_LAST_NAME_KEY];
        
        self.userName = [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
        
        self.dobEpoch =   [NSString stringWithFormat:@"%i",(int)[[dict valueForKey:USER_PARAM_DOB_EPOCH]integerValue]];
        self.dobEpoch = [dict valueForKey:USER_PARAM_EMAIL];
        
        self.latitude = (long)[[dict valueForKey:USER_PARAM_RESIDENCE_LATITUDE]longValue];
        self.longitude = (long)[[dict valueForKey:USER_PARAM_RESIDENCE_LONGITUDE]longValue];

        self.universityID =   [NSString stringWithFormat:@"%i",(int)[[dict valueForKey:UNIVERSITY_PARAM_ID]integerValue]];
       
        
        if ([dict valueForKey:@"added_as_friend"]!=nil)
        {
            NSLog(@"IS FRIEND = %i",(int)[ [dict valueForKey:@"added_as_friend"]integerValue]);

            self.isFriend = (int)[[dict valueForKey:@"added_as_friend"]integerValue];
        }
        
        if (![[dict valueForKey:RESIDENCE_PARAM_ID]isKindOfClass:[NSNull class]])
        {
            self.residenceID =   [NSString stringWithFormat:@"%i",(int)[[dict valueForKey:RESIDENCE_PARAM_ID]integerValue]];

        }
        else
        {
            NSLog(@"NULLL DETECTED!!!");
        }

    }
    return self;
}


@end
