//
//  OtherProfileTableViewCell.h
//  Why Go Solo
//
//  Created by Izzy on 09/10/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Event;

@interface OtherProfileTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *profileUniversityLabel;
@property (weak, nonatomic) IBOutlet UILabel *ProfileAccommodation;

@property Event *event;

-(OtherProfileTableViewCell * )configureCollectionForOtherProfile:(UITableView*)tableView atIndexPath:(NSIndexPath*)indexPath;
@end
