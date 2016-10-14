//
//  EditProfileTableViewController.m
//  Why Go Solo
//
//  Created by Izzy on 09/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "EditProfileTableViewController.h"
#import "AccommodationMapViewController.h"
#import "ViewSetupHelper.h"

@interface EditProfileTableViewController ()

@end

@implementation EditProfileTableViewController

#pragma mark - UI View Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Edit view loaded");
    
    ViewSetupHelper *fontSetup = [ViewSetupHelper new];
    [fontSetup createCircularView:_profileView];

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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 3) {
        [self createAccomdationMap];
    }
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath    {
        cell.separatorInset = UIEdgeInsetsZero;
        cell.preservesSuperviewLayoutMargins = false;
        cell.layoutMargins = UIEdgeInsetsZero;
}

#pragma mark - Action Methods

- (IBAction)changePassword:(UIButton *)sender {
    NSLog(@"Change Password");
}


- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Student ViewController Creation Methods
-(void) createAccomdationMap   {
    AccommodationMapViewController *accommodationMap =[self.storyboard instantiateViewControllerWithIdentifier:@"AccommodationMap"];
    accommodationMap.doneButton.title = @"SAVE";
    accommodationMap.isEditProfile = YES;
    accommodationMap.doneButton.tag = 1;
    [self.navigationController pushViewController:accommodationMap animated:YES];
}

@end
