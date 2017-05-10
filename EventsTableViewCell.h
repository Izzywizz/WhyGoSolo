//
//  EventTableViewCell.h
//  UnderstandingAddingMapAnnotations
//
//  Created by Izzy on 02/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Event;
@class EventCellView;

@interface EventsTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet EventCellView *eventCellView;
@property Event *event;

-(EventsTableViewCell*)configureCellWithEventForTableView:(UITableView*)tableView atIndexPath:(NSIndexPath*)indexPath;
-(EventsTableViewCell*)configureCellWithEvent:(Event*)event;

/*
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventEmoticonLabel;
@property (weak, nonatomic) IBOutlet UITextView *eventDescriptionText;
@property (weak, nonatomic) IBOutlet UILabel *eventMessageCount;
@property (weak, nonatomic) IBOutlet UILabel *eventInviteeCount;
@property (weak, nonatomic) IBOutlet UIButton *joinButton;
@property (weak, nonatomic) IBOutlet UIView *viewLayer;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *messageImage;
@property (weak, nonatomic) IBOutlet UIButton *editJoinButton;
@property (weak, nonatomic) IBOutlet UIButton *joinedButton;

@property (strong, nonatomic) IBOutlet UIImageView *avatarImageView;
@property BOOL joined;

typedef enum {
    EDIT = 1,
    JOIN,
    PROFILE,
    JOINED
} EventState;
*/

//-(void)configureCellWithEvent;


@end