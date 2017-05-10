//
//  PeopleEventTableViewCell.h
//  Why Go Solo
//
//  Created by Izzy on 12/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RRCircularImageView.h"

@class User;
@class Event;
@interface PeopleEventTableViewCell : UITableViewCell

-(PeopleEventTableViewCell*)configureCell;
@property (strong, nonatomic) IBOutlet UIView *view;

@property (weak, nonatomic) IBOutlet RRCircularImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *emojiLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property User *user;
@property Event *event;
@end
