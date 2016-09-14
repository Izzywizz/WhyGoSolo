//
//  SetupLoginDetailsViewController.m
//  Why Go Solo
//
//  Created by Izzy on 14/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "SetupLoginDetailsViewController.h"

@interface SetupLoginDetailsViewController ()

@end

@implementation SetupLoginDetailsViewController

#pragma mark - UI Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Setup Login Details");
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions Methods
- (IBAction)backbuttonPressed:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
