//
//  PeopleNotAttendingTableViewCell.m
//  Why Go Solo
//
//  Created by Izzy on 15/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "PeopleNotAttendingTableViewCell.h"
#import "EventsTableViewCell.h"


@implementation PeopleNotAttendingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)profileButtonPressed:(UIButton *)sender {
    switch (sender.tag) {
        case PROFILE: NSLog(@"Profile Button Pressed");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Profile Found" object:self];
            break;
        default:
            break;
    }
}

@end
