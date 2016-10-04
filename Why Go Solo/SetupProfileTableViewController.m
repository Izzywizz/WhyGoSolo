//
//  SetupProfileTableViewController.m
//  Why Go Solo
//
//  Created by Izzy on 15/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "SetupProfileTableViewController.h"

@interface SetupProfileTableViewController ()<UIImagePickerControllerDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *dateOfBirthField;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (nonatomic) UIDatePicker *datePicker;
@end

@implementation SetupProfileTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (void)selectPhoto {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
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
}

#pragma mark - Action Methods

/** */
- (IBAction)datePicker:(UITextField *)sender {
    
    //Create the datePicker, set the mode and assign an action listener to it because I've added to the textview
     _datePicker = [[UIDatePicker alloc] init];
    [_datePicker setDatePickerMode:UIDatePickerModeDate];
    [_dateOfBirthField setInputView:_datePicker];
    [self.datePicker addTarget:self action:@selector(datePickerChanged:) forControlEvents:UIControlEventValueChanged];

}

- (IBAction)uploadPhotoButton:(UIButton *)sender {
    NSLog(@"Upload Photo");
    [self selectPhoto];
}

- (IBAction)backButtonPressed:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)nextButtonPressed:(UIBarButtonItem *)sender {
    NSLog(@"Next Button Pressed");
}

@end
