//
//  Comment.h
//  Why Go Solo
//
//  Created by Andy Chamberlain on 28/10/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Comment : NSObject

-(Comment*)initWithDict:(NSDictionary*)dict;

@property NSString* commentText;
@property NSString* commentID;
@property int epochCreated;
@property NSString* userID;
@property User* commentUser;

@end
