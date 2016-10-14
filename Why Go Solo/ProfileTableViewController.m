//
//  PeopleTableViewController.m
//  Why Go Solo
//
//  Created by Izzy on 09/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "ProfileTableViewController.h"
#import "ViewSetupHelper.h"
#import <UIKit/UIKit.h>

@interface ProfileTableViewController ()

@end

@implementation ProfileTableViewController

#pragma mark - UI Table Views

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"People View Loaded");
    [self setNavigationButtonFontAndSize];
    
    ViewSetupHelper *fontSetup = [[ViewSetupHelper alloc] init];
    [fontSetup createCircularView:_profileImage];

    //This prevents the weird the selection animation occuring when the user selects a cell
    [self.tableView setAllowsSelection:NO];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath   {
    
    if (indexPath.row == 0) {
        return 160;
    } else  {
        return 70;
    }
}

#pragma mark - Helper Functions

-(void) setNavigationButtonFontAndSize  {
    
    NSDictionary *attributes = [ViewSetupHelper setNavigationButtonFontAndSize];

    [_editButton setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [_backButton setTitleTextAttributes:attributes forState:UIControlStateNormal];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"Selected");
}

#pragma mark - Action Methods

- (IBAction)editActioin:(id)sender {
    NSLog(@"Edit Pressed");
}
- (IBAction)backButtonPressed:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
