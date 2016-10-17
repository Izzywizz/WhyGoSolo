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
#import "SetupProfileTableViewController.h"
#import "SetupLoginDetailsViewController.h"


@interface EditProfileTableViewController () <UITextFieldDelegate>
@property (nonatomic) UIDatePicker *datePicker;
@property (nonatomic) UIView *overlayView;

@end

@implementation EditProfileTableViewController

#pragma mark - UI View Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupObservers];
    NSLog(@"Edit view loaded");
    
    ViewSetupHelper *fontSetup = [ViewSetupHelper new];
    [fontSetup createCircularView:_profileView];
    [self setNavigationButtonFontAndSize];
    _deleteButton.layer.cornerRadius = 5;

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

- (IBAction)uploadButtonPressed:(UIButton *)sender {
    [self createActionSheet];
}

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
- (IBAction)deleteButtonPressed:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"deleteOverlayView" object:self];
    [self setupDeleteOverlay:@"Delete Account" andTextBody:@"Are you sure you want to delete your account?" andTag:3];
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
    [textField resignFirstResponder];
    return YES;
}

//Remove keyboard when background is pressed
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan:withEvent:");
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField   {
    
    if (textField.tag == 0) {
        [self ObtainEmailSuffix];
    }
    
    if (textField.tag == 3) {
        //either blank it or pull down the previous address
        textField.text = self.dateOfBirthTextField.text;
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
    
    //create the done button to remove
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolbar.barStyle   = UIBarStyleBlackTranslucent;
    UIBarButtonItem *itemDone  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self.dateOfBirthTextField action:@selector(resignFirstResponder)];
    UIBarButtonItem *itemSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    toolbar.items = @[itemSpace,itemDone];
    
    _datePicker = [[UIDatePicker alloc] init];
    [_datePicker setDatePickerMode:UIDatePickerModeDate];
    [_dateOfBirthTextField setInputView:_datePicker];
    [self.datePicker addTarget:self action:@selector(datePickerChanged:) forControlEvents:UIControlEventValueChanged];
    self.dateOfBirthTextField.inputAccessoryView = toolbar;
}

#pragma mark - OverlayView Methods
/*ensures that the view added streches properly to the screen*/
- (void) stretchToSuperView:(UIView*) view {
    view.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *bindings = NSDictionaryOfVariableBindings(view);
    NSString *formatTemplate = @"%@:|[view]|";
    for (NSString * axis in @[@"H",@"V"]) {
        NSString * format = [NSString stringWithFormat:formatTemplate,axis];
        NSArray * constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:bindings];
        [view.superview addConstraints:constraints];
    }
}

-(void) setupDeleteOverlay:(NSString *)eventTitle andTextBody:(NSString *)textBody andTag:(NSInteger) tag    {
    OverlayView *overlayVC = [OverlayView overlayView];
    overlayVC.eventTitle.text = eventTitle;
    overlayVC.eventText.text = textBody;
    [overlayVC.internalView setTag:tag];
    self.view.bounds = overlayVC.bounds;
    [self.view addSubview:overlayVC];
    [self stretchToSuperView:self.view];
    self.overlayView = overlayVC;
}

-(void) removeOverlay: (NSNotification *) notifcation   {
    if ([[notifcation name] isEqualToString:@"removeOverlay"]) {
        [self deleteOverlayAlpha:0 animationDuration:0.2f];
    }
}

-(void) deleteConfirmation: (NSNotification *) notifcation   {
    if ([[notifcation name] isEqualToString:@"deleteConfirmation"]) {
        [self performSegueWithIdentifier:@"GoToDeleteConfirmation" sender:self];
    }
}

-(void)deleteOverlayAlpha:(int)a animationDuration:(float)duration
{
    [UIView animateWithDuration:duration delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        for (id x in self.overlayView.subviews)
        {
            if ([x class] == [UIView class])
            {
                [(UIView*)x setAlpha:a];
            }
        }
        self.overlayView.alpha = a;
    } completion:nil];
}

#pragma mark - Helper Functions

-(void) setupObservers    {
    //When the profile button is pressed the observer knows it has been pressed and this actiavted the the action assiociated with it
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeOverlay:) name:@"removeOverlay" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteConfirmation:) name:@"deleteConfirmation" object:nil];
    
}

-(void) setNavigationButtonFontAndSize  {
    
    NSDictionary *attributes = [ViewSetupHelper setNavigationButtonFontAndSize];
    
    [_saveButton setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [_cancelButton setTitleTextAttributes:attributes forState:UIControlStateNormal];
}

-(void) ObtainEmailSuffix{
    SetupLoginDetailsViewController *email = [[SetupLoginDetailsViewController alloc] init];
    NSLog(@"EMail:",[email obtainAndSetEmailSuffix]);

}
#pragma mark - Photo Methods

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


@end
