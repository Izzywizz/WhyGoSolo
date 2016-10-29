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

@interface EditProfileTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UITableViewCell *studentAccommdationCell;
@property (weak, nonatomic) IBOutlet UIImageView *profileView;
@property (weak, nonatomic) IBOutlet UITextField *dateOfBirthTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@end
