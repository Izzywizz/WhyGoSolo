//
//  FilterViewController.h
//  Why Go Solo
//
//  Created by Izzy on 19/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FontSetup.h"
#import "HallsOfResidence.h"


@interface FilterViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *applyButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
