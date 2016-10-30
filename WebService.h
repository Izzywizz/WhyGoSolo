//
//  WebService.h
//  GoalMachine
//
//  Created by Andy Chamberlain on 24/06/2016.
//  Copyright © 2016 Re Raise Design. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Data.h"
@class Reachability;


typedef NS_ENUM(NSInteger, eventsApiRequests) {
#define TEST @"loginsssssss"EVENT_API_ALL_RESPONSE_SELECTOR

    
    EVENT_API_ALL = 0,
    #define EVENT_API_ALL_PARAMS @[EVENT_PARAM_USER_ID, FILTER_PARAM_RESIDENCE_ID_ARRAY, FILTER_PARAM_DISTANCE]
    #define EVENT_API_ALL_RESPONSE_SELECTOR @"createEventsArrayFromDict:"
    #define EVENT_API_ARRAY @[EVENT_API_ALL_PARAMS, EVENT_API_ALL_RESPONSE_SELECTOR]
    
    EVENT_API_SINGLE = 1,
    #define EVENT_API_SINGLE_PARAMS @[EVENT_PARAM_USER_ID]
    #define EVENT_API_SINGLE_PARAMS_RESPONSE_SELECTOR @"parseEventFromDict:"
    #define EVENT_API_SINGLE_ARRAY @[EVENT_API_SINGLE_PARAMS, EVENT_API_SINGLE_PARAMS_RESPONSE_SELECTOR]

    EVENT_API_JOIN = 2,
    #define EVENT_API_JOIN_PARAMS @[EVENT_PARAM_USER_ID]
    #define EVENT_API_JOIN_RESPONSE_SELECTOR @"updateJoinedStatusFromDict:"
    #define EVENT_API_JOIN_ARRAY @[EVENT_API_JOIN_PARAMS, EVENT_API_JOIN_RESPONSE_SELECTOR]

    AUTHENTICATION,
    
    
    LOGIN = 3,
    #define LOGIN_API_PARAMS @[USER_PARAM_LOGIN_EMAIL, USER_PARAM_LOGIN_PASSWORD]
    #define LOGIN_API_RESPONSE_SELECTOR @"login"
    #define LOGIN_API_PARAMS_ARRAY @[LOGIN_API_PARAMS, LOGIN_API_RESPONSE_SELECTOR]

    

    USER_API_CREATE,
    
    
    
    
    USER_API_DELETE,
    USER_API_EDIT,
    USER_API_SINGLE,
    USER_API_FRIENDS,
    USER_API_EVERYONE,
    
    USER_API_FRIEND_STATUS_UPDATE,
    #define USER_API_FRIEND_STATUS_UPDATE_PARAMS @[USER_PARAM_ID]

    
    USER_API_RESET_PASSWORD,
    USER_API_BLOCK_STATUS_UPDATE,
    USER_API_REPORT,
    
    
    
    EVENT_API_CREATE,
    #define EVENT_API_CREATE_PARAMS @[EVENT_PARAM_USER_ID]
    #define EVENT_API_CREATE_PARAMS_DICT @{EVENT_PARAM_USER_ID:,}
    
    #define EVENT_API_CREATE_RESPONSE_SELECTOR @"createEventsArrayFromDict:"
    #define EVENT_API_CREATE_ARRAY @[EVENT_API_CREATE_PARAMS, EVENT_API_CREATE_RESPONSE_SELECTOR]


    EVENT_API_EDIT,
    EVENT_API_CANCEL,
    EVENT_API_CLOSE,
   
    
    
    
    // EVENT_COMMENTS,
  //  EVENT_MAP
};
#define kCREATE_EVENT_DESCRIPTION [Data SharedInstance].createdEvent.eventDescription;

#define API_ARRAY @[EVENT_API_ARRAY, EVENT_API_SINGLE_ARRAY, EVENT_API_JOIN_ARRAY, LOGIN_API_PARAMS_ARRAY]

typedef NS_ENUM(NSInteger, ApiDataIndexes) {
    PARAMS = 0,
    RESPONSE_SELECTOR = 1,
};

/*
typedef NS_ENUM(NSInteger, userApiRequests) {

};
*/
typedef NS_ENUM(NSInteger, commentApiRequests) {
    COMMENT_API_CREATE,
    COMMENT_API_DELETE,
    COMMENT_API_REPORT,
};

typedef NS_ENUM(NSInteger, universityApiRequests) {
    UNIVERSITY_API_ALL,
};

typedef NS_ENUM(NSInteger, residenceApiRequests) {
    RESIDENCE_API_ALL,
};


//#define EVENT_API_ALL_PARAMS @[EVENT_PARAM_USER_ID, FILTER_PARAM_RESIDENCE_ID_ARRAY, FILTER_PARAM_DISTANCE]




#define UNIVERSITY_PARAM_ID @"university_id"
#define RESIDENCE_PARAM_ID @"residence_id"

#define USER_PARAM_ID @"user_id"
#define USER_PARAM_SELECTED_ID @"user_id"

#define USER_PARAM_FIRST_NAME @"first_name"
#define USER_PARAM_LAST_NAME @"last_name"
#define USER_PARAM_DOB_EPOCH @"dob_epoch"
#define USER_PARAM_RESIDENCE_LATITUDE @"latitude"
#define USER_PARAM_RESIDENCE_LONGITUDE @"longitude"
#define USER_PARAM_EMAIL @"email"


#define USER_PARAM_PASSWORD @"password"
#define USER_PARAM_NEW_PASSWORD @"new_password"

#define USER_PARAM_AVATAR_FILE_NAME @"avatar"

#define FILTER_PARAM_DISTANCE @"filter_distance"
    #define FILTER_DEFAULT_VALUE_DISTANCE @"0"


#define FILTER_PARAM_RESIDENCE_ID_ARRAY @"residence_id_array"
    #define FILTER_DEFAULT_VALUE_RESIDENCE_ID_ARRAY @"all"


#define EVENT_PARAM_ADDRESS @"address"
#define EVENT_PARAM_LATITUDE @"latitude"
#define EVENT_PARAM_LONGITUDE @"longitude"
#define EVENT_PARAM_DESCRIPTION @"description"
#define EVENT_PARAM_EMOJI @"emoji"
#define EVENT_PARAM_PRIVATE @"private"
#define EVENT_PARAM_EPOCH_EXPIRY @"user_id"
#define EVENT_PARAM_USER_ID @"user_id"


#define COMMENT_PARAM_ID @"emoji"
#define COMMENT_PARAM_TEXT @"comment_text"

#define USER_PARAM_LOGIN_EMAIL @"email"
#define USER_PARAM_LOGIN_PASSWORD @"password"

typedef NS_ENUM(NSInteger, apiParams) {
   // UNIVERSITY_ID,
   // RESIDENCE_ID,
    
   // USER_ID,
 //   FIRST_NAME,
   // LAST_NAME,
   // DOB_EPOCH,
   // RESIDENCE_LATITUDE,
   // RESIDENCE_LONGITUDE,
  //  PASSWORD,
  //  NEW_PASSWORD,
 //   AVATAR_FILE,
    
  //  FILTER_DISTANCE,
  //  RESIDENCE_ID_ARRAY,
    
    EVENT_ID,
  //  ADDRESS,
   // EVENT_LATITUDE,
   // EVENT_LONGITUDE,
   // EVENT_DESCRIPTION,
   // EMOJI,
   // PRIVATE,
   // EPOCH_EXPIRY,
   // EVENT_USER_ID,
    EVENT_STATUS,
    PRIVATE_EVENT,
    
    COMMENT_ID,
    COMMENT_TEXT,
    COMMENT_USER_ID,
    COMMENT_EPOCH_CREATED,
    
};

@interface WebService : NSObject



@property (nonatomic) Reachability *hostReachability;
@property (nonatomic) Reachability *internetReachability;
@property (nonatomic) Reachability *wifiReachability;

+ (WebService*)sharedInstance;

@property NSString *userID;
@property NSString *token;


-(void)universities;
-(void)residences;
-(void)authentication;

-(void)updateJoinedStatus;
-(void)user:(int)userID;
-(void)registerAccount;

// EVENTS START

-(void)eventsApiRequest:(int)apiCall;

@property NSString* selectedEventID;
// EVENTS END


@end
