//
//  EventCollectionViewCell.h
//  Why Go Solo
//
//  Created by Izzy on 03/10/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Event;
@class EventCellView;

@interface EventCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet EventCellView *eventCellView;
@property Event *event;

-(EventCollectionViewCell*) configureCellWithEventForTableView:(UICollectionView*)collectionView atIndexPath:(NSIndexPath*)indexPath;


@end
