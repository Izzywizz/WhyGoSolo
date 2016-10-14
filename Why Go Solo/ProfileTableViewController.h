//
//  PeopleTableViewController.h
//  Why Go Solo
//
//  Created by Izzy on 09/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewSetupHelper.h"

@interface ProfileTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UIView *profileUser;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *studentAccommodationTextField;
@property (weak, nonatomic) IBOutlet UITextField *dateOfBirthTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;

@end
