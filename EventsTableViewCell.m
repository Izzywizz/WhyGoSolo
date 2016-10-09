//
//  EventTableViewCell.m
//  UnderstandingAddingMapAnnotations
//
//  Created by Izzy on 02/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "EventsTableViewCell.h"


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
            _joinButton.alpha = 0;
            _joinedButton.alpha = 1;
            break;
        case EDIT: NSLog(@"Edit Button Pressed");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Edit Found" object:self];
            break;
        case PROFILE: NSLog(@"Profile Button Pressed");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Profile Found" object:self];
            break;
        case JOINED: NSLog(@"Joined Button");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Joined" object:self];
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
    [[NSNotificationCenter defaultCenter] postNotificationName:@"People Event" object:self];
}
- (IBAction)commentsButtonPressed:(UIButton *)sender {
    NSLog(@"Comments button pressed");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Comments" object:self];
}

@end
