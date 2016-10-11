//
//  EventTableViewCell.m
//  UnderstandingAddingMapAnnotations
//
//  Created by Izzy on 02/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "EventsTableViewCell.h"
#import "Event.h"
#import "User.h"
#import "Data.h"
@implementation EventsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //    [self bringSubviewToFront:_joinButton];
    _viewLayer.layer.cornerRadius = 5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (IBAction)buttonPressed:(UIButton *)sender {
    switch (sender.tag) {
        case JOIN: NSLog(@"Join Button Pressed");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Joined" object:self.event];

            _joinButton.alpha = 0;
            _joinedButton.alpha = 1;
            break;
        case EDIT: NSLog(@"Edit Button Pressed");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Edit Found" object:self];
            break;
        case PROFILE: NSLog(@"Profile Button Pressed");
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Profile Found" object:self.event];
            break;
        case JOINED: NSLog(@"Joined Button");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Joined" object:self.event];
            NSLog(@"Alpha values are just being set, no logic here!");
            _joinButton.alpha = 1;
            _joinedButton.alpha = 0;
            break;
        default:
            break;
    }
}
- (IBAction)peopleEventButtonPressed:(UIButton *)sender {
    NSLog(@"People Event Button Pressed");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"People Event" object:self.event];
}
- (IBAction)commentsButtonPressed:(UIButton *)sender {
    NSLog(@"Comments button pressed");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Comments" object:self];
}




-(EventsTableViewCell*)configureCellWithEventForTableView:(UITableView*)tableView atIndexPath:(NSIndexPath*)indexPath
{

    if (tableView.numberOfSections == 2 && indexPath.section ==  0)
    {
        self.joined = YES;
        self.event =  [[Data sharedInstance].myEventsArray objectAtIndex:indexPath.row];
    }
    else
    {
        self.joined = NO;
        self.event = [[Data sharedInstance].eventsArray objectAtIndex:indexPath.row];
    }

    
    if (self.joined)
    {
        if (self.event.userID != (int)[[Data sharedInstance].userID integerValue])
        {
            [self viewWithTag:EDIT].alpha = 0;
            [self viewWithTag:JOIN].alpha = 0;
            [self viewWithTag:JOINED].alpha = 1;
        }
        else
        {
            [self viewWithTag:EDIT].alpha = 1;
            [self viewWithTag:JOIN].alpha = 0;
            [self viewWithTag:JOINED].alpha = 0;
        }
    }
    else
    {
        [self viewWithTag:EDIT].alpha = 0;
        [self viewWithTag:JOIN].alpha = 1;
        [self viewWithTag:JOINED].alpha = 0;
    }
    
    self.timeLabel.hidden = YES;
    self.nameLabel.text = self.event.userName;
    self.eventAddressLabel.text = self.event.address;
    self.eventDescriptionText.text = self.event.eventDescription;
    self.eventMessageCount.text = self.event.totalComments;
    self.eventInviteeCount.text = self.event.totalAttending;
    self.eventEmoticonLabel.text = self.event.emoji;
    
    return  self;

}
@end
