//
//  OtherProfileTableViewCell.m
//  Why Go Solo
//
//  Created by Izzy on 09/10/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "OtherProfileTableViewCell.h"
#import "Data.h"
#import "Event.h"


@implementation OtherProfileTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(OtherProfileTableViewCell * )configureCollectionForOtherProfile:(UITableView*)tableView atIndexPath:(NSIndexPath*)indexPath
{
    self.event = [Data sharedInstance].selectedEvent;
    self.nameLabel.text = self.event.userName;
    return  self;
    
}


@end
