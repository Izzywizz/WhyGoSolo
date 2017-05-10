//
//  EventsWebService.m
//  Why Go Solo
//
//  Created by Andy Chamberlain on 28/10/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "EventsWebService.h"
#import "Data.h"
#import "WebService.h"
#import "Event.h"
@implementation EventsWebService

- (id)initWithEventApiReques:(long)apiRequest
{
    self = [super init];
    if(self)
    {
        self.paramsDict = [[self dictForApiRequest:apiRequest]valueForKey:@"params"];
        self.requestUrl = [[self dictForApiRequest:apiRequest]valueForKey:@"requestUrl"];
        self.responseSelector = NSSelectorFromString([[self dictForApiRequest:apiRequest]valueForKey:@"responseSelector"]);
    }
    return self;
}

-(NSDictionary*)dictForApiRequest:(long)apiRequest
{
    NSDictionary *apiDict = @{
                                   [NSString stringWithFormat:@"%li",(long)EVENT_API_ALL]:[self allEventsDict],
                                   [NSString stringWithFormat:@"%li",(long)EVENT_API_SINGLE]:[self eventDetailsDict],
                                   [NSString stringWithFormat:@"%li",(long)EVENT_API_JOIN]:[self joinEventDict],
                                //   [NSString stringWithFormat:@"%li",(long)EVENT_COMMENTS]:[self eventCommentsDict]

                                   };
    
    
    
    
    return [apiDict valueForKey:[NSString stringWithFormat:@"%li",(long)apiRequest]];
}

// EVENT_API_ALL
-(NSDictionary*)allEventsDict
{
    return @{
             @"requestUrl":@"events",
             @"responseSelector":@"createEventsArrayFromDict:",
             @"params":[self allEventsParamsDict]
             };
}

-(NSDictionary*)allEventsParamsDict
{
    NSString *residenceFilterArrayString = @"all";
    
    if ( [[Data sharedInstance].residenceFilterArray count]>0)
    {
        residenceFilterArrayString = [[[Data sharedInstance].residenceFilterArray valueForKey:@"description"] componentsJoinedByString:@","];
    }
    return @{ @"user_id":[Data sharedInstance].userID,
              @"filter_distance":@"0",
              @"residence_id_array":residenceFilterArrayString
              };
}

// EVENT_API_SINGLE
-(NSDictionary*)eventDetailsDict
{
    return @{
             @"requestUrl":[NSString stringWithFormat:@"events/%i", [Data sharedInstance].selectedEvent.eventID ],
             @"responseSelector":@"parseEventFromDict:",
             @"params":@{ @"user_id":[Data sharedInstance].userID }
             };
}

// EVENT_API_JOIN
-(NSDictionary*)joinEventDict
{
    return @{
             @"requestUrl":[NSString stringWithFormat:@"events/%i/update_join_status", [Data sharedInstance].selectedEvent.eventID ],
             @"responseSelector":@"updateJoinedStatusFromDict:",
             @"params":@{ @"user_id":[Data sharedInstance].userID }
             };
}

// EVENT_COMMENTS
-(NSDictionary*)eventCommentsDict
{
    return @{
             @"requestUrl":[NSString stringWithFormat:@"events/%i/comments", [Data sharedInstance].selectedEvent.eventID ],
             @"responseSelector":@"parseEventFromDict:",
             @"params":@{ @"user_id":[Data sharedInstance].userID }
             };
}

@end
