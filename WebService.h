//
//  WebService.h
//  GoalMachine
//
//  Created by Andy Chamberlain on 24/06/2016.
//  Copyright © 2016 Re Raise Design. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Reachability;

typedef NS_ENUM(NSInteger, apiRequests) {
    AUTHENTICATION,
    LOGIN,
    REGISTER
};

@interface WebService : NSObject

@property (nonatomic) Reachability *hostReachability;
@property (nonatomic) Reachability *internetReachability;
@property (nonatomic) Reachability *wifiReachability;

+ (WebService*)sharedInstance;

@property NSString *userID;
@property NSString *token;


-(void)universities;
-(void)residences;
-(void)authentication;


@end
