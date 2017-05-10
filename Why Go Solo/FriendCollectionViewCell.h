//
//  Why Go Solo
//
//  Created by Izzy on 23/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class User;
@class RRCircularImageView;
@interface FriendCollectionViewCell : UICollectionViewCell


@property (weak, nonatomic) IBOutlet RRCircularImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *profileName;

@property User *user;


-(FriendCollectionViewCell*) configureCellWithUser:(User*)user;


@end
