//
//  EditProfileTableViewController.h
//  Why Go Solo
//
//  Created by Izzy on 09/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UniversityViewController.h"
#import "UniversityLocations.h"
#import "OverlayView.h"

@class RRCircularImageView;

@interface EditProfileTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UITableViewCell *studentAccommdationCell;



@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;


@property (strong, nonatomic) IBOutlet UITextField *emailLabel;


@property (weak, nonatomic) IBOutlet RRCircularImageView *profileImage;
//@property (weak, nonatomic) IBOutlet UIView *profileUser;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *studentAccommodationTextField;
@property (weak, nonatomic) IBOutlet UITextField *dateOfBirthTextField;
@end
