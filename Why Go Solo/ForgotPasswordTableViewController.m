//
//  ForgotPasswordTableViewController.m
//  Why Go Solo
//
//  Created by Izzy on 19/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "ForgotPasswordTableViewController.h"
#import "WebService.h"
#import "Data.h"
@interface ForgotPasswordTableViewController () <UITextFieldDelegate, DataDelegate>
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UITextField *emailAddressTextField;

@end

@implementation ForgotPasswordTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Password forgotten");
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _resetButton.enabled = NO;
    self.tableView.allowsSelection = NO; //becareful this may disable button interaction.    
}

-(void)viewWillAppear:(BOOL)animated
{
    [Data sharedInstance].passwordResetEmail = @"";
    [Data sharedInstance].delegate = self;
}


-(void)viewWillDisappear:(BOOL)animated
{
    [Data sharedInstance].delegate = nil;
     [Data sharedInstance].passwordResetEmail = @"";
}

- (IBAction)editDidChange:(UITextField *)sender {
        if ([_emailAddressTextField.text isEqualToString:@""]) {
            _resetButton.enabled = NO;
        }
        else {
            _resetButton.enabled = YES;
        }
}

-(void)passwordResetSuccessful
{
    [self performSelectorOnMainThread:@selector(handleUpdates) withObject:nil waitUntilDone:NO];
}

-(void)handleUpdates
{
    NSLog(@"EMAIL XXX - %@",[Data sharedInstance].passwordResetEmail);
    if (![[Data sharedInstance].passwordResetEmail isEqualToString:@"EMAIL NOT FOUND"]) {
        [Data sharedInstance].passwordResetEmail = @"PASSWORD RESET SENT TO EMAIL";
    }
    _emailAddressTextField.text = [Data sharedInstance].passwordResetEmail;
    
    [Data sharedInstance].passwordResetEmail = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helper Functions

/** Ensures that the selection seperators are setup before the main views are shown*/
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

//** Creates a empty header but of the same colour stated in the design*/
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,tableView.frame.size.width,30)];
    
    [headerView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return  60.0;
}

#pragma mark - Action Methods
- (IBAction)resetButtonPressed:(UIButton *)sender {
    NSLog(@"RESET");

    [Data sharedInstance].passwordResetEmail = _emailAddressTextField.text;
    [[WebService sharedInstance]eventsApiRequest:USER_API_RESET_PASSWORD];
  //  [[NSNotificationCenter defaultCenter] postNotificationName:@"passwordReset" object:self];

}

- (IBAction)backButtonPressed:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
