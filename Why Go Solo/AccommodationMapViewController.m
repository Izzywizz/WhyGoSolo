//
//  AccommodationMapViewController.m
//  Why Go Solo
//
//  Created by Izzy on 16/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "AccommodationMapViewController.h"
#import "SearchBarTableViewController.h"
#import "Data.h"
#import "Residence.h"
#import "WebService.h"
#import "RRRegistration.h"
#import "User.h"
#import "University.h"
#import "Residence.h"

#define METERS_PER_MILE 1609.344


@interface AccommodationMapViewController ()<DataDelegate>

@property (nonatomic, strong) SearchBarTableViewController *locationSearchTable;
@property (nonatomic, strong) UISearchController *resultSearchController;

@property (nonatomic) Residence *residence;
@property (nonatomic, strong) WebService *Webservice;

@property (nonatomic) CLGeocoder *geocoder;
@property (nonatomic) CLPlacemark *placemark;

@property BOOL isDraggable;

@property BOOL residencePinsAdded;
@end

@implementation AccommodationMapViewController


#pragma mark - UI View Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Accommodation Map View");
    [self setupGeocoderPlacemark];
    
    _residence = [[Residence alloc] init];
    
    NSLog(@"BOOL isEditProfile: %d",_isEditProfile);
    
    [self setNavigationButtonFontAndSize];
    [self setup];
    _internalAccoutCreatedView.layer.cornerRadius = 5;
    [self liverpoolLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated   {
    [self.mapView setDelegate:self];
    

    if (![Data sharedInstance].selectedUniversity)
    {
        [Data sharedInstance].selectedUniversity = [University new];
    }
  

    //    self.locationSearchTable.delegate = self;
    [self accountCreationOverlayAlpha:0 animationDuration:0.0f]; //Hide the overlay
    if (_isEditProfile)
    {
        [_doneButton setEnabled:NO];
        [_doneButton setTintColor:[UIColor clearColor]];
        [Data sharedInstance].selectedUniversity.universityID = [Data sharedInstance].updatedUser.universityID;
        
        
        NSLog(@"USER UNI ID xxx ddd= %@",  [Data sharedInstance].selectedUniversity.universityID);
    }
    [[WebService sharedInstance] residences];
    [Data sharedInstance].delegate = self; // Set Data delegate
 /*   if (!_isEditProfile) {
        [[WebService sharedInstance] residences];
        [Data sharedInstance].delegate = self; // Set Data delegate
    } else  {
        
        NSLog(@"Web Service Down");
    }*/
    
}

-(void) viewWillDisappear:(BOOL)animated    {
    self.mapView.delegate = nil;
    //    self.locationSearchTable.delegate = nil;
    self.definesPresentationContext = NO;
    [Data sharedInstance].delegate = nil; // release Data delegate
}


#pragma mark - API Delegate Methods

-(void)handleUpdates
{
    for (Residence *element in [Data sharedInstance].residencesArray) {
        NSLog(@"Name: %@", element.residenceName);
        NSLog(@"Longitude: %f", element.longitude);
        NSLog(@"LAtitude: %f", element.latitude);
        NSLog(@"Postcode:%@", element.address);
    }
    
    [self createPinLocations];
    
}

-(void)residencesDownloadedSuccessfully {
    NSLog(@"Sucessfully downloaded residences");
    [self performSelectorOnMainThread:@selector(handleUpdates) withObject:nil waitUntilDone:YES];
    // Need to set to main thread as this is currently running on a background thread
}

-(void)authenticationSuccessful
{
    NSLog(@"AUTH SUCCESS!!!");
   // [self accountCreationOverlayAlpha:1 animationDuration:0.2f]; //Show overlay

    [self performSelectorOnMainThread:@selector(showSuccessOverlay) withObject:nil waitUntilDone:YES];
 //   [self performSegueWithIdentifier:@"GoToEventTable" sender:self];

}

-(void)showSuccessOverlay
{
    [self accountCreationOverlayAlpha:1 animationDuration:0.2f]; //Show overlay
    
   // [self performSegueWithIdentifier:@"GoToEventTable" sender:self];

}

#pragma mark - Pin Methods

-(NSMutableArray *) unpackPinData   {
    
  //  if (!_residencePinsAdded) {
        NSMutableArray *arrayOfPins = [[NSMutableArray alloc] init];
        
        for (Residence *element in [Data sharedInstance].residencesArray) {
            MKPointAnnotation *pin = [[MKPointAnnotation alloc] init];
            double latitude = element.latitude;
            double longitude = element.longitude;
            
            //create the pin coordinates
            pin.coordinate = CLLocationCoordinate2DMake(latitude, longitude);
            pin.title = element.residenceName;
            

            
            [arrayOfPins addObject:pin];
        }

        _residencePinsAdded = YES;
        return arrayOfPins;
   // }
    
    return nil;
}

//add the pins to the mapView
-(void) createPinLocations  {
    _isDraggable = NO;

    [_mapView addAnnotations:[self unpackPinData]];
    
}

#pragma mark - Helper Functions

-(void) setupGeocoderPlacemark  {
    _geocoder = [[CLGeocoder alloc] init];
}

-(void)accountCreationOverlayAlpha:(int)a animationDuration:(float)duration
{
    [UIView animateWithDuration:duration delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        for (id x in _overlayView.subviews)
        {
            if ([x class] == [UIView class])
            {
                [(UIView*)x setAlpha:a];
            }
        }
        _overlayView.alpha = a;
    } completion:nil];
}

-(void) setNavigationButtonFontAndSize  {
    
    NSDictionary *attributes = [ViewSetupHelper setNavigationButtonFontAndSize];
    
    [_doneButton setTitleTextAttributes:attributes forState:UIControlStateNormal];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text = @"";
}

-(void) setup  {
    NSLog(@"SerachBar Loaded");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    _locationSearchTable = [storyboard instantiateViewControllerWithIdentifier:@"SearchBarTableViewController"];
    _resultSearchController = [[UISearchController alloc] initWithSearchResultsController:_locationSearchTable];
    _resultSearchController.searchResultsUpdater = _locationSearchTable;
    
    UISearchBar *searchBar = _resultSearchController.searchBar;
    [searchBar sizeToFit];
    searchBar.placeholder = @"Accomodation";
    self.navigationItem.titleView = searchBar;
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    _resultSearchController.hidesNavigationBarDuringPresentation = NO;
    _resultSearchController.dimsBackgroundDuringPresentation = YES;
    
    self.definesPresentationContext = YES;
    
    _locationSearchTable.mapView = _mapView;
    _locationSearchTable.delegate = self;
    
}


-(void) liverpoolLocation {
    // set initial location in Liverpool
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude =  53.4046711;
    zoomLocation.longitude= -2.9789941;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 10 * METERS_PER_MILE, 10 * METERS_PER_MILE);
    [_mapView setRegion:viewRegion animated:YES];
}

#pragma mark - Map Delegate Methods
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation   {
    
    if (annotation != mapView.userLocation) {
        MKAnnotationView *pin = (MKAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:@"myPin"];
        
        if (pin == nil) {
            pin = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myPin"];
            
        } else {
            pin.annotation = annotation;
        }
        pin.canShowCallout = YES;
        pin.draggable = _isDraggable;// YES;
        pin.image = [UIImage imageNamed:@"map-pin-34-58.png"];
        // Add an image to the left callout.
        
        pin.rightCalloutAccessoryView = [UIButton buttonWithType: UIButtonTypeContactAdd];
        
        return pin;
        
    }
    
    _isDraggable = NO;
    
    return nil;
}


/** This delegate method ensures that when the user taps on the flag or current location that the address in scope updated*/
-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    id <MKAnnotation> annotation = [view annotation];
    
    
    NSString *location = [annotation title];
    NSLog(@"Clicked Flag: %@", location);
    if ([annotation isKindOfClass:[MKPointAnnotation class]])
    {

        
        
        if([[[Data sharedInstance].residenceDict allKeys]containsObject:location])
        {
            [RRRegistration sharedInstance].residenceID = [[Data sharedInstance].residenceDict valueForKey:location];
            [RRRegistration sharedInstance].longitude = annotation.coordinate.longitude;
            [RRRegistration sharedInstance].latitude = annotation.coordinate.latitude;
            [_resultSearchController.searchBar setText:location];
            [Data sharedInstance].loggedInUser.residence.residenceName = location;

        }
        
        else
        {
            [self reverseGeoCoodantes:annotation.coordinate];
         //   [Data sharedInstance].loggedInUser.residence = [Residence new];
            [Data sharedInstance].loggedInUser.residence.residenceName = location;


        }
        
     //   Residence *r = [Data sharedInstance].residencesArray objectAtIndex:[]
        
       // [RRRegistration sharedInstance].residenceID =
    }
    
    if (_isEditProfile)
    {
        [self.navigationController popViewControllerAnimated:YES];

    }

}

#pragma mark - Internal MAP Delegate Method

- (void)dropPinZoomIn:(MKPlacemark *)placemark
{
    // clear existing pins
    [_mapView removeAnnotations:(_mapView.annotations)];
    MKPointAnnotation *annotation = [MKPointAnnotation new];
    annotation.coordinate = placemark.coordinate;
    annotation.title = placemark.name;
    
    annotation.subtitle = [NSString stringWithFormat:@"%@ %@",
                           (placemark.locality == nil ? @"" : placemark.locality),
                           (placemark.administrativeArea == nil ? @"" : placemark.administrativeArea)
                           ];
    
    [_mapView addAnnotation:annotation];
    MKCoordinateSpan span = MKCoordinateSpanMake(0.005, 0.005);
    MKCoordinateRegion region = MKCoordinateRegionMake(placemark.coordinate, span);
    [_mapView setRegion:region animated:true];
    
    if (_residencePinsAdded)
    {
        [RRRegistration sharedInstance].longitude = annotation.coordinate.longitude;
        [RRRegistration sharedInstance].latitude = annotation.coordinate.latitude;
        [_resultSearchController.searchBar setText:annotation.title ];
    }
            [self createPinLocations]; //Called again to create the custom pins, remember that it creates the pins based on the university selected
    

    
    
}

/** A method that obtains the address based on the coordiantes passed in to it */
-(void) reverseGeoCoodantes: (CLLocationCoordinate2D) coordinates     {
    CLLocation *currentLocation = [[CLLocation alloc] initWithLatitude:coordinates.latitude longitude:coordinates.longitude];
    

//        [RRRegistration sharedInstance].longitude = coordinates.longitude;
  //      [RRRegistration sharedInstance].latitude = coordinates.latitude;
    

    
    [_geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) {
            NSLog(@"Geocode failed with error: %@", error);
            return;
        }
        //                NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
        if (error == nil && [placemarks count] > 0) {
            _placemark = [placemarks lastObject];
            [_resultSearchController.searchBar setText:[_locationSearchTable parseAddress:(MKPlacemark *)_placemark]];
            
        } else {
            NSLog(@"%@", error.debugDescription);
        }
    }];
}

#pragma mark - Action Methods
- (IBAction)backButtonPressed:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)doneButtonPressed:(UIBarButtonItem *)sender {
    NSLog(@"Done Pressed");
    //    NSLog(@"accommodation: %@",_resultSearchController.searchBar.text);
    if (sender.tag == 1) {
        NSLog(@"SAVED");
        
        [self.navigationController popViewControllerAnimated:YES];
    } else  {
        _AccommodationAddress = _resultSearchController.searchBar.text; //Set the address of where the user has clicked as the actual address of where they live, ready for upload!
        NSLog(@"Accommodation: %@", _AccommodationAddress);
    //    [self accountCreationOverlayAlpha:1 animationDuration:0.2f]; //Show overlay
        [[WebService sharedInstance]registerAccount];
    }
    
//    NSLog(@"accommodation: %@",_resultSearchController.searchBar.text);
}

- (IBAction)okButtonPressed:(UIButton *)sender {
    NSLog(@"Ok Button Pressed");
    [self accountCreationOverlayAlpha:0 animationDuration:0.0f]; //Hide the overlay
    [self performSegueWithIdentifier:@"GoToEventTable" sender:self];
    
}


@end
