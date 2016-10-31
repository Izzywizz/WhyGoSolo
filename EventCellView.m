//
//  EventCellView.m
//  Why Go Solo
//
//  Created by Andy Chamberlain on 30/10/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "EventCellView.h"
#import "Event.h"
#import "RRCircularImageView.h"
#import "User.h"
#import "Data.h"
#import "WebService.h"

#import "AFNetworking.h"

#import "UIImageView+AFNetworking.h"
#import "AFHTTPRequestOperation.h"
#import "UIImageView+AFNetworking.h"

#import "RRDownloadImage.h"
#import "EventsTableViewCell.h"
#import "EventCollectionViewCell.h"


#import "Event.h"
#import "Data.h"
#import "EventCellView.h"
@implementation EventCellView


-(void)configureCellWithEvent:(Event*)event
{
    self.layer.cornerRadius = 7;
    _event = event;
    
    NSLog(@"Event Description:eeeee %@", _event.eventDescription);
    
    self.nameLabel.text = _event.userName;
    self.eventAddressLabel.text = _event.address;
    self.eventDescriptionText.text = _event.eventDescription;
    self.eventEmoticonLabel.text = _event.emoji;

    
    self.nameLabel.text = _event.userName;
    self.eventAddressLabel.text = _event.address;
    self.eventDescriptionText.text = _event.eventDescription;
    self.eventMessageCount.text = _event.totalComments;
    self.eventInviteeCount.text = _event.totalAttending;
    self.eventEmoticonLabel.text = _event.emoji;
    
    self.avatarImageView.image = [[RRDownloadImage sharedInstance]avatarImageForUserID:[NSString stringWithFormat:@"%i",_event.userID]];
    
    
    NSLog(@"EVENT JPIOED STATUS = %i / %i", _event.userID, [Data sharedInstance].loggedInUser.userID);
    if (_event.joined)
    {
        self.joined = YES;
        //    self.event =  [[Data sharedInstance].myEventsArray objectAtIndex:indexPath.row];
    }
    else
    {
        self.joined = NO;
        //  self.event = [[Data sharedInstance].eventsArray objectAtIndex:indexPath.row];
    }
    
    if (self.joined)
    {
        if (_event.userID != (int)[[Data sharedInstance].userID integerValue])
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
    


}

-(void)configureEventsTableViewCell:(EventsTableViewCell*)cell
{
    [self configureCellWithEvent:cell.event];
}

-(void)configureEventCollectionViewCell:(EventCollectionViewCell*)cell
{
    [self configureCellWithEvent:cell.event];
}


- (IBAction)joinButtonPressed:(UIButton *)sender
{
    [Data sharedInstance].selectedEvent = _event;
    [Data sharedInstance].selectedEventID = [NSString stringWithFormat:@"%i",_event.eventID];
    
    
    switch (sender.tag) {
        case JOIN: NSLog(@"Join Button Pressed");
            [[WebService sharedInstance]eventsApiRequest:EVENT_API_JOIN];
            
            _joinButton.alpha = 0;
            _joinedButton.alpha = 1;
            break;
        
        case JOINED: NSLog(@"Joined Button");
            [[WebService sharedInstance]eventsApiRequest:EVENT_API_JOIN];
            
            _joinButton.alpha = !_joinButton.alpha;
            
            _joinButton.alpha = 1;
            _joinedButton.alpha = 0;
            break;
    
            
        case EDIT: NSLog(@"Edit Button Pressed");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Edit Found" object:self];
            break;
        
        case PROFILE: NSLog(@"Profile Button Pressed");
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Profile Found" object:self.event];
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
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Comments" object:self.event];
}


@end
