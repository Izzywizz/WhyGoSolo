//
//  PersistanceManager.h
//  GoalMachine
//
//  Created by Andy Chamberlain on 09/06/2016.
//  Copyright © 2016 Re Raise Design. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersistanceManager : NSObject

+ (PersistanceManager*)sharedInstance;

-(void)saveUserID:(NSString*)userID andToken:(NSString*)token;
-(NSDictionary*)loadLoginDetails;

-(void)forgetLoginDetails;



@end
