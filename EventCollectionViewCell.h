//
//  EventCollectionViewCell.h
//  Why Go Solo
//
//  Created by Izzy on 03/10/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Event;


@interface EventCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *innerView;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIButton *joinButton;
@property (weak, nonatomic) IBOutlet UIButton *joinedButton;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventAddressLabel;
@property (weak, nonatomic) IBOutlet UITextView *eventDescriptionText;
@property (weak, nonatomic) IBOutlet UILabel *eventEmoticonLabel;

@property BOOL joined;
@property Event *event;


typedef enum {
    EDIT = 1,
    JOIN,
    PROFILE,
    JOINED
} EventState;

-(EventCollectionViewCell*) configureCellWithEventForTableView:(UICollectionView*)collectionView atIndexPath:(NSIndexPath*)indexPath;


@end
