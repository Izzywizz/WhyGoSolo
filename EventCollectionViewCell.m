//
//  EventCollectionViewCell.m
//  Why Go Solo
//
//  Created by Izzy on 03/10/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//d

#import "EventCollectionViewCell.h"
#import "Event.h"
#import "Data.h"
#import "EventCellView.h"

@implementation EventCollectionViewCell


-(EventCollectionViewCell*) configureCellWithEventForTableView:(UICollectionView*)collectionView atIndexPath:(NSIndexPath*)indexPath  {
    
    self.event =  [Data sharedInstance].selectedEvent;
    [_eventCellView configureEventCollectionViewCell:self];
    
    return self;
}

@end
