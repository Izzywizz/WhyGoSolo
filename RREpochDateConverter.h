//
//  RREpochDateConverter.h
//  Why Go Solo
//
//  Created by Andy Chamberlain on 08/11/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RREpochDateConverter : NSObject

-(NSString*)stringFromEpochDate:(NSString*)dateString;
-(NSString*)stringFromDate:(NSString*)dateString;

@end
