//
//  SetupProfileTableViewController.m
//  Why Go Solo
//
//  Created by Izzy on 15/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "SetupProfileTableViewController.h"

@interface SetupProfileTableViewController ()

@end

@implementation SetupProfileTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _roundImageUploadView.layer.cornerRadius = _roundImageUploadView.bounds.size.width/2;
    _roundImageUploadView.layer.masksToBounds = YES;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


#pragma mark - Action Methods

- (IBAction)uploadPhotoButton:(UIButton *)sender {
    NSLog(@"Upload Photo");
}


@end
