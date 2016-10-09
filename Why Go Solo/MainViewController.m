//
//  MainViewController.m
//  Why Go Solo
//
//  Created by Izzy on 14/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "MainViewController.h"
#import "WebService.h"
#import "PersistanceManager.h"
#import "EventTableViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Main has been loaded");

    [self checkForToken];
}

-(void)checkForToken
{
    if (![[PersistanceManager sharedInstance]loadLoginDetails])
    {
      //  [[WebService sharedInstance]universities];
    }
    else
    {
        [[WebService sharedInstance]authentication];
    }
}

-(void)authenticationSuccessful
{
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
}

- (IBAction)signInButtonPressed:(UIButton *)sender {
    NSLog(@"Signning In");
}

- (IBAction)signUpButtonPressed:(UIButton *)sender {
     NSLog(@"Signning Up");
}


@end
