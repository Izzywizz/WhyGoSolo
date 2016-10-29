//
//  AlternateProfileTableViewController.h
//  Why Go Solo
//
//  Created by Izzy on 17/10/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlternateProfileTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addFriendButton;

@property (nonatomic, weak) NSString *reportedUserName;

@end
