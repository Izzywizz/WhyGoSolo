//
//  DirectionViewController.m
//  Why Go Solo
//
//  Created by Izzy on 06/10/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "DirectionViewController.h"
#import "Data.h"
#import "Event.h"
@interface DirectionViewController ()
@property (nonatomic) MKPlacemark *selectedPin;

@end

@implementation DirectionViewController

#pragma mark - UIView methods
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationButtonFontAndSize];
 //   [self reverseEngineerAddressToCoodinates:self.addressToBeReverse];
}

-(void)viewWillAppear:(BOOL)animated    {
    self.mapView.delegate = self;
    
    [self reverseGeoCoodantes:CLLocationCoordinate2DMake([Data sharedInstance].selectedEvent.latitude, [Data sharedInstance].selectedEvent.longitude)];
}

-(void)viewWillDisappear:(BOOL)animated {
    self.mapView.delegate = nil;
    self.mapView = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Coodirnates method

-(void) reverseEngineerAddressToCoodinates: (NSString *) address  {
    NSString *location = address;
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:location
                 completionHandler:^(NSArray* placemarks, NSError* error){
                     if (placemarks.count > 0) {
                         CLPlacemark *topResult = [placemarks firstObject];
                         MKPlacemark *placemark = [[MKPlacemark alloc] initWithPlacemark:topResult];
                         _selectedPin = placemark;
                         
                         MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
                         annotation.coordinate = placemark.coordinate;
                         
                         MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(placemark.coordinate, 500, 500);

                         [self.mapView setRegion:region animated:YES];
                         [self.mapView addAnnotation:annotation];
                     }
                 }
     ];
}

-(void) reverseGeoCoodantes: (CLLocationCoordinate2D) coordinates     {
    CLLocation *currentLocation = [[CLLocation alloc] initWithLatitude:coordinates.latitude longitude:coordinates.longitude];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];

    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) {
            NSLog(@"Geocode failed with error: %@", error);
            return;
        }
        //                NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
        if (error == nil && [placemarks count] > 0) {
            
            CLPlacemark *topResult = [placemarks firstObject];
            MKPlacemark *placemark = [[MKPlacemark alloc] initWithPlacemark:topResult];
            _selectedPin = placemark;
            
            MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
            annotation.coordinate = placemark.coordinate;
            
            MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(placemark.coordinate, 500, 500);
            
            [self.mapView setRegion:region animated:YES];
            [self.mapView addAnnotation:annotation];

   //         _placemark = [placemarks lastObject];
     //       [_resultSearchController.searchBar setText:[_locationSearchTable parseAddress:(MKPlacemark *)_placemark]];
            
        } else {
            NSLog(@"%@", error.debugDescription);
        }
    }];
}


#pragma mark - Map Delegates
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation   {
    
    if ([annotation isKindOfClass:[MKPointAnnotation class]]) {
        MKAnnotationView *pin = [self.mapView dequeueReusableAnnotationViewWithIdentifier:@"myPin"];
        
        if (pin == nil) {
            pin = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myPin"];
            
        } else {
            pin.annotation = annotation;
        }
        
        pin.canShowCallout = YES;
        pin.image = [UIImage imageNamed:@"map-pin-34-58"];
        
        return pin;
    }
    
    return nil;
}

#pragma mark - Helper Functions
- (void)getDirections {
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:self.selectedPin];
    //[mapItem openInMapsWithLaunchOptions:(@{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving})];
    [mapItem openInMapsWithLaunchOptions:nil];
}

-(void) setNavigationButtonFontAndSize  {
    
    NSDictionary *attributes = [ViewSetupHelper setNavigationButtonFontAndSize];
    [self.backButton setTitleTextAttributes:attributes forState:UIControlStateNormal];
}

#pragma mark - Helper functions
- (IBAction)directionsButtonPressed:(UIBarButtonItem *)sender {
    [self getDirections];
}

- (IBAction)backButtonPressed:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
