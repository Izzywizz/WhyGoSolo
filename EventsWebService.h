//
//  EventsWebService.h
//  Why Go Solo
//
//  Created by Andy Chamberlain on 28/10/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventsWebService : NSObject


- (id)initWithEventApiReques:(long)apiRequest;

@property NSDictionary *paramsDict;
@property NSString *requestUrl;
@property SEL responseSelector;
@end
