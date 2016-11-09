//
//  Residence.h
//  Why Go Solo
//
//  Created by Andy Chamberlain on 19/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Residence : NSObject

@property NSString* residenceName;

@property double longitude;
@property double latitude;

@property NSString* address;
@property NSString* city;
@property NSString* postCode;
@property int residenceID;
-(Residence *) initWithDict: (NSDictionary *)dict;
@end

