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
        
        self.dobEpoch =   [NSString stringWithFormat:@"%i",(int)[[dict valueForKey:USER_DOB_EPOCH_KEY]integerValue]];
        NSLog(@"USER DOB ID = %@", self.dobEpoch);

        self.latitude = (long)[[dict valueForKey:USER_RESIDENCE_LATITUDE_KEY]longValue];
        self.longitude = (long)[[dict valueForKey:USER_RESIDENCE_LONGITUDE_KEY]longValue];

        self.universityID =   [NSString stringWithFormat:@"%i",(int)[[dict valueForKey:UNIVERSITY_ID_KEY]integerValue]];
       
        NSLog(@"USER UNI ID = %@", self.universityID);
        self.email =[dict valueForKey:USER_EMAIL_KEY];
        
        if ([dict valueForKey:@"added_as_friend"]!=nil)
        {
            NSLog(@"IS FRIEND = %i",(int)[ [dict valueForKey:@"added_as_friend"]integerValue]);

            self.isFriend = (int)[[dict valueForKey:@"added_as_friend"]integerValue];
        }
        
        if (![[dict valueForKey:RESIDENCE_ID_KEY]isKindOfClass:[NSNull class]])
        {
            self.residenceID =   [NSString stringWithFormat:@"%i",(int)[[dict valueForKey:RESIDENCE_ID_KEY]integerValue]];
            
            if ([[dict allKeys]containsObject:RESIDENCE_KEY])
            {
                
                NSLog(@"RES DICT = %@", [[dict valueForKey:RESIDENCE_KEY]valueForKey:USER_RESIDENCE_ADDRESS_KEY]);
                self.residence = [Residence new];
                self.residence.address = [[dict valueForKey:RESIDENCE_KEY]valueForKey:USER_RESIDENCE_ADDRESS_KEY];
                //[NSString stringWithFormat:@"%@",[[dict valueForKey:RESIDENCE_KEY]valueForKey:USER_RESIDENCE_ADDRESS_KEY]];
         
                NSLog(@"RES ADDRESSSSSS = %@", self.residence.address);
            }
            

        }
        else
        {
            self.residence.address = @"Not in student residence";
            NSLog(@"NULLL DETECTED!!!");
        }

    }
    return self;
}


@end
