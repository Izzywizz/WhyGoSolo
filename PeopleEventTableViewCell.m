//
//  PeopleEventTableViewCell.m
//  Why Go Solo
//
//  Created by Izzy on 12/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "PeopleEventTableViewCell.h"
#import "Data.h"
#import "User.h"
#import "Event.h"

#import "RRDownloadImage.h"

@implementation PeopleEventTableViewCell

-(PeopleEventTableViewCell*)configureCell
{
    self.view.layer.cornerRadius = 7;

    self.nameLabel.text = _user.userName;
    self.addressLabel.text = _event.address;
    self.emojiLabel.text = _event.emoji;
    self.profileImage.image = [[RRDownloadImage sharedInstance]avatarImageForUserID:_user.userID];
    
    return self;
}
- (IBAction)cellPressed:(id)sender {
    
    [Data sharedInstance].selectedEvent = _event;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"People Event" object:nil];

}
- (IBAction)profileButtonPressed:(id)sender
{
    NSLog(@"PRESSED");
    [Data sharedInstance].selectedUserID = _user.userID;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Profile Found" object:nil];

       
}

@end
