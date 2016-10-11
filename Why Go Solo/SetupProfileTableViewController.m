//
//  SetupProfileTableViewController.m
//  Why Go Solo
//
//  Created by Izzy on 15/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "SetupProfileTableViewController.h"
#import "RRRegistration.h"
#import "FontSetup.h"

@interface SetupProfileTableViewController ()<UIImagePickerControllerDelegate, UITextFieldDelegate>



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
    
    [self.tableView setAllowsSelection:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - TextField Delegate Actions

- (IBAction)lastNameFinshed:(UITextField *)sender {
    [_lastNameTextField resignFirstResponder];
}

- (IBAction)lastNameBegin:(UITextField *)sender {
    [_lastNameTextField becomeFirstResponder];
}
- (IBAction)firstNameBegin:(UITextField *)sender {
    [_firstNameTextField becomeFirstResponder];
}
- (IBAction)firstNameFinshed:(UITextField *)sender {
    [_firstNameTextField resignFirstResponder];
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
    
    NSDictionary *attributes = [FontSetup setNavigationButtonFontAndSize];
    
    [_nextButton setTitleTextAttributes:attributes forState:UIControlStateNormal];
}

-(void)textFieldDidChange: (UITextField *) theTextField {
    
    RRRegistration *registration = [[RRRegistration alloc] init];
    FontSetup *fontSetup = [FontSetup new];
    
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

#pragma mark - Date Picker Methods
- (void)datePickerChanged:(UIDatePicker *)datePicker
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *strDate = [dateFormatter stringFromDate:datePicker.date];
    self.dateOfBirthField.text = strDate;
    
    //Change the colour here!!!!!
    self.dateOfBirthField.textColor = [UIColor blackColor];
    self.dateOfBirthLabel.textColor = [UIColor blackColor];
    self.dateOfBirthContentView.backgroundColor = [UIColor blackColor];
    
}

#pragma mark - Action Methods

/** Calls the date picker from IOS*/
- (IBAction)datePicker:(UITextField *)sender {
    
    //Create the datePicker, set the mode and assign an action listener to it because I've added to the textview
    _datePicker = [[UIDatePicker alloc] init];
    [_datePicker setDatePickerMode:UIDatePickerModeDate];
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
    FontSetup *fontSetup = [FontSetup new];
    
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
