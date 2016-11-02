//
//  FooterEventsTableViewCell.m
//  UnderstandingAddingMapAnnotations
//
//  Created by Izzy on 05/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "FooterEventsTableViewCell.h"
#import "WebService.h"

@implementation FooterEventsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _blockButton.layer.cornerRadius = 3;
    _unblockButton.layer.cornerRadius = 3;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (IBAction)reportButtonPressed:(UIButton *)sender {
    NSLog(@"Report");
    [[WebService sharedInstance]eventsApiRequest:USER_API_REPORT];
   // [[NSNotificationCenter defaultCenter] postNotificationName:@"ReportUser" object:self];

}
- (IBAction)blockButtonPressed:(UIButton *)sender {
    NSLog(@"Block");
    [[WebService sharedInstance]eventsApiRequest:USER_API_BLOCK_STATUS_UPDATE];

  //  [[NSNotificationCenter defaultCenter] postNotificationName:@"BlockUser" object:self];
}
- (IBAction)unblockButtonPressed:(UIButton *)sender {
    NSLog(@"UnBlock");
    [[WebService sharedInstance]eventsApiRequest:USER_API_BLOCK_STATUS_UPDATE];

  //  [[NSNotificationCenter defaultCenter] postNotificationName:@"UnblockUser" object:self];
}

@end
