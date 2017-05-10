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
        self.eventID = (int)[[dict valueForKey:EVENT_ID_KEY]integerValue];
        self.longitude = (double)[[dict valueForKey:EVENT_LONGITUDE_KEY]doubleValue];
        self.latitude = (double)[[dict valueForKey:EVENT_LATITUDE_KEY]doubleValue];
        
        self.address = [[RREmojiParser sharedInstance] parseStringontainingEmojis:[dict valueForKey:EVENT_ADDRESS_KEY]];
        self.eventDescription = [[RREmojiParser sharedInstance] parseStringontainingEmojis:[dict valueForKey:EVENT_DESCRIPTION_KEY]];
        self.emoji = [[RREmojiParser sharedInstance] parseStringontainingEmojis:[dict valueForKey:EVENT_EMOJI_KEY]];
        
        self.totalComments = [NSString stringWithFormat:@"%i",(int)[[dict valueForKey:EVENT_NUMBER_OF_COMMENTS_KEY]integerValue]];
        self.totalAttending = [NSString stringWithFormat:@"%i (%i)",(int)[[dict valueForKey:EVENT_NUMBER_OF_USERS_ATTENDING_KEY]integerValue], (int)[[dict valueForKey:EVENT_NUMBER_OF_FRIENDS_ATTENDING_KEY]integerValue]];
        
        
        self.userID = (int)[[dict valueForKey:EVENT_USER_ID_KEY]integerValue];
        self.userFirstName = [[dict valueForKey:@"user"]valueForKey:USER_FIRST_NAME_KEY];
        self.userLastName = [[dict valueForKey:@"user"]valueForKey:USER_LAST_NAME_KEY];
        
        self.userName = [NSString stringWithFormat:@"%@ %@", self.userFirstName, self.userLastName];
        
        

        self.joined = (int)[[dict valueForKey:EVENT_JOINED_STATUS_KEY]integerValue];
    }
    return self;
}
@end
