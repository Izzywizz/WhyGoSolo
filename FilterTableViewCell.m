//
//  FilterTableViewCell.m
//  Why Go Solo
//
//  Created by Izzy on 20/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "FilterTableViewCell.h"

@implementation FilterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)hallsSwitch:(UISwitch *)sender {
    NSLog(@"Halls Activated: %d", sender.on);
}

@end
