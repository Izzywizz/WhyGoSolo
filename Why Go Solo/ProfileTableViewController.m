//
//  PeopleTableViewController.m
//  Why Go Solo
//
//  Created by Izzy on 09/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "ProfileTableViewController.h"
#import "ViewSetupHelper.h"
#import <UIKit/UIKit.h>
#import "User.h"
#import "Residence.h"
#import "Data.h"
#import "RRCircularImageView.h"
#import "RRDownloadImage.h"
#import "WebService.h"

#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "PersistanceManager.h"

@interface ProfileTableViewController () <DataDelegate, MFMailComposeViewControllerDelegate>
@property (nonatomic) UIDatePicker *datePicker;
@property User* updatedUser;
@property (strong, nonatomic) IBOutlet UITextField *emailLabel;
@property BOOL canEdit;
@end

@implementation ProfileTableViewController

#pragma mark - UI Table Views

- (void)viewPrivacy {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://whygosolo.com/privacy.html"]];
}

- (void)viewTerms {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://whygosolo.com/terms.html"]];
}

- (void)viewSafety {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://whygosolo.com/safety.html"]];
}

-(void)leaveFeedback
{
    if([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailCont = [[MFMailComposeViewController alloc] init];
        mailCont.mailComposeDelegate = self;
        
        [mailCont setSubject:@"Why Go Solo App Feedback"];
        [mailCont setToRecipients:@[@"info@whygosolo.com"]];
        [mailCont setMessageBody:@"" isHTML:NO];
        
        [self presentViewController:mailCont animated:YES completion:nil];
    }
}

#pragma mark - Email Delegate
// Called when the email action has been completed
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"People View Loaded");
    [self setNavigationButtonFontAndSize];
    
    ViewSetupHelper *fontSetup = [[ViewSetupHelper alloc] init];
    [fontSetup createCircularView:_profileImage];

    //This prevents the weird the selection animation occuring when the user selects a cell

}

-(void)viewWillAppear:(BOOL)animated
{
    _canEdit = NO;
    [_editButton setEnabled:_canEdit];
    [Data sharedInstance].selectedUserID = [NSString stringWithFormat:@"%@",[Data sharedInstance].userID];
    [Data sharedInstance].delegate = self;
    [[WebService sharedInstance]eventsApiRequest:USER_API_SINGLE];
}

-(void)userParsedSuccessfully
{
    
    [Data sharedInstance].updatedUser = [Data sharedInstance].selectedUser;
    
    _updatedUser = [Data sharedInstance].updatedUser;
    
    
    NSLog(@"USER UNI ID xxx = %@", [Data sharedInstance].loggedInUser.universityID);
    
        _profileImage.image = [[RRDownloadImage sharedInstance]avatarImageForUserID:[NSString stringWithFormat:@"%@",[Data sharedInstance].userID]];
    [self performSelectorOnMainThread:@selector(setUpProfileFields) withObject:nil waitUntilDone:YES];
}

-(void)setUpProfileFields
{
    NSLog(@"LOGGED IN ADDRESS = %@",[Data sharedInstance].selectedUser.residence.address );
    _firstNameTextField.text = _updatedUser.firstName;
    _lastNameTextField.text = _updatedUser.lastName;
    _studentAccommodationTextField.text = [Data sharedInstance].selectedUser.residence.residenceName;
  //  _dateOfBirthTextField.text = _updatedUser.dobEpoch;
    
    [self dobStringFromEpoch];
    _emailLabel.text = _updatedUser.email;
    
    _canEdit = YES;
     [_editButton setEnabled:_canEdit];
}


-(void)dobStringFromEpoch
{
    
    NSLog(@"wewewewewe");
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    
    
    _dateOfBirthTextField.text = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[[NSString stringWithFormat:@"%@",[Data sharedInstance].selectedUser.dobEpoch]doubleValue]]];
    
    /*
    NSString *strDate = [dateFormatter stringFromDate:datePicker.date];
    
    [dateFormatter dateFromString:<#(nonnull NSString *)#>]
    
     _dateOfBirthTextField.text =
    
    //Change the colour here!!!!!
    self.dateOfBirthField.textColor = [UIColor blackColor];
    self.dateOfBirthLabel.textColor = [UIColor blackColor];
    self.dateOfBirthContentView.backgroundColor = [UIColor blackColor];
    
    [RRRegistration sharedInstance].strDateOfBirth = strDate;
    
    [RRRegistration sharedInstance].dobEpoch = [NSString stringWithFormat:@"%.0f",[datePicker.date  timeIntervalSince1970]];
    
    NSLog(@"REG DOB EPOCH = %@", [RRRegistration sharedInstance].dobEpoch); */

}
-(void)avatarDownloaded
{
    
    NSLog(@"EVENT TV AVATAR DOWNLOADED");
    [self performSelectorOnMainThread:@selector(refreshCellInputViews) withObject:nil waitUntilDone:YES];
}
-(void)refreshCellInputViews
{
    _profileImage.image = [[RRDownloadImage sharedInstance]avatarImageForUserID:[NSString stringWithFormat:@"%@",[Data sharedInstance].userID]];
    NSLog(@"EVENT TV AVATAR RELOAD INPUT VIEWS");
    [self.tableView reloadData];
    // [self.tableView reloadInputViews];
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

#pragma mark - Helper Functions

-(void) setNavigationButtonFontAndSize  {
    
    NSDictionary *attributes = [ViewSetupHelper setNavigationButtonFontAndSize];

    [_editButton setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [_backButton setTitleTextAttributes:attributes forState:UIControlStateNormal];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
   
        NSLog(@"Selected %i ", indexPath.row)
    ;
    if(indexPath.row == 6)
   {[self viewPrivacy]; return;}
  
    if(indexPath.row == 5)
    {[self viewTerms]; return;}

    
    if(indexPath.row == 7)
    {[self viewSafety]; return;}

    
    
    if(indexPath.row == 8)
    {[self leaveFeedback]; return;}

    
    if(indexPath.row == 9)
    {
        [[Data sharedInstance]resetValues];
        [[PersistanceManager sharedInstance]forgetLoginDetails];
        [self.navigationController popToRootViewControllerAnimated:YES]; return;}
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

- (IBAction)editActioin:(id)sender {
    NSLog(@"Edit Pressed");
    if (_canEdit)
    {
        [self performSegueWithIdentifier:@"GoToEdit" sender:self];
    }
}
- (IBAction)backButtonPressed:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
