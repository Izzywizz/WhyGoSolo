//
//  MainViewController.m
//  Why Go Solo
//
//  Created by Izzy on 14/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "MainViewController.h"
#import "WebService.h"
#import "Data.h"
#import "PersistanceManager.h"
#import "EventTableViewController.h"
#import "WebServiceRequestTest.h"
#import "University.h"
#import "Event.h"
@interface MainViewController () <DataDelegate>

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Main has been loaded");
    
    WebServiceRequestTest *wsTest = [[WebServiceRequestTest alloc]initWithTests];
    
//        [self runTests];
  //  return;
//   [self checkForToken];
}



////
/*
-(void)runTests
{
     [[WebService sharedInstance]universities];
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
    
    
 //   [[WebService sharedInstance]authentication];
    
    return;
    
}

-(void)authenticationSuccessful
{
    NSLog(@"PASSED 1: authenticationSuccessful");
    
    [[WebService sharedInstance]eventsApiRequest:EVENT_API_ALL];
   
    
}

-(void)universitiesDownloadedSuccessfully
{
    NSLog(@"PASSED 2: universitiesDownloadedSuccessfully");
    [Data sharedInstance].selectedUniversity = [[Data sharedInstance].universitesArray objectAtIndex:0];
    
    [[WebService sharedInstance]residences];

}

-(void)residencesDownloadedSuccessfully
{
    NSLog(@"PASSED 3: residencesDownloadedSuccessfully");
}
-(void)eventsDownloadedSuccessfully
{
    NSLog(@"PASSED 4: eventsDownloadedSuccessfully");
    [[WebService sharedInstance]eventsApiRequest:EVENT_API_SINGLE];
    
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
    
    [[WebService sharedInstance]eventsApiRequest:EVENT_API_JOIN];
}
*/

///

-(void)checkForToken
{        NSLog(@"TESTE TEST %@", TEST);

    
  //  [WebService sharedInstance].registerAccount;
    [Data sharedInstance].delegate = self;
      //[[WebService sharedInstance]authentication];
    if (![[PersistanceManager sharedInstance]loadLoginDetails])
    {
        [[WebService sharedInstance]universities];
    }
    else
    {
        NSDictionary *authDict = [[PersistanceManager sharedInstance]loadLoginDetails];
        
        
        [Data sharedInstance].userID = [authDict valueForKey:@"UserID"];
        [Data sharedInstance].userToken = [authDict valueForKey:@"Token"];
        

        [[WebService sharedInstance]authentication];
    }
}

-(void)authenticationSuccessful
{
    
    NSLog(@"AUTH DELEGATE RECEIVED");
    EventTableViewController *vc = [[EventTableViewController alloc]initWithStoryboard];
    
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated   {
    //Hides navgiation bar
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

-(void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [Data sharedInstance].delegate = nil;

}

- (IBAction)signInButtonPressed:(UIButton *)sender {
    NSLog(@"Signning In");
}

- (IBAction)signUpButtonPressed:(UIButton *)sender {
     NSLog(@"Signning Up");
}

/*
*/

@end
