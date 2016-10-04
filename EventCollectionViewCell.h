//
//  EventCollectionViewCell.h
//  Why Go Solo
//
//  Created by Izzy on 03/10/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *innerView;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIButton *joinButton;
@property (weak, nonatomic) IBOutlet UIButton *joinedButton;

typedef enum {
    EDIT = 1,
    JOIN,
    PROFILE,
    JOINED
} EventState;


@end
