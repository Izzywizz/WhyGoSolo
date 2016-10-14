//
//  AccommodationMapViewController.h
//  Why Go Solo
//
//  Created by Izzy on 16/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MapViewController.h"
#import "ViewSetupHelper.h"
@import MapKit;



@interface AccommodationMapViewController : UIViewController <HandleMapSearch, MKMapViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIView *overlayView;
@property (weak, nonatomic) IBOutlet UIView *internalAccoutCreatedView;

@property (nonatomic, strong) NSString *AccommodationAddress;


@end
