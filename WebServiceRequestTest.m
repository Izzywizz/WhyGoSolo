//
//  WebServiceRequestTest.m
//  Why Go Solo
//
//  Created by Andy Chamberlain on 29/10/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "WebServiceRequestTest.h"
#import "Data.h"
#import "WebService.h"
#import "Event.h"
#import "PersistanceManager.h"

@interface WebServiceRequestTest () <DataDelegate>
{
    
}
@end

@implementation WebServiceRequestTest


- (id)initWithTests
{
    self = [super init];
    if(self)
    {
        [Data sharedInstance].delegate = self;
    }
    return self;
}

-(void)runTests
{
    
    
    
    [Data sharedInstance].selectedEventID = @"96";
    [Data sharedInstance].delegate = self;
    //[[WebService sharedInstance]authentication];
    if (![[PersistanceManager sharedInstance]loadLoginDetails])
    {
      //  [[WebService sharedInstance]universities];
    }
    else
    {
        NSDictionary *authDict = [[PersistanceManager sharedInstance]loadLoginDetails];
        
        
        [Data sharedInstance].userID = [authDict valueForKey:@"UserID"];
        [Data sharedInstance].userToken = [authDict valueForKey:@"Token"];
        
        
        [[WebService sharedInstance]authentication];
    }
    NSLog(@"DATA DELEGATE = %@", [Data sharedInstance].delegate);
    
  //  [Data sharedInstance].userID = @"118";
   // [Data sharedInstance].userToken = @"toLCm6bABA";
    
    
    [[WebService sharedInstance]authentication];

    return;

   }

-(void)authenticationSuccessful
{
    NSLog(@"PASSED 1: authenticationSuccessful");
    
    [[WebService sharedInstance]eventsApiRequest:EVENT_API_ALL];
    [[WebService sharedInstance]universities];

}

-(void)universitiesDownloadedSuccessfully
{
    NSLog(@"PASSED 2: universitiesDownloadedSuccessfully");
}

-(void)residencesDownloadedSuccessfully
{
    NSLog(@"PASSED 3: residencesDownloadedSuccessfully");
}
-(void)eventsDownloadedSuccessfully
{
    NSLog(@"PASSED 4: eventsDownloadedSuccessfully");
}
-(void)joinedStatusUpdatedSuccessfully
{
    NSLog(@"PASSED 5: joinedStatusUpdatedSuccessfully");
}
-(void)userParsedSuccessfully
{
    NSLog(@"PASSED 6: userParsedSuccessfully");
}
-(void)eventParsedSuccessfully{
    NSLog(@"PASSED 7: eventParsedSuccessfully");
}


@end
