//
//  Event.h
//  Why Go Solo
//
//  Created by Andy Chamberlain on 09/10/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject

-(Event*)initWithDict:(NSDictionary*)dict;

@property int userID;
@property NSString* userFirstName;
@property NSString* userLastName;
@property NSString* userName;
@property int eventID;
@property double longitude;
@property double latitude;
@property NSString* address;
    @property NSString* city;
    @property NSString* postCode;
@property NSString* eventDescription;
@property NSString* emoji;
@property NSString* totalComments;
@property NSString* totalAttending;
@property int status;

@property NSMutableArray *friendsArray;
@property NSMutableArray *otherUsersArray;
@property NSMutableArray *commentsArray;

@end
