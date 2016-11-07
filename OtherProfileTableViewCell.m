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
#import "User.h"
#import "University.h"
#import "Residence.h"
#import "RRCircularImageView.h"
#import "RRDownloadImage.h"





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
    _nameLabel.text = [Data sharedInstance].selectedUser.userName;
    _profileUniversityLabel.text = [Data sharedInstance].selectedUser.university.universityName;
    
    _ProfileAccommodation.text = [Data sharedInstance].selectedUser.residence.residenceName;
    
    _profileImage.image = [[RRDownloadImage sharedInstance]avatarImageForUserID:[Data sharedInstance].selectedUserID];
    return  self;
    
}


@end
