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

@interface EditProfileTableViewController () <UITextFieldDelegate>
@property (nonatomic) UIDatePicker *datePicker;

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
    
    if (indexPath.row == 1) {
        NSLog(@"one");
    }
    
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

- (IBAction)datePicker:(UITextField *)sender {
    //Create the datePicker, set the mode and assign an action listener to it because I've added to the textview
    [self createDatePicker];
}

#pragma mark - Student ViewController Creation Methods
-(void) createAccomdationMap   {
    AccommodationMapViewController *accommodationMap =[self.storyboard instantiateViewControllerWithIdentifier:@"AccommodationMap"];
    accommodationMap.doneButton.title = @"SAVE";
    accommodationMap.isEditProfile = YES;
    accommodationMap.doneButton.tag = 1;
    [self.navigationController pushViewController:accommodationMap animated:YES];
}

#pragma mark - TextField Delegate Actions

-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
    NSInteger nextTag = textField.tag + 1;
    NSLog(@"tag: %ld", (long)nextTag);
    // Try to find next responder, If the superview of the text field will be a UITableViewCell (contentView) then next responder will be few levels down to access the textfield in order to access the responder be
    UIResponder* nextResponder = [textField.superview.superview.superview viewWithTag:nextTag];
    
    if (nextResponder) {
        NSLog(@"nextResponder: %@", nextResponder);
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    } else {
        // Not found, so remove keyboard.
        [textField resignFirstResponder];
    }
    return NO; // We do not want UITextField to insert line-breaks.
}

- (void)textFieldDidBeginEditing:(UITextField *)textField   {
    
    if (textField.tag == 3) {
        textField.text = @"";
        [self createDatePicker];
    }
}


#pragma mark - Date Picker Methods
- (void)datePickerChanged:(UIDatePicker *)datePicker
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *strDate = [dateFormatter stringFromDate:datePicker.date];
    self.dateOfBirthTextField.text = strDate;
    
    //Change the colour here!!!!!
    self.dateOfBirthTextField.textColor = [UIColor blackColor];
}

-(void) createDatePicker    {
    _datePicker = [[UIDatePicker alloc] init];
    [_datePicker setDatePickerMode:UIDatePickerModeDate];
    [_dateOfBirthTextField setInputView:_datePicker];
    [self.datePicker addTarget:self action:@selector(datePickerChanged:) forControlEvents:UIControlEventValueChanged];
}



@end
