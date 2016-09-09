//
//  MyEventsTableViewCell.h
//  UnderstandingAddingMapAnnotations
//
//  Created by Izzy on 05/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderEventsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *MyEventsLabel;
@property (weak, nonatomic) IBOutlet UIButton *filterButton;
@property (weak, nonatomic) IBOutlet UILabel *numberOfEventsLabel;


typedef enum {
    FILTER = 1,
    NOFILTER,
} FilterState;

@end
