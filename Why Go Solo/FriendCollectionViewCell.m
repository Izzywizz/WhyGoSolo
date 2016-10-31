//
//  Why Go Solo
//
//  Created by Izzy on 23/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "FriendCollectionViewCell.h"
#import "RRDownloadImage.h"
#import "Data.h"
#import "RRCircularImageView.h"
#import "User.h"
@implementation FriendCollectionViewCell


#pragma mark - Helper Functions
/** Ensures that the selection seperators are setup before the main views are shown*/

-(FriendCollectionViewCell*) configureCellWithUser:(User*)user
{
    NSLog(@"FRIENCE CELL USER = %i", user.userID);
    self.profileName.text = user.firstName;

    self.profileImageView.image = [[RRDownloadImage sharedInstance]avatarImageForUserID:[NSString stringWithFormat:@"%i",user.userID]];

    return self;
}

@end
