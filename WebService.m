//
//  WebService.m
//  GoalMachine
//
//  Created by Andy Chamberlain on 24/06/2016.
//  Copyright © 2016 Re Raise Design. All rights reserved.
//

#import "WebService.h"
#import "Reachability.h"
#import "AFNetworking.h"
#import "Data.h"
#import "University.h"
#import "RRRegistration.h"

//#define API_BASE_URL @"http://goalmachine.app"
#define API_BASE_URL @"http://139.59.180.166/api"

@implementation WebService
+ (WebService*)sharedInstance
{
    static WebService *_sharedInstance = nil;
    
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^
                  {
                      _sharedInstance = [[WebService alloc]init];
                  });
    
    return _sharedInstance;
}

#pragma mark Reachability

-(void)showErrorAlertWithMessage:(NSString*)message
{
    [[[UIAlertView alloc]initWithTitle:@"The Internet connection appears to be offline." message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil]show];
}

// Reachability
-(void)setupReachability
{
    /*
     Observe the kNetworkReachabilityChangedNotification. When that notification is posted, the method reachabilityChanged will be called.
     */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    self.hostReachability = [Reachability reachabilityWithHostName:API_BASE_URL];
    [self.hostReachability startNotifier];
    [self updateInterfaceWithReachability:self.hostReachability];
    
    self.internetReachability = [Reachability reachabilityForInternetConnection];
    [self.internetReachability startNotifier];
    [self updateInterfaceWithReachability:self.internetReachability];
    
    self.wifiReachability = [Reachability reachabilityForLocalWiFi];
    [self.wifiReachability startNotifier];
    [self updateInterfaceWithReachability:self.wifiReachability];
}

/*!
 * Called by Reachability whenever status changes.
 */
- (void)reachabilityChanged:(NSNotification *)note
{
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    [self updateInterfaceWithReachability:curReach];
}

- (void)updateInterfaceWithReachability:(Reachability *)reachability
{
    if (reachability == self.hostReachability)
    {
        BOOL connectionRequired = [reachability connectionRequired];
        
        NSString* baseLabelText = @"";
        
        if (connectionRequired)
        {
            baseLabelText = NSLocalizedString(@"Cellular data network is available.\nInternet traffic will be routed through it after a connection is established.", @"Reachability text if a connection is required");
        }
        else
        {
            baseLabelText = NSLocalizedString(@"Cellular data network is active.\nInternet traffic will be routed through it.", @"Reachability text if a connection is not required");
        }
        
        //     NSLog(@"Network Reachability Summary: %@", baseLabelText);
    }
    
    if (reachability == self.internetReachability)
    {
        [self updateReachability:reachability];
    }
    
    if (reachability == self.wifiReachability)
    {
        [self updateReachability:reachability];
    }
}


- (void)updateReachability:(Reachability *)reachability
{
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    BOOL connectionRequired = [reachability connectionRequired];
    NSString* statusString = @"";
    
    switch (netStatus)
    {
        case NotReachable:        {
            statusString = NSLocalizedString(@"Access Not Available", @"Text field text for access is not available");
            /*
             Minor interface detail- connectionRequired may return YES even when the host is unreachable. We cover that up here...
             */
            connectionRequired = NO;
            break;
        }
            
        case ReachableViaWWAN:        {
            statusString = NSLocalizedString(@"Reachable WWAN", @"");
            break;
        }
        case ReachableViaWiFi:        {
            statusString= NSLocalizedString(@"Reachable WiFi", @"");
            break;
        }
    }
    
    if (connectionRequired)
    {
        NSString *connectionRequiredFormatString = NSLocalizedString(@"%@, Connection Required", @"Concatenation of status string with connection requirement");
        statusString= [NSString stringWithFormat:connectionRequiredFormatString, statusString];
    }
    
    //  NSLog(@"Reachability Status: %@", statusString);
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
}


-(void)universities
{
    NSString *requestUrl = [NSString stringWithFormat:@"%@/universities", API_BASE_URL];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:requestUrl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        [[Data sharedInstance]createUniversitesArrayFromDict:responseObject];
        
        } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
        [self performSelector:@selector(showErrorAlert:) withObject:error];
    }];

}


-(void)residences
{
    NSString *requestUrl = [NSString stringWithFormat:@"%@/universities/%@/residences", API_BASE_URL, [Data sharedInstance].selectedUniversity.universityID];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:requestUrl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        [[Data sharedInstance]createResidencesArrayFromDict:responseObject];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
        [self performSelector:@selector(showErrorAlert:) withObject:error];
    }];
    
}

-(void)showErrorAlert:(NSError*)error
{
    [[[UIAlertView alloc]initWithTitle:@"Error" message:[NSString stringWithFormat:@"%@", error.localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil]show];
}


-(void)registerUser
{/*
    NSString *requestUrl = [NSString stringWithFormat:@"%@/user/create", API_BASE_URL];
    
    NSDictionary *params = @{
                             @"username":[RRRegistration sharedInstance].username,
                             @"email":[RRRegistration sharedInstance].email,
                             @"password":[RRRegistration sharedInstance].password
                             };
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    
    [manager POST:requestUrl parameters:params constructingBodyWithBlock:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        if ([[responseObject valueForKey:@"Error"]isEqualToString:@"UserExists"])
        {
            [[[UIAlertView alloc]initWithTitle:@"Username Exists" message:@"This username has already been taken, please choose a different one" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil]show];
            return;
            
        }
        if ([[responseObject valueForKey:@"Error"]isEqualToString:@"EmailExists"])
        {
            [[[UIAlertView alloc]initWithTitle:@"Email has already been used" message:@"This email has already been used to create an account." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil]show];
            return;
            
        }
        
        [[Data sharedInstance]registeredUserWithDict:responseObject];
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }]; */
}

-(void)authentication
{
    NSString *requestUrl = [NSString stringWithFormat:@"%@/users/authentication", API_BASE_URL];
    
    NSDictionary *params = @{
                             @"user_id":@"2"
                            };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager.requestSerializer setValue:@"X0rzBGWiY1" forHTTPHeaderField:@"Token"];
    
    [manager POST:requestUrl parameters:params constructingBodyWithBlock:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
  /*      if ([[responseObject valueForKey:@"Error"]isEqualToString:@"UserExists"])
        {
            [[[UIAlertView alloc]initWithTitle:@"Username Exists" message:@"This username has already been taken, please choose a different one" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil]show];
            return;
            
        }
        if ([[responseObject valueForKey:@"Error"]isEqualToString:@"EmailExists"])
        {
            [[[UIAlertView alloc]initWithTitle:@"Email has already been used" message:@"This email has already been used to create an account." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil]show];
            return;
            
        }
        
        [[Data sharedInstance]registeredUserWithDict:responseObject];
        
        */
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}


/*
-(void)registerUser
{
    NSString *requestUrl = [NSString stringWithFormat:@"%@/user/create", API_BASE_URL];
    
    NSDictionary *params = @{
                             @"username":[RRRegistration sharedInstance].username,
                             @"email":[RRRegistration sharedInstance].email,
                             @"password":[RRRegistration sharedInstance].password
                             };
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];


    [manager POST:requestUrl parameters:params constructingBodyWithBlock:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
            if ([[responseObject valueForKey:@"Error"]isEqualToString:@"UserExists"])
            {
                [[[UIAlertView alloc]initWithTitle:@"Username Exists" message:@"This username has already been taken, please choose a different one" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil]show];
                return;

            }
            if ([[responseObject valueForKey:@"Error"]isEqualToString:@"EmailExists"])
            {
                [[[UIAlertView alloc]initWithTitle:@"Email has already been used" message:@"This email has already been used to create an account." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil]show];
                return;

            }
       
            [[Data sharedInstance]registeredUserWithDict:responseObject];
            
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}


//Error
-(void)loginUser:(NSString *)username password:(NSString*)password
{
    NSString *requestUrl = [NSString stringWithFormat:@"%@/user/login", API_BASE_URL];
    
    NSDictionary *params = @{
                             @"username":username,
                             @"password":password
                             };
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    
    [manager POST:requestUrl parameters:params constructingBodyWithBlock:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"Login JSON: %@", [responseObject class]);
        
        
            if ([[responseObject valueForKey:@"Error"]isEqualToString:@"Incorrect Login Details"])
            {
                [self performSelectorOnMainThread:@selector(showLoginErrorAlert) withObject:nil waitUntilDone:YES];
                if (![Data sharedInstance].matchDayArray)
                {
                    [self getMatches];
                }
            }
            else
            {
                [[PersistanceManager sharedInstance]saveUsername:username andPassword:password];
                [Data sharedInstance].userLoggedIn = YES;
                [[Data sharedInstance]loggedinUserWithDict:responseObject];
            }
        

        
        
       
      
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [self performSelectorOnMainThread:@selector(showLoginErrorAlert) withObject:nil waitUntilDone:NO];

    }];
}


-(void)showLoginErrorAlert
{
    [[PersistanceManager sharedInstance]forgetLoginDetails];

    [[[UIAlertView alloc]initWithTitle:@"Incorrect Login Details" message:@"Please check your login details and try again" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil]show];

}

 */
@end