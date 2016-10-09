//
//  PersistanceManager.m
//  GoalMachine
//
//  Created by Andy Chamberlain on 09/06/2016.
//  Copyright © 2016 Re Raise Design. All rights reserved.
//

#define KEY @"AppData"

#import "PersistanceManager.h"

@implementation PersistanceManager

+ (PersistanceManager*)sharedInstance
{
    static PersistanceManager *_sharedInstance = nil;
    
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^
                  {
                      _sharedInstance = [[PersistanceManager alloc]init];
                  });
    
    return _sharedInstance;
}

-(id)loadData
{
   if (![[NSUserDefaults standardUserDefaults]valueForKey:KEY])
    {
        return nil;
    }
    
    return [[NSUserDefaults standardUserDefaults]valueForKey:KEY];
}


-(void)saveUserID:(NSString*)userID andToken:(NSString*)token
{
    NSDictionary* dict = @{@"UserID":userID, @"Token":token};
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    [ud setObject:dict forKey:@"Login Details"];
    [ud synchronize];
}

-(NSDictionary*)loadLoginDetails
{    
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"Login Details"];
}

-(void)forgetLoginDetails
{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"Login Details"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

@end
