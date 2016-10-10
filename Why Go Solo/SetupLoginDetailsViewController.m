//
//  SetupLoginDetailsViewController.m
//  Why Go Solo
//
//  Created by Izzy on 14/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "SetupLoginDetailsViewController.h"
#import "Data.h"
#import "University.h" //Used to get email suffix
#import "RRRegistration.h"

@interface SetupLoginDetailsViewController () <UITextFieldDelegate>

//email/ password/ confrim password validation



@property(strong, nonatomic) University *university; //Able to access

@end

@implementation SetupLoginDetailsViewController

#pragma mark - UI Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationButtonFontAndSize];
    self.hasTermsAgreed = false;
    [self obtainAndSetEmailSuffix];
    
    //This prevents the weird the selection animation occuring when the user selects a cell
    [self.tableView setAllowsSelection:NO];
    self.emailAddressTextField.delegate = self;
    
    NSLog(@"Setup Login Details");
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

-(void)viewDidDisappear:(BOOL)animated    {
    self.emailAddressTextField.delegate = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextField Delegate

/* Ensure that the caret goes to beginning of the textfield*/
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    textField.selectedTextRange = [textField
                                   textRangeFromPosition:textField.beginningOfDocument
                                   toPosition:textField.beginningOfDocument];
}

#pragma mark - Helper Functions

-(void)  obtainAndSetEmailSuffix  {
    _university = [[University alloc] init];
    _university = [Data sharedInstance].selectedUniversity;
    NSLog(@"Email Suffix: %@", _university.emailSuffix);
    
    _emailAddressTextField.text = [NSString stringWithFormat:@"@%@",_university.emailSuffix];
}
-(void) setNavigationButtonFontAndSize  {
    
    NSDictionary *attributes = [FontSetup setNavigationButtonFontAndSize];
    
    [_nextButton setTitleTextAttributes:attributes forState:UIControlStateNormal];
}

-(void) setupTable  {
    self.tableView.allowsSelectionDuringEditing=YES;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 66;
//    self.tableView.allowsSelection = NO;
}


/** Ensures that the selection seperators are setup before the  main views are shown*/
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

-(void) setColourOf: (UIView *)view toLabel: (UILabel *)label toTextField: (UITextField *)textfield toMessage: (NSString *)message  {
    UIColor *colour = [UIColor redColor];

    view.backgroundColor = colour;
    label.textColor = colour;
    textfield.textColor = colour;
    textfield.attributedPlaceholder = [[NSAttributedString alloc] initWithString:message attributes:@{NSForegroundColorAttributeName: colour}];

}

#pragma mark - Actions Methods
- (IBAction)backbuttonPressed:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)nextButtonPressed:(UIBarButtonItem *)sender {
    RRRegistration *registration = [[RRRegistration alloc] init];
    registration.password = _passwordTextField.text;
    registration.confirmPassword = _confirmPasswordTextField.text;
    
    if (![registration validateTextField:_emailAddressTextField]) {
        [self setColourOf:_emailContentView toLabel:_emailAddressLabel toTextField:_emailAddressTextField toMessage:@"Enter your email address"];
    }
    
    if(![registration validateTextField:_passwordTextField])    {
        [self setColourOf:_passwordContentView toLabel:_passwordLabel toTextField:_passwordTextField toMessage:@"Enter your password"];
    }
    
    if(![registration validateTextField:_passwordTextField])    {
        [self setColourOf:_confirmPasswordContentView toLabel:_confirmPasswordLabel toTextField:_confirmPasswordTextField toMessage:@"Confirm Your Password"];
    }

    if (_hasTermsAgreed) {
        if ([registration validateTextField:_emailAddressTextField] && [registration validateTextField:_passwordTextField] && [registration validateTextField:_confirmPasswordTextField]) {
            [self performSegueWithIdentifier:@"GoToProfile" sender:self];
        } else if (![registration validateTextField:_passwordTextField] || [registration validateTextField:_confirmPasswordTextField]) {
            [self alertSetupandView:@"Password" andMessage:@"Your passwords do not match"];
        }
    
    } else {
        [self alertSetupandView:@"Terms" andMessage:@"Please read and agree to the terms"];
    }
}


- (IBAction)termsAgreed:(UISwitch *)sender {
    self.hasTermsAgreed = false; //intially the switch is false

    if (sender.on) {
        self.hasTermsAgreed = true;
    } else {
        self.hasTermsAgreed = false;
    }
}

#pragma mark - Table view data source

/** Allows the cell selection seperators (the grey line across the tableView Cell) to extend across the entire table view */
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 3) {
        cell.separatorInset = UIEdgeInsetsMake(0, 1000, 0, 0); //removes insert
    }
    else  {
        [cell setSeparatorInset:UIEdgeInsetsZero];
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark - TableView Delegates

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    NSLog(@"row: %ld, section: %ld", (long)indexPath.row, (long)indexPath.section);
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; //remove the selection animation
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,tableView.frame.size.width,30)];
    
    [headerView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return  30.0;
}

#pragma mark - Alert View Controller

-(void) alertSetupandView: (NSString *) WithTitle andMessage: (NSString *) message  {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:WithTitle message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *dismiss = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Dismiss");
    }];
    [alertVC addAction:dismiss];
    [self presentViewController:alertVC animated:YES completion:nil];
}

@end
