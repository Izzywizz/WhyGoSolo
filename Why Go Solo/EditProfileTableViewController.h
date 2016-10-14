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

@interface EditProfileTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UITableViewCell *studentAccommdationCell;
@property (weak, nonatomic) IBOutlet UIImageView *profileView;
@property (weak, nonatomic) IBOutlet UITextField *dateOfBirthTextField;

@end
