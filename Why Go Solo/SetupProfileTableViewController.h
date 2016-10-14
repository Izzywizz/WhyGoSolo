//
//  SetupProfileTableViewController.h
//  Why Go Solo
//
//  Created by Izzy on 15/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewSetupHelper.h"

@interface SetupProfileTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIView *roundImageUploadView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextButton;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;


@property (weak, nonatomic) IBOutlet UIView *firstNameContentView;
@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;



@property (weak, nonatomic) IBOutlet UIView *lastNameContentView;
@property (weak, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;

@property (weak, nonatomic) IBOutlet UIView *dateOfBirthContentView;
@property (weak, nonatomic) IBOutlet UILabel *dateOfBirthLabel;
@property (weak, nonatomic) IBOutlet UITextField *dateOfBirthField;

@end
