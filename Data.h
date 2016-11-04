//
//  Data.h
//  Why Go Solo
//
//  Created by Andy Chamberlain on 18/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class University;
@class Residence;
@class Event;
@class User;

@protocol DataDelegate <NSObject>

-(void)authenticationSuccessful;

-(void)universitiesDownloadedSuccessfully;
-(void)residencesDownloadedSuccessfully;
-(void)eventsDownloadedSuccessfully;
-(void)joinedStatusUpdatedSuccessfully;
-(void)userParsedSuccessfully;
-(void)eventParsedSuccessfully;

-(void)userLoggedInSuccessfully;

-(void)avatarDownloaded;
-(void)commentCreated;
-(void)commentReported;
-(void)eventEdited;


-(void)friendsParsedSuccessfully;
-(void)everyoneParsedSuccessfully;
@end

@interface Data : NSObject

@property (nonatomic, weak) id <DataDelegate> delegate;


@property NSString* userID;
@property NSString* userToken;

@property NSString* selectedEventID;
@property NSString *selectedUserID;
@property NSString* selectedCommentID;

@property NSString* filterDistance;
@property NSArray* residenceFilterArray;

@property NSMutableDictionary *avatarDict;

@property NSString* createdCommentText;
+ (Data*)sharedInstance;

@property User *loggedInUser;

@property NSMutableArray* universitesArray;
@property NSMutableArray* residencesArray;
@property NSString *residenceFilterArrayString;

@property NSMutableArray* myEventsArray;
@property NSMutableArray* eventsArray;

@property NSMutableArray* friendsAttendingEventsArray;
@property NSMutableArray* friendsNotAttendingEventsArray;

@property NSMutableArray* everyoneArray;

@property University *selectedUniversity;
@property Residence *selectedResidence;
@property Event *selectedEvent;
@property User *selectedUser;

@property Event *createdEvent;
//-(void)createUserFromDict:(NSDictionary *)dict;

-(void)createUniversitesArrayFromDict:(NSDictionary *)dict;
-(void)createResidencesArrayFromDict:(NSDictionary *)dict;
-(void)createEventsArrayFromDict:(NSDictionary *)dict;

-(void)parseUserFromDict:(NSDictionary*)dict;

-(void)authenticationSuccessful;

-(void)updateJoinedStatusFromDict:(NSDictionary*)dict;

-(void)parseEventFromDict:(NSDictionary*)dict;

-(void)updateResidenceFilterArrayString;

-(void)friendStatusUpdated:(NSDictionary*)dict;
-(void)login;
-(void)createCommentSuccessful;
-(void)deleteCommentSuccessful;
-(void)reportCommentSuccessful;
-(void)reportUserSuccessful;
-(void)blockStatusUpdated;
-(void)eventCancelSuccessful;
-(void)eventCloseSuccessful;
-(void)eventEditSuccessful;
-(void)updateAvatarDictWithImage:(UIImage*)avatarImage forUserID:(NSString*)userID;

-(void)createFriendsFromDict:(NSDictionary*)dict;
-(void)createEveryoneFromDict:(NSDictionary*)dict;
@end
