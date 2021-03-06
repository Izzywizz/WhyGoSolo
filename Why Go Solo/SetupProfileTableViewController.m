//
//  SetupProfileTableViewController.m
//  Why Go Solo
//
//  Created by Izzy on 15/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "SetupProfileTableViewController.h"
#import "RRRegistration.h"
#import "ViewSetupHelper.h"

@interface SetupProfileTableViewController ()<UIImagePickerControllerDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) UIDatePicker *datePicker;

@end

@implementation SetupProfileTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCustomActions];
    self.lastNameTextField.delegate = self;
    
    [self setupCameraView];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero]; // Prevents the tableView from drawing any more empty unused cells
    [self setNavigationButtonFontAndSize];
    
    [self.tableView setAllowsSelection:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


#pragma mark - Helper Functions
/** create the round affect camera upload view, including border colour */
-(void) setupCameraView {
    _roundImageUploadView.layer.cornerRadius = _roundImageUploadView.bounds.size.width/2; //create circular profile view
    _roundImageUploadView.layer.borderWidth = 0.5;
    _roundImageUploadView.layer.borderColor = [[UIColor grayColor] CGColor];
    _roundImageUploadView.layer.masksToBounds = YES;
}

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

-(void) setNavigationButtonFontAndSize  {
    
    NSDictionary *attributes = [ViewSetupHelper setNavigationButtonFontAndSize];
    
    [_nextButton setTitleTextAttributes:attributes forState:UIControlStateNormal];
}

-(void)textFieldDidChange: (UITextField *) theTextField {
    
    RRRegistration *registration = [[RRRegistration alloc] init];
    ViewSetupHelper *fontSetup = [ViewSetupHelper new];
    
    if (![registration validateTextField:_firstNameTextField]) {
        [fontSetup setColourOf:_firstNameContentView toLabel:_firstNameLabel toTextField:_firstNameTextField toMessage:@"Enter your First Name"];
    } else  {
        [fontSetup setColourGrayAndBlack:_firstNameContentView toLabel:_firstNameLabel toTextField:_firstNameTextField toMessage:@"Enter your First Name"];
    }
    
    if (![registration validateTextField:_lastNameTextField]) {
        [fontSetup setColourOf:_lastNameContentView toLabel:_lastNameLabel toTextField:_lastNameTextField toMessage:@"Enter your Last Name"];
    } else  {
        [fontSetup setColourGrayAndBlack:_lastNameContentView toLabel:_lastNameLabel toTextField:_lastNameTextField toMessage:@"Enter your Last Name"];
    }
    
    if ([_dateOfBirthField.text isEqualToString:@""]) {
        [fontSetup setColourOf:_dateOfBirthContentView toLabel:_dateOfBirthLabel toTextField:_dateOfBirthField toMessage:@"Enter your Date of Birth"];
    }
}


#pragma mark - PHoto MEthods

-(void) createActionSheet   {
    UIAlertController *alertSheet = [UIAlertController alertControllerWithTitle:nil message:@"Please select photo or camera" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *album = [UIAlertAction actionWithTitle:@"Album" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self takePhotoOrAlbum:UIImagePickerControllerSourceTypePhotoLibrary];
    }];
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Camera");
        [self takePhotoOrAlbum:UIImagePickerControllerSourceTypeCamera];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Dismiss ACtion Sheet");
    }];
    
    [alertSheet addAction:album];
    [alertSheet addAction:camera];
    [alertSheet addAction:cancel];
    
    [self presentViewController:alertSheet animated:YES completion:nil];
}



-(void) takePhotoOrAlbum: (UIImagePickerControllerSourceType) source   {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = source;
    
    [self presentViewController:picker animated:YES completion:NULL];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.profileImageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

#pragma mark - Table view delegates

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Section: %ld, Row: %ld", (long)indexPath.section, (long)indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; //remove the selection animation
    
    if (indexPath.row == 0) {
        [_firstNameTextField becomeFirstResponder];
    } else if (indexPath.row == 1)  {
        [_lastNameTextField becomeFirstResponder];
    } else if (indexPath.row == 2)  {
        [_dateOfBirthField becomeFirstResponder];
    }
}


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

#pragma mark - Date Picker Methods

/*
- (void)datePickerChanged:(UIDatePicker *)datePicker
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
   
     [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    self.dateOfBirthField.text = [dateFormatter stringFromDate:datePicker.date];
    
    
    NSString *strDate = [dateFormatter stringFromDate:datePicker.date];
   
    
    
    
    //Change the colour here!!!!!
    self.dateOfBirthField.textColor = [UIColor blackColor];
    self.dateOfBirthLabel.textColor = [UIColor blackColor];
    self.dateOfBirthContentView.backgroundColor = [UIColor blackColor];
    
    [RRRegistration sharedInstance].strDateOfBirth = strDate;

    [RRRegistration sharedInstance].dobEpoch = [NSString stringWithFormat:@"%.0f",[datePicker.date  timeIntervalSince1970]];
    
    NSLog(@"REG DOB EPOCH = %@", [RRRegistration sharedInstance].dobEpoch);

}

*/



- (void)datePickerChanged:(UIDatePicker *)datePicker
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    
    self.dateOfBirthField.text = [dateFormatter stringFromDate:datePicker.date];
    
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];

    NSString *strDate = [dateFormatter stringFromDate:datePicker.date];
    
    
    
    [RRRegistration sharedInstance].strDateOfBirth = strDate;
    
    [RRRegistration sharedInstance].dobEpoch = [NSString stringWithFormat:@"%.0f",[datePicker.date  timeIntervalSince1970]];
    
    NSLog(@"REG DOB EPOCH = %@", [RRRegistration sharedInstance].dobEpoch);
    
}

#pragma mark - Action Methods

/** Calls the date picker from IOS, hides the caret using the same colour aka clear*/
- (IBAction)datePicker:(UITextField *)sender {
    
    //Create the datePicker, set the mode and assign an action listener to it because I've added to the textview
    _datePicker = [[UIDatePicker alloc] init];
    [_datePicker setDatePickerMode:UIDatePickerModeDate];
    
    //set intial date to 18 years ago
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDate *now = [NSDate date];
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:now];
    [comps setYear:[comps year] - 18];
    NSDate *eighteenYearsAgo = [gregorian dateFromComponents:comps];
    
    // Date must be between 18 - 100
    NSDate *todaysDate = [NSDate date];
    NSDateComponents *minDateComponents = [[NSDateComponents alloc] init];
    [minDateComponents setYear:-100];
    NSDate *minDate = [gregorian dateByAddingComponents:minDateComponents toDate:todaysDate  options:0];
    
    NSDateComponents *maxDateComponents = [[NSDateComponents alloc] init];
    [maxDateComponents setYear:-18];
    NSDate *maxDate = [gregorian dateByAddingComponents:maxDateComponents toDate:todaysDate  options:0];
    
    [_datePicker setDate:eighteenYearsAgo];
    [_datePicker setMinimumDate:minDate];
    [_datePicker setMaximumDate:maxDate];
    
    [_dateOfBirthField setInputView:_datePicker];
    [self.datePicker addTarget:self action:@selector(datePickerChanged:) forControlEvents:UIControlEventValueChanged];
    
}

- (IBAction)uploadPhotoButton:(UIButton *)sender {
    NSLog(@"Upload Photo");
    [self createActionSheet];
    //    [self selectPhoto];
}

- (IBAction)backButtonPressed:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)nextButtonPressed:(UIBarButtonItem *)sender {
    NSLog(@"Next-> Accommodation");
    RRRegistration *registration = [[RRRegistration alloc] init];
    ViewSetupHelper *fontSetup = [ViewSetupHelper new];
    
    CGImageRef cgref = [_profileImageView.image CGImage];
    CIImage *cim = [_profileImageView.image CIImage];
    registration.cgref = cgref;
    registration.cim = cim;
    
    if (![registration validateTextField:_firstNameTextField]) {
        [fontSetup setColourOf:_firstNameContentView toLabel:_firstNameLabel toTextField:_firstNameTextField toMessage:@"Enter your First Name"];
    }
    
    if (![registration validateTextField:_lastNameTextField]) {
        [fontSetup setColourOf:_lastNameContentView toLabel:_lastNameLabel toTextField:_lastNameTextField toMessage:@"Enter your Last Name"];
    }
    
    if ([_dateOfBirthField.text isEqualToString:@""]) {
        [fontSetup setColourOf:_dateOfBirthContentView toLabel:_dateOfBirthLabel toTextField:_dateOfBirthField toMessage:@"Enter your Date of Birth"];
    }
    
    
    if (![registration validatePhotoImageRef:cgref andImageData:cim]) {
        [self alertSetupandView:@"Photo" andMessage:@"Please take or upload a photo"];
    }
    
    if ([registration validateTextField:_firstNameTextField] && [registration validateTextField:_lastNameTextField] && ![_dateOfBirthField.text isEqualToString:@""]) {
        [self performSegueWithIdentifier:@"GoToAccommodation" sender:self];
    }

    [RRRegistration sharedInstance].firstName = _firstNameTextField.text;
    [RRRegistration sharedInstance].lastName = _lastNameTextField.text;
    [RRRegistration sharedInstance].strDateOfBirth = _dateOfBirthField.text;
    
    [RRRegistration sharedInstance].profilePhoto = _profileImageView.image;


}

-(void) setupCustomActions  {
    [_firstNameTextField addTarget:self
                               action:@selector(textFieldDidChange:)
                     forControlEvents:UIControlEventEditingChanged];
    
    [_lastNameTextField addTarget:self
                           action:@selector(textFieldDidChange:)
                 forControlEvents:UIControlEventEditingChanged];
    
    [_dateOfBirthField addTarget:self
                                  action:@selector(textFieldDidChange:)
                        forControlEvents:UIControlEventEditingChanged];
}


#pragma mark - Alert Method
-(void) alertSetupandView: (NSString *) WithTitle andMessage: (NSString *) message  {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:WithTitle message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *dismiss = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Dismiss");
    }];
    [alertVC addAction:dismiss];
    [self presentViewController:alertVC animated:YES completion:nil];
}

@end
