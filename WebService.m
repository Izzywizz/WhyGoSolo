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
#import "Event.h"
#import "User.h"
#import "PersistanceManager.h"
#import "EventsWebService.h"

#import "WebServiceRequest.h"
//#define API_BASE_URL @"http://goalmachine.app"
// #define API_BASE_URL @"http://139.59.180.166/api" // LIVE RE RAISE

//#define API_BASE_URL @"http://192.168.10.10/api" // HOMESTEAD

#define API_BASE_URL @"http://139.59.183.192/api" // LIVE CANDY

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



-(void)postRequest:(int)request
{
    switch (request) {
        case 0:
            [[WebService sharedInstance]eventsApiRequest:EVENT_API_ALL];
            break;
            
        default:
            break;
    }
}


-(NSString*)requestUrlString:(int)request
{
    switch (0) {
        case 0:
            return @"events";
            break;
            
        default:
            break;
    }
}




-(void)registerAccount
{
    NSString *fileName = @"profile.png";

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *routeFilePath = [paths objectAtIndex:0];
    
    NSString *photoFilePath = [routeFilePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", @"profile.png"]];
   
    NSLog(@"P FILE PATH = %@", photoFilePath);
    
 //   UIImage *image = [UIImage imageWithContentsOfFile:photoFilePath];

    
    UIImage *image = [UIImage imageNamed:fileName];
    NSLog(@"IMAGE = %@", [UIImage imageNamed:fileName]);

    NSLog(@"IMAGE = %@",image);
//    NSData *idata = UIImagePNGRepresentation(image);

    
    
    
    
  //  NSData *imageData = UIImageJPEGRepresentation(image, 1); //0.8
    NSData *imageData = UIImageJPEGRepresentation(    [RRRegistration sharedInstance].profilePhoto
, 0.2); //0.8

    NSString* requestURL = [NSString stringWithFormat:@"%@/users/create",API_BASE_URL];
    
    
    
 NSDictionary *params = @{
                          @"email":[RRRegistration sharedInstance].email,
    @"first_name":[RRRegistration sharedInstance].firstName,
    @"last_name":[RRRegistration sharedInstance].lastName,
                        
    @"dob_epoch":@"00000",//[RRRegistration sharedInstance].strDateOfBirth,

    @"latitude":@"0000",//[NSString stringWithFormat:@"%f",[RRRegistration sharedInstance].latitude],
    @"longitude":@"00001",//[NSString stringWithFormat:@"%f",[RRRegistration sharedInstance].longitude],
    @"password":[RRRegistration sharedInstance].password,
    @"university_id":[RRRegistration sharedInstance].universityID,
    @"residence_id":@"2"//[RRRegistration sharedInstance].residenceID
                          
    
    };
    
    
    NSLog(@"PARAMS = %@", params);
     NSLog(@"IMAGE = %@", [RRRegistration sharedInstance].profilePhoto);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    [manager POST:requestURL parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData){
  //   [formData appendPartWithFileData:imageData name:@"avatar" fileName:fileName mimeType:@"image/jpeg"];
        [formData appendPartWithFileData:imageData name:@"avatar" fileName:fileName mimeType:@"image/jpeg"];

       // [formData appendPartWithFileData:idata name:@"avatar" fileName:fileName mimeType:@"image/png"];
        
    } progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"xxx Success %@ xxx", responseObject);

        NSLog(@"EVENTS JSON: %@", responseObject);
        NSLog(@"RESPONSE HEADERS = %@", task.response);
        
        NSHTTPURLResponse* res = task.response;
        
        //  NSLog(@"RESPONSE HEADERS = %@", [res.allHeaderFields ]);
        
        NSMutableDictionary *resDict = [[NSMutableDictionary alloc]initWithDictionary:responseObject];
        [resDict setObject:res.allHeaderFields forKey:@"header"];
        
        NSLog(@"RES DICT = %@", resDict);
        
        
        [Data sharedInstance].userToken = [[resDict valueForKey:@"header" ] valueForKey:@"Token"];
        [Data sharedInstance].userID = [responseObject valueForKey:@"id"];
        
        [[PersistanceManager sharedInstance]saveUserID:[Data sharedInstance].userID andToken:[Data sharedInstance].userToken];
        [self authentication];

    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}


-(void)eventsApiRequest:(int)apiCall
{
    WebServiceRequest *wsRequest = [[WebServiceRequest alloc]initWithApiRequest:apiCall];
    
    [self postRequest:wsRequest.requestUrl withParams:wsRequest.paramsDict withResponseSelctor:wsRequest.responseSelector];

    ;
    return;
    
  /*  EventsWebService *eventsWebService = [[EventsWebService alloc]initWithEventApiReques:apiCall];
    
    [self postRequest:eventsWebService.requestUrl withParams:eventsWebService.paramsDict withResponseSelctor:eventsWebService.responseSelector];
    
    NSLog(@"WS REQ: %@ \n  EWS REQ: %@ \n  WS PARAMS: %@ \n  EWS PARAMS: %@ \n WS SEL: %@ \nEWS SEL %@", wsRequest.requestUrl, eventsWebService.requestUrl, wsRequest.paramsDict, eventsWebService.paramsDict, wsRequest.responseSelector, eventsWebService.responseSelector);
   */

}





-(NSDictionary*)registrationDict
{
    
    
    return @{};
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

-(void)postRequest:(NSString*)requestUrl withParams:(NSDictionary*)params withResponseSelctor:(SEL)responseMethod
{
    NSString *fullRequestUrl = [NSString stringWithFormat:@"%@/%@", API_BASE_URL, requestUrl];

    NSLog(@"POST REQUEST DICT = %@", params);
    NSLog(@"POST REQUEST URL = %@", fullRequestUrl);

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager.requestSerializer setValue:[Data sharedInstance].userToken forHTTPHeaderField:@"Token"];
    
    [manager POST:fullRequestUrl parameters:params constructingBodyWithBlock:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
      
        
        NSLog(@"EVENTS JSON: %@", responseObject);
        NSLog(@"RESPONSE HEADERS = %@", task.response);

        NSHTTPURLResponse* res = task.response;
        
      //  NSLog(@"RESPONSE HEADERS = %@", [res.allHeaderFields ]);
        if (![Data sharedInstance].userToken) {
            NSMutableDictionary *resDict = [[NSMutableDictionary alloc]initWithDictionary:responseObject];
            [resDict setObject:res.allHeaderFields forKey:@"header"];
            
            [Data sharedInstance].userToken = [[resDict valueForKey:@"header" ] valueForKey:@"Token"];
            [Data sharedInstance].userID = [responseObject valueForKey:@"id"];
        }

        NSMutableDictionary *resDict = [[NSMutableDictionary alloc]initWithDictionary:responseObject];
        [resDict setObject:res.allHeaderFields forKey:@"header"];
        [[Data sharedInstance]performSelector:responseMethod withObject:resDict];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}



/*
-(void)updateJoinedStatus
{

    NSString *requestUrl = [NSString stringWithFormat:@"events/%i/update_join_status", [Data sharedInstance].selectedEvent.eventID];

    NSDictionary *params = @{
                             @"user_id":[Data sharedInstance].userID,
                             @"event_id":[NSString stringWithFormat:@"%i", [Data sharedInstance].selectedEvent.eventID],
                            };
    
    NSLog(@"Update Joined STATUS REQUEST DICT = %@", params);
    
    SEL responseSelector = @selector(updateJoinedStatusFromDict:);
    
    [self postRequest:requestUrl withParams:params withResponseSelctor:responseSelector];

}*/

-(void)user:(int)userID
{
    NSString *requestUrl = [NSString stringWithFormat:@"users/%i", userID];
    
    NSDictionary *params = @{
                             @"user_id":[Data sharedInstance].userID
                             };
    
    
    NSLog(@"Users REQUEST DICT = %@", params);
    
    SEL responseSelector = @selector(parseUserFromDict:);
    
    [self postRequest:requestUrl withParams:params withResponseSelctor:responseSelector];
}


/*-(void)events
{
    NSString *requestUrl = [NSString stringWithFormat:@"%@/events", API_BASE_URL];
    
    NSError * err;
    
    [Data sharedInstance].residenceFilterArray = @[@"3",@"5"];
    
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:[Data sharedInstance].residenceFilterArray options:0 error:&err];
    
    NSString *filterArrayString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSDictionary *params = @{
                             @"user_id":[Data sharedInstance].userID,
                             @"filter_distance":@"0",
                             @"residence_id_array":filterArrayString
                             };
    
    //    NSMutableArray *paramsArray = [[NSMutableArray alloc]initWithObjects:params, nil];
    
    
    
    NSLog(@"EVENTS REQUEST DICT = %@", params);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager.requestSerializer setValue:[Data sharedInstance].userToken forHTTPHeaderField:@"Token"];
    
    [manager POST:requestUrl parameters:params constructingBodyWithBlock:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"EVENTS JSON: %@", responseObject);
        
        [[Data sharedInstance]createEventsArrayFromDict:responseObject];
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}*/

-(void)authentication
{
   // [Data sharedInstance].userToken = @"Px4tY6XxJ0";
   // [Data sharedInstance].userID = @"30";
    
    NSString *requestUrl = [NSString stringWithFormat:@"%@/users/authentication", API_BASE_URL];
    
    NSDictionary *params = @{
                             @"user_id":[NSString stringWithFormat:@"%@",[Data sharedInstance].userID]
                            };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager.requestSerializer setValue:[Data sharedInstance].userToken forHTTPHeaderField:@"Token"];
    
    NSLog(@"USER PARAMS = %@", params);
    
    [manager POST:requestUrl parameters:params constructingBodyWithBlock:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        [[Data sharedInstance]authenticationSuccessful];
      } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
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
