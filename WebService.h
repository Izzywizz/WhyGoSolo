//
//  WebService.h
//  GoalMachine
//
//  Created by Andy Chamberlain on 24/06/2016.
//  Copyright © 2016 Re Raise Design. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Reachability;

typedef NS_ENUM(NSInteger, authenticationApiRequests) {
    AUTHENTICATION,
    LOGIN
};

typedef NS_ENUM(NSInteger, eventsApiRequests) {
        ALL_EVENTS,
    CREATE_EVENT,
        JOIN_EVENT,
    EDIT_EVENT,
    CANCEL_EVENT,
    CLOSE_EVENT,
        EVENT_DETAILS,
   // EVENT_COMMENTS,
  //  EVENT_MAP
};


typedef NS_ENUM(NSInteger, userApiRequests) {
    CREATE_USER,
    DELETE_USER,
    EDIT_USER,
    SINGLE_USER,
    FRIENDS,
    EVERYONE,
    UPDATE_FRIEND_STATUS,
    RESET_PASSWORD,
    UPDATE_BLOCK_STATUS,
    REPORT_USER
};

typedef NS_ENUM(NSInteger, commentApiRequests) {
    CREATE_COMMENT,
    DELETE_COMMENT,
    REPORT_COMMENT,
};

typedef NS_ENUM(NSInteger, universityApiRequests) {
    UNIVERSITIES,
};

typedef NS_ENUM(NSInteger, residenceApiRequests) {
    RESIDENCES,
};

typedef NS_ENUM(NSInteger, apiParams) {
    UNIVERSITY_ID,
    RESIDENCE_ID,
    
    USER_ID,
    FIRST_NAME,
    LAST_NAME,
    DOB_EPOCH,
    RESIDENCE_LATITUDE,
    RESIDENCE_LONGITUDE,
    PASSWORD,
    NEW_PASSWORD,
    AVATAR_FILE,
    
    FILTER_DISTANCE,
    RESIDENCE_ID_ARRAY,
    
    EVENT_ID,
    ADDRESS,
    EVENT_LATITUDE,
    EVENT_LONGITUDE,
    EVENT_DESCRIPTION,
    EMOJI,
    PRIVATE,
    EPOCH_EXPIRY,
    EVENT_USER_ID,
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
