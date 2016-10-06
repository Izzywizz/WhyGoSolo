//
//  DirectionViewController.m
//  Why Go Solo
//
//  Created by Izzy on 06/10/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "DirectionViewController.h"

@interface DirectionViewController ()
@property (nonatomic) MKPlacemark *selectedPin;

@end

@implementation DirectionViewController

#pragma mark - UIView methods
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"Delegate set in interface");
    [self reverseEngineerAddressToCoodinates:self.addressToBeReverse];
}

-(void)viewWillAppear:(BOOL)animated    {
    self.mapView.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated {
    self.mapView.delegate = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - REverse engineer Address to coodinates

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
                         
                         MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(placemark.coordinate, 5000, 5000);

                         [self.mapView setRegion:region animated:YES];
                         [self.mapView addAnnotation:annotation];
                     }
                 }
     ];
}


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

- (void)getDirections {
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:self.selectedPin];
    //[mapItem openInMapsWithLaunchOptions:(@{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving})];
    [mapItem openInMapsWithLaunchOptions:nil];
}
- (IBAction)testButtonPressed:(UIButton *)sender {
    [self getDirections];
}

@end
