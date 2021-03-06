//
//  ViewController.m
//  UnderstandingAddingMapAnnotations
//
//  Created by Izzy on 24/08/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "MapViewController.h"
#import "CurrentUserLocation.h"
#import "SearchBarTableViewController.h"
#import "PinLocationData.h"
#import "ViewSetupHelper.h"
#import "WebService.h"
#import "Data.h"
#import "Event.h"
#import "RREmojiParser.h"


#define METERS_PER_MILE 1609.344

@import MapKit;

@interface MapViewController () <DataDelegate>

//Connected map interface with storyboard

@property (nonatomic, strong) CurrentUserLocation *userLocation;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property(nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic) CLGeocoder *geocoder;
@property (nonatomic) CLPlacemark *placemark;
@property (nonatomic) SearchBarTableViewController *locationSearchTable;
@property (nonatomic) UISearchController *resultSearchController;
@property (nonatomic) MKAnnotationView *annotationView;
@property (strong, nonatomic) PinLocationData *pinData;
@property (nonatomic) MKPlacemark *selectedPin;

@property NSString *address;

@property int touchPinCount;


@property MKPointAnnotation *customAnnotation;

@end

@implementation MapViewController


#pragma mark - UI View Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationButtonFontAndSize];
    [self initialSetup];
}

-(void)viewWillAppear:(BOOL)animated    {
    
    [self.mapView setDelegate:self];
    [Data sharedInstance].delegate = self;
    
    if (!_customAnnotation) {
        _customAnnotation = [[MKPointAnnotation alloc] init];
        _customAnnotation.title =[_locationSearchTable parseAddress:(MKPlacemark *)_placemark];
        [self.mapView addAnnotation:_customAnnotation];
    }
    
    [self startCurrentUserLocation:YES];
    [self setupLongPressGesture];
    //[self createPinLocations];
//    NSLog(@"userLocation xx: %d",[self.mapView showsUserLocation]);
  //  _mapView.showsUserLocation = YES;
    
  
}

-(void)viewWillDisappear:(BOOL)animated {
    self.mapView.delegate = nil;
    self.locationManager.delegate = nil;
    [Data sharedInstance].delegate = nil;
    self.definesPresentationContext = NO;
    
}

-(void)eventsDownloadedSuccessfully
{
    [self setupAlertBox];
}
#pragma mark - Helper Functions

-(void) setNavigationButtonFontAndSize  {
    
    NSDictionary *attributes = [ViewSetupHelper setNavigationButtonFontAndSize];
    
    [_doneOrNextButton setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    if ([Data sharedInstance].createdEvent != nil)
    {
        [_doneOrNextButton setTitle:@"Save"];
    }
}

-(void) sayHello    {
    NSLog(@"Hello");
}


/** This method setups the current user location object from the CurrentUserLocation class so that location services can be activated*/
-(void) startCurrentUserLocation: (BOOL) isUserLocation {
    if (isUserLocation) {
        _locationManager = [self initializeLocationServices]; //creates the userLocation
    } else {
        NSLog(@"User Location Services Offline");
    }
}

/** A method that setups the initial properties, instantiate the view controllers needed for the search bar and makes sure that the table view is connected.*/
-(void) initialSetup {
    _pinData = [[PinLocationData alloc] init];
    _touchPinCount = 0;
    [self locationSetup];
    [self setupSearchBar];
}

-(void) locationSetup   {
    _userLocation = [[CurrentUserLocation alloc] init];
    _userLocation.delegate = self;
    [_userLocation checkToSeeDelegateWorks];
    _geocoder = [[CLGeocoder alloc] init];
}

-(void) setupSearchBar  {
    NSLog(@"SerachBar Loaded");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    _locationSearchTable = [storyboard instantiateViewControllerWithIdentifier:@"SearchBarTableViewController"];
    _resultSearchController = [[UISearchController alloc] initWithSearchResultsController:_locationSearchTable];
    _resultSearchController.searchResultsUpdater = _locationSearchTable;
    
    UISearchBar *searchBar = _resultSearchController.searchBar;
    [searchBar sizeToFit];
    searchBar.placeholder = @"Add Location";
    self.navigationItem.titleView = _resultSearchController.searchBar;
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    _resultSearchController.hidesNavigationBarDuringPresentation = NO;
    _resultSearchController.dimsBackgroundDuringPresentation = YES;
    self.definesPresentationContext = YES;
    
    _locationSearchTable.mapView = _mapView;
    _locationSearchTable.delegate = self;
}

#pragma mark - Protocol Methods
/** A method that requests the user permission for starting location servies, this is paired with the info.plist key: NSLocationWhenInUseUsageDescription, String: "We need to use your location etc" */
- (CLLocationManager *) initializeLocationServices
{
    _locationManager = [[CLLocationManager alloc] init];
    return [_userLocation initializeLocationServices];
}


-(void) zoomToUserLocation: (CLLocation *) userLocation  {
    
    NSLog(@"CREATEED EVENT LONG = %f",[Data sharedInstance].createdEvent.longitude);
    
    if ([Data sharedInstance].createdEvent.longitude != 0)
    {
        
        
        CLLocation* createdCoordinates = [[CLLocation alloc]initWithLatitude:[Data sharedInstance].createdEvent.latitude longitude:[Data sharedInstance].createdEvent.longitude];
        
        userLocation = createdCoordinates;
        
   /*     MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(createdCoordinates.coordinate, 800, 800);
        [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
        
        if (!_customAnnotation) {
            _customAnnotation = [[MKPointAnnotation alloc] init];
            [_customAnnotation setCoordinate:createdCoordinates.coordinate];
            
            _customAnnotation.title =[_locationSearchTable parseAddress:(MKPlacemark *)_placemark];
            [self.mapView addAnnotation:_customAnnotation];
        }
         */
    }
    else
    {

    }
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
}

/*
-(void) zoomToUserLocation: (CLLocation *) userLocation  {
    
    NSLog(@"CREATEED EVENT LONG = %f",[Data sharedInstance].createdEvent.longitude);
    
    if ([Data sharedInstance].createdEvent.longitude != 0)
    {
        CLLocation* createdCoordinates = [[CLLocation alloc]initWithLatitude:[Data sharedInstance].createdEvent.latitude longitude:[Data sharedInstance].createdEvent.longitude];
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(createdCoordinates.coordinate, 800, 800);
        [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
        
        if (!_customAnnotation) {
            _customAnnotation = [[MKPointAnnotation alloc] init];
            [_customAnnotation setCoordinate:createdCoordinates.coordinate];

            _customAnnotation.title =[_locationSearchTable parseAddress:(MKPlacemark *)_placemark];
            [self.mapView addAnnotation:_customAnnotation];
        }

    }
    else
    {
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
        [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    }
    
}*/

- (void)getDirections {
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:_selectedPin];
    //[mapItem openInMapsWithLaunchOptions:(@{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving})];
    [mapItem openInMapsWithLaunchOptions:nil];
}


- (void)dropPinZoomIn:(MKPlacemark *)placemark
{
    // cache the pin
    _selectedPin = placemark;
    //    if (_touchPinCount > 1) {
    //        [_mapView removeAnnotation:_customAnnotation];
    //    }
    // clear existing pins
    //    [_mapView removeAnnotations:(_mapView.annotations)];
    
    //Create an anotation from where the user had touched the location
    _customAnnotation.coordinate = placemark.coordinate;
   // _customAnnotation.title =_resultSearchController.searchBar.text;//placemark.name;
    _customAnnotation.subtitle = [NSString stringWithFormat:@"%@ %@",
                                  (placemark.locality == nil ? @"" : placemark.locality),
                                  (placemark.administrativeArea == nil ? @"" : placemark.administrativeArea)
                                  ];
    [_mapView addAnnotation:_customAnnotation];
    MKCoordinateSpan span = MKCoordinateSpanMake(0.005, 0.005);
    MKCoordinateRegion region = MKCoordinateRegionMake(placemark.coordinate, span);
    [_mapView setRegion:region animated:true];
}

/** A method that obtains the address based on the coordiantes passed in to it */
-(void) reverseGeoCoodantes: (CLLocationCoordinate2D) coordinates     {
    CLLocation *currentLocation = [[CLLocation alloc] initWithLatitude:coordinates.latitude longitude:coordinates.longitude];
    
    
    if ([Data sharedInstance].createdEvent.longitude != 0)
    {
    
   //     currentLocation =[[CLLocation alloc] initWithLatitude:[Data sharedInstance].createdEvent.latitude longitude:[Data sharedInstance].createdEvent.longitude];
    }
    
    
    [_geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) {
            NSLog(@"Geocode failed with error: %@", error);
            return;
        }
        //                NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
        if (error == nil && [placemarks count] > 0) {
            _placemark = [placemarks lastObject];
            [_resultSearchController.searchBar setText:[_locationSearchTable parseAddress:(MKPlacemark *)_placemark]];
            _customAnnotation.title = _resultSearchController.searchBar.text;
            
        } else {
            NSLog(@"%@", error.debugDescription);
        }
    }];
}

#pragma mark - Long Press Gesture Methods

/** A method that handles the long pressing gesture of the user when called from the action/ selector.
 This is called as when the user touches the screen for period of customisable time*/
- (void)handleLongPress:(UIGestureRecognizer *)gestureRecognizer
{
    
    //if the user is not in the long press state then dont do anything
    if (gestureRecognizer.state != UIGestureRecognizerStateBegan)
        return;
    
    //Obtain the map coordinates from the user touch and store it for future use
    CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];
    CLLocationCoordinate2D touchMapCoordinate = [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
    
    //Create an anotation from where the user had touched the location
    // MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    _customAnnotation.coordinate = touchMapCoordinate;
    _customAnnotation.title = [_locationSearchTable parseAddress:(MKPlacemark *)_placemark]; //setup dynamically from the data model?
  //  [self.mapView addAnnotation:_customAnnotation];
    [self reverseGeoCoodantes:touchMapCoordinate];
    _touchPinCount++;
    
    if (_touchPinCount > 1) {
        //            [_mapView removeAnnotation:_customAnnotation];
    }
}

/** A method that creates the long press gesture control, registers it with the map view so it knows that the gesture only works on the mapView*/
-(void) setupLongPressGesture   {
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 0.25; //user needs to press for 1 second
    [self.mapView addGestureRecognizer:lpgr];
}

#pragma mark - Pin Methods

-(NSMutableArray *) unpackPinData   {
    
    NSDictionary *pinLocations = [[NSDictionary alloc] init];
    NSMutableArray *arrayOfPins = [[NSMutableArray alloc] init];
    
    pinLocations = [_pinData dictionaryOfPinLocations];
    
    for (NSString *pinLocation in pinLocations) {
        MKPointAnnotation *pin = [[MKPointAnnotation alloc] init];
        NSString *latitude = [pinLocations valueForKeyPath:[pinLocation stringByAppendingString:@".Latitude"]];
        NSString *longitude = [pinLocations valueForKeyPath:[pinLocation stringByAppendingString:@".Longitude"]];
        
        //convert to double
        double latitudeDouble = [latitude doubleValue];
        double longitudeDouble = [longitude doubleValue];
        
        //create the pin coordinates
        pin.coordinate = CLLocationCoordinate2DMake(latitudeDouble, longitudeDouble);
        pin.title = pinLocation;
        [arrayOfPins addObject:pin];
    }
    
    return arrayOfPins;
}

//add the pins to the mapView
-(void) createPinLocations  {
    [_mapView addAnnotations:[self unpackPinData]];
}


#pragma mark - Pin Delegate Methods
/* This delegate is called when the annotation pin has beem created, it sets the image (possible emoticon) and adds it the callout for selection   */
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation   {
    
    // UserLocation Pin (blue dot)
    if ([annotation isKindOfClass:[MKUserLocation class]])  {
        return nil;
    }
    
    if (annotation != mapView.userLocation) {
        
        MKAnnotationView *pin = [self.mapView dequeueReusableAnnotationViewWithIdentifier:@"myPin"];
        
        if (pin == nil) {
            pin = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myPin"];
        } else {
            pin.annotation = annotation;
        }
        
        pin.canShowCallout = YES;
        pin.draggable = YES;
        pin.image = [UIImage imageNamed:@"map-pin-34-58"];
        
        return pin;
    }
    
    return nil;
    
}

/** Handles the different states of dragging when the user picks up the event pins, updates the coordinates and then sends them to be reversed engineered so that the address bar shows the correct addres for the pins new locaiton */
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)annotationView didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState
{
    if (newState == MKAnnotationViewDragStateStarting)
    {
        annotationView.dragState = MKAnnotationViewDragStateDragging;
    }
    else if (newState == MKAnnotationViewDragStateEnding || newState == MKAnnotationViewDragStateCanceling)
    {
        CLLocationCoordinate2D droppedAt = annotationView.annotation.coordinate;
        NSLog(@"Coodiantes: longitude: %f, latitude: %f", droppedAt.longitude, droppedAt.latitude);
        [self reverseGeoCoodantes:droppedAt];
                annotationView.dragState = MKAnnotationViewDragStateNone;
        [annotationView setDragState:MKAnnotationViewDragStateNone animated:YES];
                _customAnnotation.title = [_locationSearchTable parseAddress:(MKPlacemark *)_placemark];
    }
}

/** This delegate hides the current location if the user wished it, renabling it, hs the effect of hiding the blue dot but showing the user current location anyway.*/
-(void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    
    if ([Data sharedInstance].createdEvent.longitude != 0)
    {
    _customAnnotation.coordinate = [[CLLocation alloc] initWithLatitude:[Data sharedInstance].createdEvent.latitude longitude:[Data sharedInstance].createdEvent.longitude].coordinate;
        return;
    }

    MKAnnotationView *currentUserLocation = [mapView viewForAnnotation:mapView.userLocation];
 //   currentUserLocation.hidden = YES;
    _customAnnotation.coordinate = mapView.userLocation.coordinate;
    
}

/** This delegate method ensures that when the user taps on the flag or current location that the address in scope updated*/
//-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
//    id <MKAnnotation> annotation = [view annotation];
//
//    if ([annotation isKindOfClass:[MKUserLocation class]]) {
//        NSLog(@"User Location Clicked");
//    }
//
//    if (annotation != mapView.userLocation)
//    {
//        NSString *location = [annotation title];
//        NSLog(@"Clicked Flag: %@", location);
//    }
//}

#pragma mark - AlertBox Methods

/** Creates an alertBox that prompts the user to set the appropiate permission for allowing the aplication to have acccess ot their location whilst using the app. It takens them directly to the settings for the application */
-(void) setupAlertSettingsBox: (CLAuthorizationStatus) status   {
    NSString *title;
    title = (status == kCLAuthorizationStatusDenied) ? @"Location services are off" : @"Background location is not enabled";
    NSString *message = @"To use background location you must turn on 'While Using the App' in the Location Services Settings";
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Cancel Selected");
    }];
    UIAlertAction *settings = [UIAlertAction actionWithTitle:@"Setting" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // Send the user to the Settings for this app
        NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:settingsURL];
    }];
    
    [alertVC addAction:cancel];
    [alertVC addAction:settings];
    [self presentViewController:alertVC animated:YES completion:nil];
}


#pragma mark - Action Methods
- (IBAction)backButtonPressed:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)doneButtonPressed:(UIBarButtonItem *)sender {
    
    NSLog(@"POST EVENT");

    [Data sharedInstance].createdEvent.address = _resultSearchController.searchBar.text ;
    NSLog(@"POST EVENT 1");
    
    [Data sharedInstance].createdEvent.latitude = _placemark.location.coordinate.latitude;
    NSLog(@"POST EVENT2");
    
    [Data sharedInstance].createdEvent.longitude = _placemark.location.coordinate.longitude;

    if (sender.tag == 0) {
        NSLog(@"DONE pressed");
        [self.navigationController popViewControllerAnimated:YES];
     //   [Data sharedInstance].createdEvent.address = _resultSearchController.searchBar.text ;
       // [Data sharedInstance].createdEvent.latitude = _placemark.location.coordinate.latitude;
       // [Data sharedInstance].createdEvent.longitude = _placemark.location.coordinate.longitude;
        
        
    } else {
  //      NSLog(@"POST EVENT");
        //TODO: Add logic to create the event
    //    [Data sharedInstance].createdEvent.address = _resultSearchController.searchBar.text ;
      //  NSLog(@"POST EVENT 1");
        
        //[Data sharedInstance].createdEvent.latitude = _placemark.location.coordinate.latitude;
       // NSLog(@"POST EVENT2");
        
        //[Data sharedInstance].createdEvent.longitude = _placemark.location.coordinate.longitude;
       // NSLog(@"POST EVENT3");
        // NSLog(@"EVENTS CREATE DICT aa= %@", EVENT_API_CREATE_DICT);
        
      //  NSLog(@"POST EVENT4");
        //   [self setupAlertBox];

        [[WebService sharedInstance]eventsApiRequest:EVENT_API_CREATE];
        
    }
    
}

-(void) setupAlertBox  {
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"Event Posted" message:@"Your event has been created" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Return to main event screen");
    
        [self performSegueWithIdentifier:@"GoToEvent" sender:self];
    }];
    
    [alertVC addAction:ok];
    [self presentViewController:alertVC animated:YES completion:nil];
}

#pragma mark - Directions Methods

@end