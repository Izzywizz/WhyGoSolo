//
//  ChangePasswordTableViewController.m
//  Why Go Solo
//
//  Created by Izzy on 16/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "ChangePasswordTableViewController.h"

@interface ChangePasswordTableViewController ()

@property UIBarButtonItem *backButton;
@property UIBarButtonItem *saveButton;

@end

@implementation ChangePasswordTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Change Password Screen");
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self createNavigationTitleAndItems];
    [self setNavigationButtonFontAndSize];
    
    
    //This prevents the weird the selection animation occuring when the user selects a cell
    [self.tableView setAllowsSelection:NO];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Helper Functions
/** Ensures that the selection seperators are setup before the main views are shown*/

-(void) createNavigationTitleAndItems   {
    self.navigationItem.title = @"Change Password";
    
    _backButton = [[UIBarButtonItem alloc]
                   initWithTitle:@"BACK"
                   style:UIBarButtonItemStylePlain
                   target:self
                   action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem = _backButton;
    
    _saveButton = [[UIBarButtonItem alloc]
                   initWithTitle:@"SAVE"
                   style:UIBarButtonItemStylePlain
                   target:self
                   action:@selector(save)];
    self.navigationItem.rightBarButtonItem = _saveButton;
}


-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void) setNavigationButtonFontAndSize  {
    
    NSDictionary *attributes = [ViewSetupHelper setNavigationButtonFontAndSize];
    [ _backButton setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [ _saveButton setTitleTextAttributes:attributes forState:UIControlStateNormal];
    _backButton.tintColor = [UIColor grayColor];
    _saveButton.tintColor = [UIColor grayColor];
    
}

-(void) goBack  {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) save    {
    NSLog(@"Save button pressesd");
}

#pragma mark - Table view data source

/** Allows the cell selection seperators (the grey line across the tableView Cell) to extend across the entire table view */
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}





@end
