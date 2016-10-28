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

typedef NS_ENUM(NSInteger, apiRequests) {
    AUTHENTICATION,
    LOGIN,
    REGISTER
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
