//
//  RREpochDateConverter.m
//  Why Go Solo
//
//  Created by Andy Chamberlain on 08/11/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "RREpochDateConverter.h"

@implementation RREpochDateConverter

-(NSString*)stringFromEpochDate:(NSString*)dateString
{
    NSLog(@"EPOCH STRING = %@",dateString);
    
    NSTimeInterval seconds = [dateString doubleValue];
    
    NSDate *createdDate = [[NSDate alloc] initWithTimeIntervalSince1970:seconds];
    
    NSDateFormatter *shortFormat = [[NSDateFormatter alloc] init];
    [shortFormat setDateFormat:@"dd/MM/YYYY"];
    
    NSString *parsedDate = [shortFormat stringFromDate:createdDate];
    
    return parsedDate;
    
    return @"";
}

-(NSString*)stringFromDate:(NSString*)dateString
{
    
    //    NSLog(@"Date String = %@", dateString);
    NSDateFormatter *isoFormat = [[NSDateFormatter alloc] init];
    [isoFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *createdDate = [isoFormat dateFromString:dateString];
    
    NSDateFormatter *shortFormat = [[NSDateFormatter alloc] init];
    [shortFormat setDateFormat:@"d MMM HH:mm"];
    
    NSString *parsedDate = [shortFormat stringFromDate:createdDate];
    
    return parsedDate;
    
    return @"";
}


-(NSString*)utcEpochFromPickerDate:(NSDate*)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //[dateFormatter setDateFormat:@"yyyy-MM-dd"];
  //  NSDate  *objDate    = [dateFormatter dateFromString:IN_strLocalTime];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSString *strDateTime   = [dateFormatter stringFromDate:date ];
    return strDateTime;
    return @"";
}
@end
