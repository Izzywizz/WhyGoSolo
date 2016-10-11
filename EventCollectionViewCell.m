//
//  EventCollectionViewCell.m
//  Why Go Solo
//
//  Created by Izzy on 03/10/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//d

#import "EventCollectionViewCell.h"
#import "Event.h"
#import "User.h"
#import "Data.h"

@implementation EventCollectionViewCell

-(void)awakeFromNib {
    self.innerView.layer.cornerRadius = 5;
}
- (IBAction)eventButtonPressed:(UIButton *)sender {
    switch (sender.tag) {
        case JOIN: NSLog(@"Join Button Pressed");
            self.joinButton.alpha = 0; //hide join button but show Joined button
            self.joinedButton.alpha = 1;
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hasJoinedEvent"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Join" object:self.event];
            break;
        case EDIT: NSLog(@"Edit Button Pressed");
            break;
        case PROFILE: NSLog(@"Profile Button Pressed");
            break;
        case JOINED: NSLog(@"Joined...");
            //Reverse logic in the join button to create the illusion
            self.joinButton.alpha = 1;
            self.joinedButton.alpha = 0;
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"hasJoinedEvent"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Joined" object:self.event];
            break;
        default:
            break;
    }
    
}

-(EventCollectionViewCell*) configureCellWithEventForTableView:(UICollectionView*)collectionView atIndexPath:(NSIndexPath*)indexPath  {
    
    if (collectionView.numberOfSections == 2)
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

    
    self.nameLabel.text = self.event.userName;
    self.eventAddressLabel.text = self.event.address;
    self.eventDescriptionText.text = self.event.eventDescription;
    self.eventEmoticonLabel.text = self.event.emoji;
    
    return self;
}



@end
