//
//  User.h
//  Why Go Solo
//
//  Created by Andy Chamberlain on 19/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

-(User*)initWithDict:(NSDictionary*)dict;

@property int userID;
@property NSString* firstName;
@property NSString* lastName;
@property NSString* userName;
@property NSMutableArray *eventsArray;
@end
