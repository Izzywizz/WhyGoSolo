//
//  WebServiceRequest.m
//  Why Go Solo
//
//  Created by Andy Chamberlain on 29/10/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//


//#define EVENT_REQUEST_URL_ALL @"events/"
//#define EVENT_REQUEST_URL_SINGLE @"events/"
//#define EVENT_REQUEST_URL_JOIN @"update_join_status"

#import "WebServiceRequest.h"
#import "WebService.h" // ONLY IMPORTING TO BRING IN THE ENUMS

#import "User.h"
#import "Event.h"
#import "Comment.h"
#import "University.h"
#import "Residence.h"

#import "Data.h"


#import "RRRegistration.h"

@implementation WebServiceRequest


- (id)initWithApiRequest:(long)apiRequest
{
    self = [super init];
    if(self)
    {
        
        self.apiRequst = apiRequest;
        
        self.requestUrl = [self requestURLManager];
        NSLog(@"1111111");
        self.paramsDict = [self paramsDictForApiRequest];
        NSLog(@"11111112");
        self.responseSelector = NSSelectorFromString([self responseSelectorManager]);
        NSLog(@"11111113");
       }
    return self;
}


-(NSDictionary*)paramsDictForApiRequest
{

    NSMutableDictionary *tempDict = [NSMutableDictionary new];
    
    NSString *selectorString = @"paramsDictManager";
    
    if (_apiRequst == USER_API_CREATE)
    {
        selectorString = @"createUserDict";
    }
    if (_apiRequst == LOGIN)
    {
        selectorString = @"loginDict";
    }
    if(_apiRequst == EVENT_API_CREATE)
    {
        return [self createEventDict];
        selectorString = @"createEventDict";

    }
    
    
    NSDictionary *datDict = (NSDictionary*)[self performSelector: NSSelectorFromString(selectorString)];
    NSLog(@"PARAM KEYS = %@", [self paramKeys]);
    for (NSString* paramKey in [self paramKeys])
    {
        
        [tempDict setObject:[datDict objectForKey:paramKey] forKey:paramKey];
    }
    
    NSLog(@"RR L EMAIL : %@ / RR L PW : %@", [RRRegistration sharedInstance].email, [RRRegistration sharedInstance].password);

    return [[NSDictionary alloc]initWithDictionary:tempDict];
}

-(NSDictionary*)paramsDictManager
{
    return @{
             
                            EVENT_PARAM_USER_ID:[Data sharedInstance].userID,
                            USER_PARAM_ID:[Data sharedInstance].userID,
                            FILTER_PARAM_DISTANCE:[Data sharedInstance].filterDistance,
                            FILTER_PARAM_RESIDENCE_ID_ARRAY:[Data sharedInstance].residenceFilterArrayString,
                          
                        /*    USER_PARAM_FIRST_NAME:[Data sharedInstance].loggedInUser.firstName,
                            USER_PARAM_LAST_NAME:[Data sharedInstance].loggedInUser.lastName,
                            USER_PARAM_PASSWORD:[Data sharedInstance].loggedInUser.password,
                            USER_PARAM_DOB_EPOCH,
                            USER_PARAM_RESIDENCE_LATITUDE,
                            USER_PARAM_RESIDENCE_LONGITUDE,
                            RESIDENCE_PARAM_ID,
                            USER_PARAM_AVATAR_FILE_NAME,
                            USER_PARAM_PASSWORD, */

                            
                            
                            };
}

-(NSDictionary*)loginDict
{
    return @{
             USER_PARAM_LOGIN_EMAIL:[RRRegistration sharedInstance].email,
             USER_PARAM_LOGIN_PASSWORD:[RRRegistration sharedInstance].password,
             };
}

-(NSDictionary*)createUserDict
{
    return @{
             USER_PARAM_EMAIL:[RRRegistration sharedInstance].email,
             USER_PARAM_FIRST_NAME:[RRRegistration sharedInstance].firstName,
             USER_PARAM_LAST_NAME:[RRRegistration sharedInstance].lastName,
             USER_PARAM_PASSWORD:[RRRegistration sharedInstance].password,
             USER_PARAM_DOB_EPOCH:@"44444",//[RRRegistration sharedInstance].strDateOfBirth,
             USER_PARAM_RESIDENCE_LATITUDE:[NSString stringWithFormat:@"%f",[RRRegistration sharedInstance].latitude],
             USER_PARAM_RESIDENCE_LONGITUDE:[NSString stringWithFormat:@"%f",[RRRegistration sharedInstance].longitude],
             UNIVERSITY_PARAM_ID:[RRRegistration sharedInstance].universityID,
             RESIDENCE_PARAM_ID:[RRRegistration sharedInstance].residenceID,
             };
}


-(NSDictionary*)createEventDict
{
    return @{
             EVENT_PARAM_ADDRESS:[Data sharedInstance].createdEvent.address,
             EVENT_PARAM_DESCRIPTION:[Data sharedInstance].createdEvent.eventDescription,
             EVENT_PARAM_LONGITUDE:[NSString stringWithFormat:@"%f",[Data sharedInstance].createdEvent.longitude],
             EVENT_PARAM_LATITUDE:[NSString stringWithFormat:@"%f",[Data sharedInstance].createdEvent.latitude],
             EVENT_PARAM_EMOJI:[Data sharedInstance].createdEvent.emoji,
             EVENT_PARAM_PRIVATE:[NSString stringWithFormat:@"%i",[Data sharedInstance].createdEvent.isPrivate],
             EVENT_PARAM_USER_ID:[Data sharedInstance].userID,
             };
}


-(NSString*)requestURLManager
{
    switch (_apiRequst)
    {
        //USERS
        case USER_API_CREATE:
            return @"users/create";
            break;
            //USERS
        case LOGIN:
            return @"users/login";
            break;

            
        case USER_API_FRIEND_STATUS_UPDATE:
            return [NSString stringWithFormat:@"users/%i/update_friend_status", [Data sharedInstance].selectedUser.userID];
            break;
            
        case EVENT_API_ALL:
            return @"events";
            break;
        
        case EVENT_API_SINGLE:
            return [NSString stringWithFormat:@"events/%@", [Data sharedInstance].selectedEventID ];

         //   return [NSString stringWithFormat:@"events/%i", [Data sharedInstance].selectedEvent.eventID ];
            break;
            
            
        case EVENT_API_CREATE:
            
            return [NSString stringWithFormat:@"users/%@/events/create", [Data sharedInstance].userID ];
            
            // return [NSString stringWithFormat:@"events/%i/update_join_status", [Data sharedInstance].selectedEvent.eventID ];
            break;
    
        case EVENT_API_JOIN:
            
            return [NSString stringWithFormat:@"events/%@/update_join_status", [Data sharedInstance].selectedEventID ];

           // return [NSString stringWithFormat:@"events/%i/update_join_status", [Data sharedInstance].selectedEvent.eventID ];
            break;
        default:
            break;
    }
    
    return nil;
}

-(NSArray*)paramKeys
{
    
    return [[API_ARRAY objectAtIndex:_apiRequst]objectAtIndex:PARAMS];

    /*
    switch (_apiRequst)
    {
        case LOGIN:
            return LOGIN_API_PARAMS;
            break;
            
        case USER_API_CREATE:
            return @[
                     USER_PARAM_EMAIL,
                     USER_PARAM_FIRST_NAME,
                     USER_PARAM_LAST_NAME,
                     USER_PARAM_PASSWORD,
                     USER_PARAM_DOB_EPOCH,
                     USER_PARAM_RESIDENCE_LATITUDE,
                     USER_PARAM_RESIDENCE_LONGITUDE,
                     UNIVERSITY_PARAM_ID,
                     RESIDENCE_PARAM_ID,
                     USER_PARAM_AVATAR_FILE_NAME,
                     ];
            break;
        
        case USER_API_FRIEND_STATUS_UPDATE:
            return USER_API_FRIEND_STATUS_UPDATE_PARAMS;
            break;
    
            
        case USER_API_EDIT:
            return @[
                     USER_PARAM_ID,
                     USER_PARAM_FIRST_NAME,
                     USER_PARAM_LAST_NAME,
                     USER_PARAM_PASSWORD,
                     USER_PARAM_DOB_EPOCH,
                     USER_PARAM_RESIDENCE_LATITUDE,
                     USER_PARAM_RESIDENCE_LONGITUDE,
                     RESIDENCE_PARAM_ID,
                     USER_PARAM_AVATAR_FILE_NAME,
                     USER_PARAM_PASSWORD,
                     ];
            break;
            
        case USER_API_DELETE:
            return @[
                     USER_PARAM_ID,
                     USER_PARAM_PASSWORD,
                     
                     ];
            break;

        case USER_API_SINGLE:
            return @[
                     USER_PARAM_SELECTED_ID,
                     
                     ];
            break;
            
        case EVENT_API_ALL:
            
            
            return [[API_ARRAY objectAtIndex:_apiRequst]objectAtIndex:PARAMS];

            return EVENT_API_ALL_PARAMS;

            break;
        
        case EVENT_API_SINGLE:
            return EVENT_API_SINGLE_PARAMS;
            break;
        case EVENT_API_JOIN:
            return EVENT_API_JOIN_PARAMS;
            break;
        default:
            break;
    }
    return nil; */
}

-(NSString*)responseSelectorManager
{
    return [[API_ARRAY objectAtIndex:_apiRequst]objectAtIndex:RESPONSE_SELECTOR];
/*
    switch (_apiRequst)
    {
        case EVENT_API_ALL:
            return [[API_ARRAY objectAtIndex:_apiRequst]objectAtIndex:RESPONSE_SELECTOR];
            return EVENT_API_ALL_RESPONSE_SELECTOR;
            break;
            
        case EVENT_API_SINGLE:
            return EVENT_API_SINGLE_PARAMS_RESPONSE_SELECTOR;
            break;
        case EVENT_API_JOIN:
            
            return EVENT_API_JOIN_RESPONSE_SELECTOR;
            break;
        default:
            break;
    }
    
    return nil; */
}


@end
