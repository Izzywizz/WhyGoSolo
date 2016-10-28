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

@interface MainViewController () <DataDelegate>

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Main has been loaded");

   [self checkForToken];
}

-(void)checkForToken
{
    
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
    /** Hides navgiation bar*/
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


@end
