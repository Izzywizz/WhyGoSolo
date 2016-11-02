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
        NSLog(@"gghghhfEVENTS CREATE DICTssssss = %lu", apiRequest);

       // NSLog(@"EVENTS CREATE DICT = %@", EVENT_API_CREATE_DICT);
        self.apiRequst = apiRequest;

        NSDictionary *apiDict = [self dictForApiRequest];
    NSLog(@"EVENTS CREATE DICT = %@", apiDict);
        self.requestUrl = [self urlStringFromArray:[apiDict valueForKey:@"request"]]; // NSLog(@"REQUEST XXXXX %@", self.requestUrl);
         NSLog(@"YYYYYY");
        self.paramsDict = [apiDict valueForKey:@"params"];  // NSLog(@"PARAMS XXXXX %@", self.paramsDict);
        
        NSLog(@"XXXXXXX");

        self.responseSelector = NSSelectorFromString([apiDict valueForKey:@"response"]);// NSLog(@"RESPONSE XXXXX %@", [apiDict valueForKey:@"response"]);
        
        NSLog(@"asdsadasdsadsadsadasd");
    }
    return self;
}

-(NSDictionary*)dictForApiRequest
{
    NSLog(@"gghghhfEVENTS CREATE DICT = %lu", self.apiRequst);

    
    switch (self.apiRequst) {
        case EVENT_API_ALL:     return EVENT_API_ALL_DICT;
            break;
        case EVENT_API_SINGLE:  return EVENT_API_SINGLE_DICT;
            break;
        case EVENT_API_JOIN:    return EVENT_API_JOIN_DICT;
            break;
        case USER_API_SINGLE:   return USER_API_SINGLE_DICT;
            break;
        case EVENT_API_CREATE:  return EVENT_API_CREATE_DICT;
            break;
        case USER_API_FRIEND_STATUS_UPDATE:  return USER_API_FRIEND_STATUS_UPDATE_DICT;
            break;
        case COMMENT_API_CREATE:  return COMMENT_CREATE_DICT;
            break;
        case COMMENT_API_DELETE: return COMMENT_API_DELETE_DICT;
            break;
        case COMMENT_API_REPORT: return COMMENT_API_REPORT_DICT;
            break;
        case USER_API_BLOCK_STATUS_UPDATE: return USER_API_BLOCK_STATUS_UPDATE_DICT;
            break;
        case USER_API_REPORT: return USER_API_REPORT_DICT;
            break;
        case EVENT_API_CANCEL: return EVENT_API_CANCEL_DICT;
            break;
        case EVENT_API_CLOSE: return EVENT_API_CLOSE_DICT;
            break;
        case EVENT_API_EDIT: return EVENT_API_EDIT_DICT;
            break;
        
        default:

            
            break;
    }
    return @{};
}


-(NSString*)urlStringFromArray:(NSArray*)urlComponents
{
    NSLog(@"URL COMPONENETS: %@", urlComponents);
    NSString* s= @"";
    
    for (id urlComponent in urlComponents)
    {
        NSLog(@"URL COMPONENETS: ==== %@", urlComponent);
        NSLog(@"URL COMPONENETS: ==== %@", [urlComponent class]);
        
        s = [s stringByAppendingString:urlComponent];

    }
    return s;
}





















-(NSArray*)urlArray
{
    return  @[
              //EVENT_API_ALL
              @"events",
              
              //EVENT_API_SINGLE
              [NSString stringWithFormat:@"events/%@", [Data sharedInstance].selectedEventID],
              
              //EVENT_API_JOIN
              [NSString stringWithFormat:@"events/%@/update_join_status", [Data sharedInstance].selectedEventID],
              
              //LOGIN
              @"users/login",
              
              //EVENT_API_CREATE
              [NSString stringWithFormat:@"users/%@/events/create", [Data sharedInstance].userID ],
              
              //USER_API_SINGLE
              [NSString stringWithFormat:@"users/%@", [Data sharedInstance].selectedUserID],
              
              //USER_API_FRIEND_STATUS_UPDATE

              ];

}

-(void)testDef
{
#define X [Data sharedInstance].selectedEventID

    NSLog(@"------ -- - - %@", X);
}
-(NSString*)urlForApiRequest
{
    if (_apiRequst == EVENT_API_ALL)
    {
        return @"events";
    }
    if (_apiRequst == EVENT_API_SINGLE)
    {
        return [NSString stringWithFormat:@"events/%@", [Data sharedInstance].selectedEventID ];
    }
    if (_apiRequst == EVENT_API_JOIN)
    {
        return [NSString stringWithFormat:@"events/%@/update_join_status", [Data sharedInstance].selectedEventID ];
    }
    if (_apiRequst == LOGIN)
    {
        return @"users/login";
    }
    if (_apiRequst == USER_API_SINGLE)
    {
        return [NSString stringWithFormat:@"users/%@", [Data sharedInstance].selectedUserID];
    }
    
    return @"";
    
}

/*-(NSString*)urlForApiRequest
{
    return [[API_DICT objectForKey:[NSString stringWithFormat:@"%li",_apiRequst]]objectForKey:@"request"];
}

-(SEL)responseSelectorForApiRequest
{
   return NSSelectorFromString([[API_DICT objectForKey:[NSString stringWithFormat:@"%li",_apiRequst]]objectForKey:@"response"]);
}*/
/*
-(NSDictionary*)paramsDictForApiRequest
{
    NSMutableDictionary *tempDict = [NSMutableDictionary new];
    
    NSLog(@"PARAM KEYS = %@", [API_DICT objectForKey:[NSString stringWithFormat:@"%li", _apiRequst]]);
    for (NSString* paramKey in [[API_DICT objectForKey:[NSString stringWithFormat:@"%li",_apiRequst]]objectForKey:@"params"])
    {
     //   NSLog(@"V %@ FOR K %@", paramKey, [self paramForKey:paramKey]);
        [tempDict setObject:[self paramForKey:paramKey] forKey:paramKey];
    }
    
    return [[NSDictionary alloc]initWithDictionary:tempDict];
}

/*
-(NSString*)urlComponentForKey:(long)key
{
    
    if ([paramKey isEqualToString:USER_PARAM_LOGIN_EMAIL])
    {
        return [RRRegistration sharedInstance].email;
    }

    return @"";
}*/

/*
-(id)paramForKey:(NSString*)paramKey
{
    NSLog(@"P KEY --- %@", paramKey);
    if ([paramKey isEqualToString:USER_PARAM_LOGIN_EMAIL])
    {
        return [RRRegistration sharedInstance].email;
    }
    if ([paramKey isEqualToString:USER_PARAM_LOGIN_PASSWORD])
    {
        return [RRRegistration sharedInstance].password;
    }
    if ([paramKey isEqualToString:EVENT_PARAM_USER_ID])
    {
        return [Data sharedInstance].userID;
    }
    if ([paramKey isEqualToString:FILTER_PARAM_DISTANCE])
    {
        return [Data sharedInstance].filterDistance;
    }
    if ([paramKey isEqualToString:FILTER_PARAM_RESIDENCE_ID_ARRAY])
    {
        return [Data sharedInstance].residenceFilterArrayString;
    }
    if ([paramKey isEqualToString:EVENT_PARAM_ADDRESS])
    {
        return [Data sharedInstance].createdEvent.address;
    }
    if ([paramKey isEqualToString:FILTER_PARAM_RESIDENCE_ID_ARRAY])
    {
        return [Data sharedInstance].residenceFilterArrayString;
    }
    if ([paramKey isEqualToString:EVENT_PARAM_DESCRIPTION])
    {
        return [Data sharedInstance].createdEvent.eventDescription;
    }
    if ([paramKey isEqualToString:EVENT_PARAM_LONGITUDE])
    {
        return [NSString stringWithFormat:@"%f",[Data sharedInstance].createdEvent.longitude];
    }
    if ([paramKey isEqualToString:EVENT_PARAM_LATITUDE])
    {
        return [NSString stringWithFormat:@"%f",[Data sharedInstance].createdEvent.latitude];
    }
    if ([paramKey isEqualToString:EVENT_PARAM_EMOJI])
    {
        return [Data sharedInstance].createdEvent.emoji;
    }
    if ([paramKey isEqualToString:EVENT_PARAM_PRIVATE])
    {
        return [NSString stringWithFormat:@"%i",[Data sharedInstance].createdEvent.isPrivate];
    }
    if ([paramKey isEqualToString:EVENT_PARAM_USER_ID])
    {
        return [Data sharedInstance].userID;
    }
    
    return nil;
}



*/


















/*
-(NSDictionary*)paramsDictForApiRequestx
{
    
    

    NSMutableDictionary *tempDict = [NSMutableDictionary new];
    ////////
    
    NSLog(@"PARAM KEYS = %@", [API_DICT objectForKey:[NSString stringWithFormat:@"%li",_apiRequst]]);
    for (NSString* paramKey in [[API_DICT objectForKey:[NSString stringWithFormat:@"%li",_apiRequst]]objectForKey:@"params"])
    {
        NSLog(@"V %@ FOR K %@", paramKey, [self paramForKey:paramKey]);
        [tempDict setObject:[self paramForKey:paramKey] forKey:paramKey];
    }
    self.responseSelector = NSSelectorFromString([[API_DICT objectForKey:[NSString stringWithFormat:@"%li",_apiRequst]]objectForKey:@"response"]);

    
    return [[NSDictionary alloc]initWithDictionary:tempDict];
///
    
    NSLog(@"PARAM KEYS = %@", [self paramKeys]);
    for (NSString* paramKey in EVENT_API_ALL_PARAMS)
    {
        [tempDict setObject:[self paramForKey:paramKey] forKey:paramKey];
    }
    
    
    NSLog(@"RR L EMAIL : %@ / RR L PW : %@", [RRRegistration sharedInstance].email, [RRRegistration sharedInstance].password);
    
    return [[NSDictionary alloc]initWithDictionary:tempDict];

    
    //////
    
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

*/
/*
-(NSDictionary*)paramsDictManager
{
    return @{
             
                            EVENT_PARAM_USER_ID:[Data sharedInstance].userID,
                            USER_PARAM_ID:[Data sharedInstance].userID,
                            FILTER_PARAM_DISTANCE:[Data sharedInstance].filterDistance,
                            FILTER_PARAM_RESIDENCE_ID_ARRAY:[Data sharedInstance].residenceFilterArrayString,
                          
                         USER_PARAM_FIRST_NAME:[Data sharedInstance].loggedInUser.firstName,
                            USER_PARAM_LAST_NAME:[Data sharedInstance].loggedInUser.lastName,
                            USER_PARAM_PASSWORD:[Data sharedInstance].loggedInUser.password,
                            USER_PARAM_DOB_EPOCH,
                            USER_PARAM_RESIDENCE_LATITUDE,
                            USER_PARAM_RESIDENCE_LONGITUDE,
                            RESIDENCE_PARAM_ID,
                            USER_PARAM_AVATAR_FILE_NAME,
                            USER_PARAM_PASSWORD,

                            
                            
                            };
}
*/
/*
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
             USER_FIRST_NAME_KEY:[RRRegistration sharedInstance].firstName,
             USER_LAST_NAME_KEY:[RRRegistration sharedInstance].lastName,
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
             EVENT_ADDRESS_KEY:[Data sharedInstance].createdEvent.address,
             EVENT_PARAM_DESCRIPTION:[Data sharedInstance].createdEvent.eventDescription,
             EVENT_PARAM_LONGITUDE:[NSString stringWithFormat:@"%f",[Data sharedInstance].createdEvent.longitude],
             EVENT_PARAM_LATITUDE:[NSString stringWithFormat:@"%f",[Data sharedInstance].createdEvent.latitude],
             EVENT_PARAM_EMOJI:[Data sharedInstance].createdEvent.emoji,
             EVENT_PARAM_PRIVATE:[NSString stringWithFormat:@"%i",[Data sharedInstance].createdEvent.isPrivate],
             EVENT_PARAM_USER_ID:[Data sharedInstance].userID,
             };
}
*/
/*
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
            return @"users/";
            break;

        
        case USER_API_SINGLE:
            return [NSString stringWithFormat:@"users/%@", [Data sharedInstance].selectedUserID];
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
}*/

-(NSArray*)paramKeys
{
    return @[];
   // return [[API_ARRAY objectAtIndex:_apiRequst]objectAtIndex:PARAMS];

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
    return @"";
    //return [[API_ARRAY objectAtIndex:_apiRequst]objectAtIndex:RESPONSE_SELECTOR];
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
