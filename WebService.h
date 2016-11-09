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
//#define API_BASE_URL @"http://goalmachine.app"
// #define API_BASE_URL @"http://139.59.180.166/api" // LIVE RE RAISE

//#define API_BASE_URL @"http://192.168.10.10/api" // HOMESTEAD


#define IMAGE_BASE_URL @"http://139.59.183.192/storage" // LIVE CANDY

#define API_BASE_URL @"http://139.59.183.192/api" // LIVE CANDY

typedef NS_ENUM(NSInteger, eventsApiRequests) {
//#define TEST @"loginsssssss"API_DICT
    
   // #define API_DICT @{@"0":EVENT_API_ALL_DICT, @"1":@"", @"2":EVENT_API_JOIN_DICT, @"3":LOGIN_API_DICT, @"4":EVENT_API_CREATE_DICT, @"5":USER_API_SINGLE_DICT, @"6":USER_API_FRIEND_STATUS_UPDATE_DICT}

    
    EVENT_API_ALL = 0,
  //  #define EVENT_API_ALL_DICT @{@"request":@[@"events"], @"params":EVENT_API_ALL_PARAMS, @"response":@"createEventsArrayFromDict:"}
//    #define EVENT_API_ALL_PARAMS @[EVENT_PARAM_USER_ID, FILTER_PARAM_RESIDENCE_ID_ARRAY, FILTER_PARAM_DISTANCE]
  //  #define EVENT_API_ALL_RESPONSE_SELECTOR @"createEventsArrayFromDict:"

    
    
    EVENT_API_SINGLE = 1,
//    #define EVENT_API_SINGLE_DICT @{ @"request":@[@"events/",SELECTED_EVENT_ID], @"params":SELECTED_EVENT_PARAMS,  @"response":@"parseEventFromDict:"}
//    EVENT_API_SINGLE = 1,
  //  #define EVENT_API_SINGLE_DICT @{ @"params":@[EVENT_PARAM_USER_ID], @"request":@[@"events/",SELECTED_EVENT], @"response":@"parseEventFromDict:"}


    
    EVENT_API_JOIN = 2,
  //  #define EVENT_API_JOIN_DICT @{ @"request":@[@"events/",SELECTED_EVENT_ID,@"/update_join_status"], @"params":EVENT_API_JOIN_PARAMS,  @"response":@"updateJoinedStatusFromDict:"}

    //   #define EVENT_API_JOIN_DICT @{ @"params":@[EVENT_PARAM_USER_ID], @"response":@"updateJoinedStatusFromDict:" }
  //  #define EVENT_API_JOIN_PARAMS @[EVENT_PARAM_USER_ID]
  //  #define EVENT_API_JOIN_RESPONSE_SELECTOR @"updateJoinedStatusFromDict:"
    
    
    LOGIN = 3,
    #define LOGIN_API_DICT @{ @"request":@[@"users/login"], @"params":@{USER_EMAIL_KEY:[RRRegistration sharedInstance].email, USER_PARAM_PASSWORD:[RRRegistration sharedInstance].password}, @"response":@"login" }
  //  #define LOGIN_API_PARAMS @[USER_PARAM_LOGIN_EMAIL, USER_PARAM_LOGIN_PASSWORD]
   // #define LOGIN_API_RESPONSE_SELECTOR @"login"

    EVENT_API_CREATE = 4,
  //  #define EVENT_API_CREATE_DICT @{ @"params":@[EVENT_PARAM_USER_ID, EVENT_PARAM_ADDRESS, EVENT_PARAM_DESCRIPTION, EVENT_PARAM_LONGITUDE, EVENT_PARAM_LATITUDE, EVENT_PARAM_EMOJI, EVENT_PARAM_PRIVATE, EVENT_PARAM_USER_ID], @"response":@"createEventsArrayFromDict:" }
  //  #define EVENT_API_CREATE_PARAMS @[EVENT_PARAM_USER_ID, EVENT_PARAM_ADDRESS, EVENT_PARAM_DESCRIPTION, EVENT_PARAM_LONGITUDE, EVENT_PARAM_LATITUDE, EVENT_PARAM_EMOJI, EVENT_PARAM_PRIVATE, EVENT_PARAM_USER_ID]
   // #define EVENT_API_CREATE_RESPONSE_SELECTOR @"createEventsArrayFromDict:"


    
    USER_API_SINGLE = 5,
//    #define USER_API_SINGLE_DICT @{ @"params":@[USER_PARAM_ID], @"response":@"parseUserFromDict:" }

 //   #define USER_API_SINGLE_PARAMS @[USER_PARAM_ID]
   // #define USER_API_SINGLE_PARAMS_RESPONSE_SELECTOR @"parseUserFromDict:"
   // #define USER_API_SINGLE_PARAMS_ARRAY @[USER_API_SINGLE_PARAMS, USER_API_SINGLE_PARAMS_RESPONSE_SELECTOR]
   
    USER_API_FRIEND_STATUS_UPDATE = 6,
 //   #define USER_API_FRIEND_STATUS_UPDATE_DICT @{ @"params":@[USER_PARAM_ID], @"response":@"friendStatusUpdated:" }

  //  #define USER_API_FRIEND_STATUS_UPDATE_PARAMS @[USER_PARAM_ID]
 //   #define USER_API_FRIEND_STATUS_UPDATE_RESPONSE_SELECTOR @"friendStatusUpdated:"
   // #define USER_API_FRIEND_STATUS_UPDATE_PARAMS_ARRAY @[USER_API_FRIEND_STATUS_UPDATE_PARAMS, USER_API_FRIEND_STATUS_UPDATE_RESPONSE_SELECTOR]
 
    
    
    COMMENT_API_CREATE = 7,
    
    
    COMMENT_API_DELETE = 8,
    COMMENT_API_REPORT = 9,
    
    USER_API_BLOCK_STATUS_UPDATE = 10,
    USER_API_REPORT = 11,

    EVENT_API_CANCEL = 12,
    EVENT_API_CLOSE = 13,
    EVENT_API_EDIT = 14,

    
    USER_API_PEOPLE_FRIENDS = 15,
    USER_API_PEOPLE_EVERYONE = 16,
    
    
    USER_API_FRIENDS = 17,
    
    
    USER_API_EDIT = 18,
    
    USER_API_DELETE = 19,
    
    USER_API_RESET_PASSWORD = 20,
    
    AUTHENTICATION,
    USER_API_CREATE,
    
    
    
    
    
    
    
    

    

    


    
    
    
    
    
   


   
    
    
    
    // EVENT_COMMENTS,
  //  EVENT_MAP
};
#define kCREATE_EVENT_DESCRIPTION [Data SharedInstance].createdEvent.eventDescription;

#define API_ARRAY @[@"", EVENT_API_SINGLE_ARRAY, EVENT_API_JOIN_ARRAY, LOGIN_API_PARAMS_ARRAY, EVENT_API_CREATE_ARRAY, USER_API_SINGLE_PARAMS_ARRAY]

typedef NS_ENUM(NSInteger, ApiDataIndexes) {
    PARAMS = 0,
    RESPONSE_SELECTOR = 1,
};

/*
typedef NS_ENUM(NSInteger, userApiRequests) {

};
*/
//typedef NS_ENUM(NSInteger, commentApiRequests) {
//    COMMENT_API_CREATE,
  //  COMMENT_API_DELETE,
   // COMMENT_API_REPORT,
//};

typedef NS_ENUM(NSInteger, universityApiRequests) {
    UNIVERSITY_API_ALL,
};

typedef NS_ENUM(NSInteger, residenceApiRequests) {
    RESIDENCE_API_ALL,
};




//#define EVENT_API_ALL_PARAMS @[EVENT_PARAM_USER_ID, FILTER_PARAM_RESIDENCE_ID_ARRAY, FILTER_PARAM_DISTANCE]

//RUN TIME VALUES

#define USER_ID [NSString stringWithFormat:@"%@",[Data sharedInstance].userID]
#define SELECTED_EVENT_ID [Data sharedInstance].selectedEventID
#define SELECTED_USER_ID [Data sharedInstance].selectedUserID
#define FILTER_DISTANCE [Data sharedInstance].filterDistance
#define FILTER_RESIDENCE_ID_ARRAY [Data sharedInstance].residenceFilterArrayString
#define COMMENT_TEXT [Data sharedInstance].createdCommentText
#define SELECTED_COMMENT_ID [Data sharedInstance].selectedCommentID




// REQUEST PARAMS DICT
#define SELECTED_EVENT_PARAMS @{    EVENT_ID_KEY:EVENT_ID_VALUE,\
                                    USER_ID_KEY:USER_ID_VALUE}

//
#define EVENT_API_ALL_DICT      @{  @"request"  :   @[@ "events"],\
                                    @"response" :   @   "createEventsArrayFromDict:",\
                                    @"params"   :   @{  USER_ID_KEY:USER_ID,\
                                                        FILTER_DISTANCE_KEY:FILTER_DISTANCE,\
                                                        FILTER_RESIDENCE_ID_ARRAY_KEY:FILTER_RESIDENCE_ID_ARRAY }\
}

#define EVENT_API_SINGLE_DICT   @{  @"request"  :   @[@ "events/",SELECTED_EVENT_ID],\
                                    @"response" :   @   "parseEventFromDict:",\
                                    @"params"   :   @{  USER_ID_KEY:USER_ID,\
                                                        EVENT_ID_KEY:SELECTED_EVENT_ID }\
}

#define EVENT_API_JOIN_DICT     @{  @"request"  :   @[@ "events/",SELECTED_EVENT_ID,@"/update_join_status"],\
                                    @"response" :   @   "updateJoinedStatusFromDict:",\
                                    @"params"   :    @{ USER_ID_KEY:USER_ID }\
}

#define USER_API_SINGLE_DICT    @{  @"request"  :   @[@ "users/",SELECTED_USER_ID],\
                                    @"response" :   @   "parseUserFromDict:",\
                                    @"params"   :    @{ USER_ID_KEY:USER_ID }\
}

#define EVENT_API_CREATE_DICT    @{ @"request"  :   @[@ "users/",USER_ID,@"/events/create"],\
                                    @"response" :   @   "createEventsArrayFromDict:",\
                                    @"params"   :    @{ USER_ID_KEY:USER_ID,\
                                                        EVENT_ADDRESS_KEY:[Data sharedInstance].createdEvent.address,\
                                                        EVENT_DESCRIPTION_KEY:[Data sharedInstance].createdEvent.eventDescription,\
                                                        EVENT_LATITUDE_KEY:[NSString stringWithFormat:@"%f",[Data sharedInstance].createdEvent.latitude],\
                                                        EVENT_LONGITUDE_KEY:[NSString stringWithFormat:@"%f",[Data sharedInstance].createdEvent.longitude],\
                                                        EVENT_EMOJI_KEY:[Data sharedInstance].createdEvent.emoji,\
                                                        EVENT_PRIVATE_KEY:[NSString stringWithFormat:@"%i",[Data sharedInstance].createdEvent.isPrivate]}\
}


#define EVENT_API_EDIT_DICT @{\
@"request"  :   @[@ "events/",SELECTED_EVENT_ID,@"/edit"],\
@"response" :   @   "eventEditSuccessful",\
@"params"   :    @{ EVENT_ID_KEY:SELECTED_EVENT_ID,\
USER_ID_KEY:USER_ID,\
EVENT_ADDRESS_KEY:[Data sharedInstance].createdEvent.address,\
EVENT_DESCRIPTION_KEY:[Data sharedInstance].createdEvent.eventDescription,\
EVENT_LATITUDE_KEY:[NSString stringWithFormat:@"%f",[Data sharedInstance].createdEvent.latitude],\
EVENT_LONGITUDE_KEY:[NSString stringWithFormat:@"%f",[Data sharedInstance].createdEvent.longitude],\
EVENT_EMOJI_KEY:[Data sharedInstance].createdEvent.emoji,\
EVENT_PRIVATE_KEY:[NSString stringWithFormat:@"%i",[Data sharedInstance].createdEvent.isPrivate]}\
}

#define USER_API_FRIEND_STATUS_UPDATE_DICT @{\
@"request"  :   @[@ "users/",SELECTED_USER_ID,@"/update_friend_status"],\
@"response" :   @   "friendStatusUpdated:",\
@"params"   :   @{  USER_ID_KEY:USER_ID }\
}


#define COMMENT_CREATE_DICT @{\
@"request"  :   @[@ "events/",SELECTED_EVENT_ID,@"/comments/create"],\
@"response" :   @   "createCommentSuccessful",\
@"params"   : \
@{\
USER_ID_KEY:USER_ID,\
COMMENT_TEXT_KEY:COMMENT_TEXT}\
}

#define COMMENT_API_REPORT_DICT @{\
@"request"  :   @[@ "comments/",SELECTED_COMMENT_ID,@"/report"],\
@"response" :   @   "reportCommentSuccessful",\
@"params"   : \
@{\
USER_ID_KEY:USER_ID}\
}

#define COMMENT_API_DELETE_DICT @{\
@"request"  :   @[@ "comments/",SELECTED_COMMENT_ID,@"/delete"],\
@"response" :   @   "deleteCommentSuccessful",\
@"params"   : \
@{\
USER_ID_KEY:USER_ID}\
}


#define USER_API_BLOCK_STATUS_UPDATE_DICT @{\
@"request"  :   @[@ "users/",SELECTED_USER_ID,@"/update_block_status"],\
@"response" :   @   "blockStatusUpdated",\
@"params"   : \
@{\
USER_ID_KEY:USER_ID}\
}


#define USER_API_REPORT_DICT @{\
@"request"  :   @[@ "users/",SELECTED_USER_ID,@"/report_user"],\
@"response" :   @   "reportUserSuccessful",\
@"params"   : \
@{\
USER_ID_KEY:USER_ID}\
}


#define EVENT_API_CANCEL_DICT @{\
@"request"  :   @[@ "events/",SELECTED_EVENT_ID,@"/cancel"],\
@"response" :   @   "eventCancelSuccessful",\
@"params"   : \
@{\
USER_ID_KEY:USER_ID}\
}


#define EVENT_API_CLOSE_DICT @{\
@"request"  :   @[@ "events/",SELECTED_EVENT_ID,@"/close"],\
@"response" :   @   "eventCloseSuccessful",\
@"params"   : \
@{\
USER_ID_KEY:USER_ID}\
}


#define USER_API_PEOPLE_FRIENDS_DICT @{\
@"request"  :   @[@ "users/",USER_ID,@"/people/friends"],\
@"response" :   @   "createFriendsFromDict:",\
@"params"   : \
@{\
USER_ID_KEY:USER_ID}\
}


#define USER_API_PEOPLE_EVERYONE_DICT @{\
@"request"  :   @[@ "users/",USER_ID,@"/people/everyone"],\
@"response" :   @   "createEveryoneFromDict:",\
@"params"   : \
@{\
USER_ID_KEY:USER_ID}\
}


#define USER_API_FRIENDS_DICT @{\
@"request"  :   @[@ "users/",USER_ID,@"/friends"],\
@"response" :   @   "createFriendsFromDict:",\
@"params"   : \
@{\
USER_ID_KEY:USER_ID}\
}





//USER_API_EVERYONE

//#define EVENT_API_ALL_PARAMS

#define EVENT_API_JOIN_PARAMS   @{    USER_ID_KEY:USER_ID_VALUE }
// PARAM KEY/VALUE
#define EVENT_ID_KEY @"id"
//#define EVENT_ID_VALUE SELECTED_EVENT_ID

#define USER_ID_KEY @"user_id"
//#define USER_ID_VALUE USER_ID
//#define SELECTED_USED_VALUE SELECTED_USER_ID

#define FILTER_DISTANCE_KEY @"filter_distance"
//#define FILTER_DISTANCE_VALUE [Data sharedInstance].filterDistance

#define FILTER_RESIDENCE_ID_ARRAY_KEY @"residence_id_array"
//#define FILTER_RESIDENCE_ID_ARRAY_VALUE [Data sharedInstance].residenceFilterArrayString


#define UNIVERSITY_ID_KEY @"university_id"
#define RESIDENCE_ID_KEY @"residence_id"

#define RESIDENCE_KEY @"residence"


#define USER_PARAM_ID @"user_id"
#define USER_PARAM_SELECTED_ID @"user_id"

#define USER_FIRST_NAME_KEY @"first_name"
#define USER_LAST_NAME_KEY @"last_name"
#define USER_DOB_EPOCH_KEY @"dob_epoch"
#define USER_RESIDENCE_LATITUDE_KEY @"latitude"
#define USER_RESIDENCE_LONGITUDE_KEY @"longitude"
#define USER_EMAIL_KEY @"email"
#define USER_RESIDENCE_ADDRESS_KEY @"address"


#define USER_PARAM_PASSWORD @"password"
#define USER_PARAM_NEW_PASSWORD @"new_password"

#define USER_PARAM_AVATAR_FILE_NAME @"avatar"

#define FILTER_PARAM_DISTANCE @"filter_distance"
    #define FILTER_DEFAULT_VALUE_DISTANCE @"0"


#define FILTER_PARAM_RESIDENCE_ID_ARRAY @"residence_id_array"
    #define FILTER_DEFAULT_VALUE_RESIDENCE_ID_ARRAY @"all"


#define EVENT_ADDRESS_KEY @"address"
#define EVENT_LATITUDE_KEY @"latitude"
#define EVENT_LONGITUDE_KEY @"longitude"
#define EVENT_DESCRIPTION_KEY @"description"
#define EVENT_EMOJI_KEY @"emoji"
#define EVENT_PRIVATE_KEY @"private"
#define EVENT_EPOCH_EXPIRY_KEY @"epoch_expiry"
#define EVENT_USER_ID_KEY @"user_id"
#define EVENT_ID_KEY @"id"
#define EVENT_NUMBER_OF_COMMENTS_KEY @"number_of_comments"
#define EVENT_NUMBER_OF_USERS_ATTENDING_KEY @"number_of_users_attending"
#define EVENT_NUMBER_OF_FRIENDS_ATTENDING_KEY @"number_of_friends_attending"
#define EVENT_JOINED_STATUS_KEY @"logged_in_user_joined_event"


#define COMMENT_ID_KEY @"id"
#define COMMENT_TEXT_KEY @"comment_text"
#define COMMENT_EPOCH_CREATED_KEY @"epoch_created"
#define COMMENT_USER_ID_KEY @"user_id"

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
   // COMMENT_TEXT,
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
-(void)updateAccount;

// EVENTS START

-(void)eventsApiRequest:(int)apiCall;

@property NSString* selectedEventID;
// EVENTS END


@end
