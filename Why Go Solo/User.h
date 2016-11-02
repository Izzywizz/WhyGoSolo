//
//  User.h
//  Why Go Solo
//
//  Created by Andy Chamberlain on 19/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class University;
@class Residence;

@interface User : NSObject

-(User*)initWithDict:(NSDictionary*)dict;

@property NSString* userID;
@property NSString* firstName;
@property NSString* lastName;
@property NSString* userName;
@property NSString* password;
@property NSString* dobEpoch;
@property NSString* email;
@property long latitude;
@property long longitude;

@property NSString* universityID;
@property NSString* residenceID;
@property University* university;
@property Residence* residence;

@property int isFriend;
@property NSMutableArray *eventsArray;
@end
