//
//  EditProfileTableViewController.m
//  Why Go Solo
//
//  Created by Izzy on 09/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "EditProfileTableViewController.h"

@interface EditProfileTableViewController ()

@end

@implementation EditProfileTableViewController

#pragma mark - UI View Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Edit view loaded");
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
    NSLog(@"Selected row: %ld", (long)indexPath.row);
    if (indexPath.row == 3) {
        NSLog(@"Student Accommodation");
        
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

#pragma mark - Student 

@end
