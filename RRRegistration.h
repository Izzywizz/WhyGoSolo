//
//  RRRegistration.h
//  GoalMachine
//
//  Created by Andy Chamberlain on 24/06/2016.
//  Copyright © 2016 Re Raise Design. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, textfields) {
    EMAIL = 1,
    PASSWORD = 2,
    CONFRIM_PASSWORD = 3,
    FIRST_NAME = 4,
    LAST_NAME = 5,
    DOB = 6,
 
};

@interface RRRegistration : NSObject

+ (RRRegistration*)sharedInstance;

@property NSString* universityID;
@property NSString* universityEmailSuffix;
@property NSString* firstName;
@property NSString* lastName;

@property NSString* email;
@property NSString* password;
@property NSString* confirmPassword;

@property NSString* residenceID;

@property double longitude;
@property double latitude;

@property UIImage *profilePhoto;



-(BOOL)validateTextField:(UITextField *)textField;

@end
