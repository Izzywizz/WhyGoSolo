//
//  WebServiceRequest.h
//  Why Go Solo
//
//  Created by Andy Chamberlain on 29/10/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebServiceRequest : NSObject

- (id)initWithApiRequest:(long)apiRequest;

@property long apiRequst;
@property NSDictionary *paramsDict;
@property NSString *requestUrl;
@property SEL responseSelector;



+(NSString*)userID;
@end
