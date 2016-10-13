//
//  SignInTableViewController.m
//  Why Go Solo
//
//  Created by Izzy on 16/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "SignInTableViewController.h"
#import "FontSetup.h"
#import "RRRegistration.h"

@interface SignInTableViewController ()


/**
 Use the container view for each tableView cell and set the constraints of the view to 1 top/botom but 0 on the others
 make a reference to that specifc container like emailContentView
 */

@end

@implementation SignInTableViewController

#pragma mark - UI Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"SignIn Table VC");
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero]; // Prevents the tableView from drawing any more empty unused cell
    self.tableView.allowsSelection = YES; //becareful this may disable button interaction.
    [self setupCustomActions];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action Methods

- (IBAction)backButtonPressed:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//TODO: Need tro validation propery for email and changing the colour of the selction inserts
- (IBAction)signinButtonPressed:(UIButton *)sender {
    NSLog(@"Sign In Button");
    RRRegistration *registration = [[RRRegistration alloc] init];
    registration.password = _passwordTextField.text;
    registration.confirmPassword = @"test";// placeholder password
    FontSetup *fontSetup = [FontSetup new];
    
    if(![registration validateTextField:_passwordTextField])    {
        [fontSetup setColourOf:_passwordContentView toLabel:_passwordLabel toTextField:_passwordTextField toMessage:@"Enter your Password"];
    }
    
    if ([registration validateTextField:_emailAddressTextField] && [registration validateTextField:_passwordTextField]) {
        NSLog(@"Correctly signed in");
    } else if (![registration validateTextField:_emailAddressTextField])    {
        [fontSetup setColourOf:_emailAddressContentView toLabel:_emailAddressLabel toTextField:_emailAddressTextField toMessage:@"Enter your email address"];
    } else  {
        [self alertSetupandView:@"Incorrect Password/ Email" andMessage:@"Please type in your correct email/ password comibation"];
    }
}

- (IBAction)forgotButtonPressed:(UIButton *)sender {
    NSLog(@"Forgot Button");
}

#pragma mark - TextField Delegate (custom)
/** vldiation method to make sure an email address has been entered*/
-(void)textFieldDidChange: (UITextField *) theTextField {
    FontSetup *fontSetup = [FontSetup new];
    
    if ([_emailAddressTextField.text isEqualToString:@""]) {
        [fontSetup setColourOf:_emailAddressContentView toLabel:_emailAddressLabel toTextField:_emailAddressTextField toMessage:@"Enter your email address"];
    } else  {
        [fontSetup setColourGrayAndBlack:_emailAddressContentView toLabel:_emailAddressLabel toTextField:_emailAddressTextField toMessage:@"Enter your email address"];
    }
    
    if ([_passwordTextField.text isEqualToString: @""]) {
        [fontSetup setColourOf:_passwordContentView toLabel:_passwordLabel toTextField:_passwordTextField toMessage:@"Enter your Password"];
    } else  {
        [fontSetup setColourGrayAndBlack:_passwordContentView toLabel:_passwordLabel toTextField:_passwordTextField toMessage:@"Enter your Password"];
    }
    
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

-(void) setupCustomActions  {
    [_emailAddressTextField addTarget:self
                               action:@selector(textFieldDidChange:)
                     forControlEvents:UIControlEventEditingChanged];
    
    [_passwordTextField addTarget:self
                           action:@selector(textFieldDidChange:)
                 forControlEvents:UIControlEventEditingChanged];
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    NSLog(@"Section: %ld, row: %ld", (long)indexPath.section, (long)indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; //remove the selection animation
    if (indexPath.row == 0) {
        [_emailAddressTextField becomeFirstResponder];
    } else if (indexPath.row == 1)  {
        [_passwordTextField becomeFirstResponder];
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

#pragma mark - Alert View Setup
-(void) alertSetupandView: (NSString *) WithTitle andMessage: (NSString *) message  {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:WithTitle message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *dismiss = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Dismiss");
    }];
    [alertVC addAction:dismiss];
    [self presentViewController:alertVC animated:YES completion:nil];
}

@end
