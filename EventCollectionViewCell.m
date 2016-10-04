//
//  EventCollectionViewCell.m
//  Why Go Solo
//
//  Created by Izzy on 03/10/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "EventCollectionViewCell.h"

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
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Join" object:self];
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
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Joined" object:self];
            break;
        default:
            break;
    }
    
}

@end
