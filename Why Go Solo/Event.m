//
//  Event.m
//  Why Go Solo
//
//  Created by Andy Chamberlain on 09/10/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "Event.h"
#import "RREmojiParser.h"
#import "WebService.h"
#import "RRDownloadImage.h"
@implementation Event

-(Event*)initWithDict:(NSDictionary*)dict
{
    if (self)
    {
        self.eventID = (int)[[dict valueForKey:EVENT_PARAM_ID]integerValue];
        self.longitude = (double)[[dict valueForKey:EVENT_PARAM_LONGITUDE]doubleValue];
        self.latitude = (double)[[dict valueForKey:EVENT_PARAM_LATITUDE]doubleValue];
        
        self.address = [[RREmojiParser sharedInstance] parseStringontainingEmojis:[dict valueForKey:EVENT_PARAM_ADDRESS]];
        self.eventDescription = [[RREmojiParser sharedInstance] parseStringontainingEmojis:[dict valueForKey:EVENT_PARAM_DESCRIPTION]];
        self.emoji = [[RREmojiParser sharedInstance] parseStringontainingEmojis:[dict valueForKey:EVENT_PARAM_EMOJI]];
        
        self.totalComments = [NSString stringWithFormat:@"%i",(int)[[dict valueForKey:EVENT_PARAM_NUMBER_OF_COMMENTS]integerValue]];
        self.totalAttending = [NSString stringWithFormat:@"%i (%i)",(int)[[dict valueForKey:EVENT_PARAM_NUMBER_OF_USERS_ATTENDING]integerValue], (int)[[dict valueForKey:EVENT_PARAM_NUMBER_OF_FRIENDS_ATTENDING]integerValue]];
        
        
        self.userID = (int)[[dict valueForKey:EVENT_PARAM_USER_ID]integerValue];
        self.userFirstName = [[dict valueForKey:@"user"]valueForKey:USER_PARAM_FIRST_NAME];
        self.userLastName = [[dict valueForKey:@"user"]valueForKey:USER_PARAM_LAST_NAME];
        
        self.userName = [NSString stringWithFormat:@"%@ %@", self.userFirstName, self.userLastName];
    }
    return self;
}
@end
