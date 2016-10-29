//
//  Why Go Solo
//
//  Created by Izzy on 23/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "FriendCollectionViewCell.h"

@implementation FriendCollectionViewCell


#pragma mark - Helper Functions
/** Ensures that the selection seperators are setup before the main views are shown*/
-(void)layoutSubviews
{
    [super layoutSubviews];
    [self makeItCircular];
}

-(void) makeItCircular  {
    
    self.profileImageView.layer.masksToBounds = true;
    self.profileImageView.layer.cornerRadius = self.profileImageView.bounds.size.height/2; //create circular profile view

}

@end
