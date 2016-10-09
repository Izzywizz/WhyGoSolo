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
    if (_deleteOrReportButton.tag == 0) {
        NSLog(@"Report Button");
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)deleteOrReportCommentPressed:(UIButton *)sender {
    NSLog(@"Delete or Report a comment");
}

@end
