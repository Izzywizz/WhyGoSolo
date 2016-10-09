//
//  RRDateFormater.h
//  GoalMachine
//
//  Created by Andy Chamberlain on 28/06/2016.
//  Copyright © 2016 Re Raise Design. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RRDateFormater : NSObject
+ (RRDateFormater*)sharedInstance;
-(NSString*)stringFromEpochDate:(NSString*)dateString;

@end
