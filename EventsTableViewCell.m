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
            break;
        case EDIT: NSLog(@"Edit Button Pressed");
            break;
        case PROFILE: NSLog(@"Profile Button Pressed");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Profile Found" object:self];
            break;
        default:
            break;
    }
}

@end
