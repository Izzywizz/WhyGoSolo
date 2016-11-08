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
@interface ProfileTableViewController () <DataDelegate>
@property (nonatomic) UIDatePicker *datePicker;
@property User* updatedUser;
@property (strong, nonatomic) IBOutlet UITextField *emailLabel;
@property BOOL canEdit;
@end

@implementation ProfileTableViewController

#pragma mark - UI Table Views

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"People View Loaded");
    [self setNavigationButtonFontAndSize];
    
    ViewSetupHelper *fontSetup = [[ViewSetupHelper alloc] init];
    [fontSetup createCircularView:_profileImage];

    //This prevents the weird the selection animation occuring when the user selects a cell
    [self.tableView setAllowsSelection:NO];

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
    _studentAccommodationTextField.text = _updatedUser.residence.address;
    _dateOfBirthTextField.text = _updatedUser.dobEpoch;
    _emailLabel.text = _updatedUser.email;
    
    _canEdit = YES;
     [_editButton setEnabled:_canEdit];
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"Selected");
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
