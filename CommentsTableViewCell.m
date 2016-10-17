//
//  CommentsTableViewCell.m
//  Why Go Solo
//
//  Created by Izzy on 07/10/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "CommentsTableViewCell.h"

@implementation CommentsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    /*Setup logic to fake whether its a user own comment or something they can delete*/
    if (_reportButton.tag == 0) {
        NSLog(@"Report Button");
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)reportButtonPressed:(UIButton *)sender {
    NSLog(@"Reported");
}

- (IBAction)deleteButtonPressed:(UIButton *)sender {
    NSLog(@"DELETED");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"deleteUserComment" object:self];
}

@end
