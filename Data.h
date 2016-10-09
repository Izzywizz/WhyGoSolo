//
//  Data.h
//  Why Go Solo
//
//  Created by Andy Chamberlain on 18/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class University;
@class Residence;
@class Event;

@protocol DataDelegate <NSObject>

-(void)authenticationSuccessful;

-(void)universitiesDownloadedSuccessfully;
-(void)residencesDownloadedSuccessfully;
-(void)eventsDownloadedSuccessfully;

@end

@interface Data : NSObject

@property (nonatomic, weak) id <DataDelegate> delegate;


@property NSString* userID;
@property NSString* userToken;

@property NSString* filterDistance;
@property NSArray* residenceFilterArray;


+ (Data*)sharedInstance;



@property NSMutableArray* universitesArray;
@property NSMutableArray* residencesArray;

@property NSMutableArray* myEventsArray;
@property NSMutableArray* eventsArray;

@property University *selectedUniversity;
@property Residence *selectedResidence;
@property Event *selectedEvent;
//-(void)createUserFromDict:(NSDictionary *)dict;

-(void)createUniversitesArrayFromDict:(NSDictionary *)dict;
-(void)createResidencesArrayFromDict:(NSDictionary *)dict;
-(void)createEventsArrayFromDict:(NSDictionary *)dict;

-(void)authenticationSuccessful;
@end
