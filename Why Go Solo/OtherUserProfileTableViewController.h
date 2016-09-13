//
//  OtherUserProfileTableViewController.h
//  Why Go Solo
//
//  Created by Izzy on 09/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OtherUserProfileTableViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *overlayView;
@property (weak, nonatomic) IBOutlet UIView *internalView;
@property (weak, nonatomic) IBOutlet UILabel *reportName;
@property (weak, nonatomic) IBOutlet UIView *userReportedView;
@property (weak, nonatomic) IBOutlet UIButton *okReportedUserButton;
@property (weak, nonatomic) IBOutlet UILabel *userHasBeenReportedLabel;

@end
