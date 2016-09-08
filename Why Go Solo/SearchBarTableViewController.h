//
//  SearchBarTableViewController.h
//  UnderstandingAddingMapAnnotations
//
//  Created by Izzy on 26/08/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MapKit;
#import "MapViewController.h"


@interface SearchBarTableViewController : UITableViewController <UISearchResultsUpdating>

@property (nonatomic, strong) NSArray *places;
@property MKMapView *mapView;
@property UISearchController *sc;

@property id <HandleMapSearch> delegate;

- (NSString *)parseAddress:(MKPlacemark *)selectedItem;

@end
