//
//  Event.m
//  Why Go Solo
//
//  Created by Andy Chamberlain on 09/10/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "Event.h"

@implementation Event

-(Event*)initWithDict:(NSDictionary*)dict
{
    if (self)
    {
        self.eventID = (int)[[dict valueForKey:@"id"]integerValue];
        self.longitude = (double)[[dict valueForKey:@"longitude"]doubleValue];
        self.latitude = (double)[[dict valueForKey:@"latitude"]doubleValue];
        
        self.address = [dict valueForKey:@"address"];
        self.eventDescription = [dict valueForKey:@"description"];
        self.emoji = [dict valueForKey:@"emoji"];
        
        self.totalComments = [NSString stringWithFormat:@"%i",(int)[[dict valueForKey:@"number_of_comments"]integerValue]];
        self.totalAttending = [NSString stringWithFormat:@"%i (%i)",(int)[[dict valueForKey:@"number_of_users_attending"]integerValue], (int)[[dict valueForKey:@"number_of_friends_attending"]integerValue]];
        
        
        self.userID = (int)[[dict valueForKey:@"user_id"]integerValue];
        self.userFirstName = [[dict valueForKey:@"user"]valueForKey:@"first_name"];
        self.userLastName = [[dict valueForKey:@"user"]valueForKey:@"last_name"];
        
        self.userName = [NSString stringWithFormat:@"%@ %@", self.userFirstName, self.userLastName];
    }
    return self;
}


@end
