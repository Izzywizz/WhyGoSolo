//
//  ViewController.h
//  UnderstandingAddingMapAnnotations
//
//  Created by Izzy on 24/08/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@protocol HandleMapSearch <NSObject>
- (void)dropPinZoomIn:(MKPlacemark *)placemark;

@end

@protocol HandleCurrentUserLocation <NSObject>

-(void) sayHello;
-(CLLocationManager *) initializeLocationServices;
-(void) zoomToUserLocation: (CLLocation *) userLocation;
-(void) reverseGeoCoodantes: (CLLocationCoordinate2D) coordinates;
-(void) setupAlertSettingsBox: (CLAuthorizationStatus) status;

@end

@interface MapViewController : UIViewController <HandleMapSearch, HandleCurrentUserLocation, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneOrNextButton;

-(void) setupLongPressGesture;
-(void) startCurrentUserLocation: (BOOL) isUserLocation;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextButton;

@end

