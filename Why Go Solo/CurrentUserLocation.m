//
//  CurrentUserLocation.m
//  UnderstandingAddingMapAnnotations
//
//  Created by Izzy on 31/08/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "CurrentUserLocation.h"

@interface CurrentUserLocation()

@property MKMapView *mapView;
@property (nonatomic) CLLocationManager *locationManager;

@end

@implementation CurrentUserLocation

/** Test method to see if protocols that I have setup are working correctly */
-(void) checkToSeeDelegateWorks {
    [_delegate sayHello];
}

/** A method that requests the user permission for starting location servies, this is paired with the info.plist key: NSLocationWhenInUseUsageDescription, String: "We need to use your location etc" */
- (CLLocationManager *)initializeLocationServices
{
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    [_locationManager requestLocation];
    [_locationManager startUpdatingLocation];
    [self.mapView setShowsUserLocation:YES];
    
    if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [_locationManager requestWhenInUseAuthorization];
    }
    
    return _locationManager;
}

#pragma mark - Map Delegate Methods

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"error: %@", error);
}


- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *location = [locations firstObject];
    MKCoordinateSpan span = MKCoordinateSpanMake(0.05, 0.05);
    MKCoordinateRegion region = MKCoordinateRegionMake(location.coordinate, span);
    [_mapView setRegion:region animated:true];
    
    [_delegate zoomToUserLocation:location];
    
    [_locationManager stopUpdatingLocation];
    _locationManager = nil;
    
    [_delegate reverseGeoCoodantes:location.coordinate];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status  {
//    [_userLocationDelegate requestAlwaysAuthorization];
    switch (status) {
        case kCLAuthorizationStatusNotDetermined: [_locationManager requestAlwaysAuthorization];
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse: [_locationManager startUpdatingLocation];
            break;
        case kCLAuthorizationStatusAuthorizedAlways: [_locationManager startUpdatingLocation];
            break;
        case kCLAuthorizationStatusRestricted: // restricted by e.g. parental controls. User can't enable Location Services
            break;
        case kCLAuthorizationStatusDenied: [_delegate setupAlertSettingsBox:status];
            break;
    }
}


@end
