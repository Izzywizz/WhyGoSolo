//
//  RRDateFormater.m
//  GoalMachine
//
//  Created by Andy Chamberlain on 28/06/2016.
//  Copyright © 2016 Re Raise Design. All rights reserved.
//

#import "RRDateFormater.h"

@implementation RRDateFormater


+ (RRDateFormater*)sharedInstance
{
    static RRDateFormater *_sharedInstance = nil;
    
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^
                  {
                      _sharedInstance = [[RRDateFormater alloc]init];
                  });
    
    return _sharedInstance;
}

-(NSString*)stringFromEpochDate:(NSString*)dateString
{
    NSTimeInterval seconds = [dateString doubleValue];
    
    NSDate *createdDate = [[NSDate alloc] initWithTimeIntervalSince1970:seconds];
    
    NSDateFormatter *shortFormat = [[NSDateFormatter alloc] init];
    [shortFormat setDateFormat:@"d MMM HH:mm"];
    
    NSString *parsedDate = [shortFormat stringFromDate:createdDate];
    
    return parsedDate;
    
    return @"";
}
@end
