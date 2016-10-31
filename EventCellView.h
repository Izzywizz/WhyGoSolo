//
//  EventCellView.h
//  Why Go Solo
//
//  Created by Andy Chamberlain on 30/10/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Event;
@class RRCircularImageView;

@class EventsTableViewCell;
@class EventCollectionViewCell;
@interface EventCellView : UIView


//@property (weak, nonatomic) IBOutlet UIView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventEmoticonLabel;
@property (weak, nonatomic) IBOutlet UITextView *eventDescriptionText;
@property (weak, nonatomic) IBOutlet UILabel *eventMessageCount;
@property (weak, nonatomic) IBOutlet UILabel *eventInviteeCount;
//@property (weak, nonatomic) IBOutlet UIView *viewLayer;
//@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
//@property (weak, nonatomic) IBOutlet UIImageView *messageImage;


@property (weak, nonatomic) IBOutlet UIButton *profileButton;

@property (weak, nonatomic) IBOutlet UIButton *joinButton;
@property (weak, nonatomic) IBOutlet UIButton *editJoinButton;
@property (weak, nonatomic) IBOutlet UIButton *joinedButton;
@property (weak, nonatomic) IBOutlet UIButton *attendeesdButton;
@property (weak, nonatomic) IBOutlet UIButton *commentsdButton;


//-(void)configureCellWithEvent:(Event*)event;

-(void)configureEventsTableViewCell:(EventsTableViewCell*)cell;
-(void)configureEventCollectionViewCell:(EventCollectionViewCell*)cell;


@property (strong, nonatomic) IBOutlet RRCircularImageView *avatarImageView;
@property BOOL joined;
@property Event *event;

typedef enum {
    EDIT = 1,
    JOIN,
    PROFILE,
    JOINED
} EventState;
/**/


@property EventsTableViewCell* eventsTableViewCell;
@end
