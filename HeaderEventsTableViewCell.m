//
//  MyEventsTableViewCell.m
//  UnderstandingAddingMapAnnotations
//
//  Created by Izzy on 05/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "HeaderEventsTableViewCell.h"

@implementation HeaderEventsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)filterButtonPressed:(UIButton *)sender {
    switch (sender.tag) {
        case FILTER:
            NSLog(@"Filter Button Pressed");
            break;
            case NOFILTER:
            NSLog(@"NO FILTER");
            break;
    }
}

@end
