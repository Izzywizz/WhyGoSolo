//
//  AccommodationMapViewController.m
//  Why Go Solo
//
//  Created by Izzy on 16/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "AccommodationMapViewController.h"
#import "SearchBarTableViewController.h"


@interface AccommodationMapViewController ()

@property (nonatomic) SearchBarTableViewController *locationSearchTable;
@property (nonatomic) UISearchController *resultSearchController;

@end

@implementation AccommodationMapViewController

#pragma mark - UI View Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Accommodation Map View");
    [self setNavigationButtonFontAndSize];
    [self setupSearchBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated   {
    [self.mapView setDelegate:self];
    self.locationSearchTable.delegate = self;
}

-(void) viewWillDisappear:(BOOL)animated    {
    self.mapView.delegate = nil;
}


#pragma mark - Helper Functions

-(void) setNavigationButtonFontAndSize  {
    
    NSUInteger size = 12;
    NSString *fontName = @"Lato";
    UIFont *font = [UIFont fontWithName:fontName size:size];
    NSDictionary * attributes = @{NSFontAttributeName: font};
    [_doneButton setTitleTextAttributes:attributes forState:UIControlStateNormal];
}

-(void) setupSearchBar  {
    NSLog(@"SerachBar Loaded");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    _locationSearchTable = [storyboard instantiateViewControllerWithIdentifier:@"SearchBarTableViewController"];
    _resultSearchController = [[UISearchController alloc] initWithSearchResultsController:_locationSearchTable];
    _resultSearchController.searchResultsUpdater = _locationSearchTable;
    
    UISearchBar *searchBar = _resultSearchController.searchBar;
    //    searchBar.barTintColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1];
    searchBar.searchBarStyle = UISearchBarStyleMinimal; // allows you to create a barButton item without affecting the style of serach, without this that horrible default overlay would return
    [searchBar sizeToFit];
    searchBar.placeholder = @"Search for places";

    self.navigationItem.titleView = _resultSearchController.searchBar;
    _resultSearchController.hidesNavigationBarDuringPresentation = NO;
    _resultSearchController.dimsBackgroundDuringPresentation = YES;
    _resultSearchController.searchBar.showsCancelButton = false;

    self.definesPresentationContext = YES;
    _locationSearchTable.mapView = _mapView;
    _locationSearchTable.delegate = self;

}

#pragma mark - Delegate Method

- (void)dropPinZoomIn:(MKPlacemark *)placemark
{
    // clear existing pins
    //    [_mapView removeAnnotations:(_mapView.annotations)];
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
}

#pragma mark - Action Methods
- (IBAction)backButtonPressed:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)doneButtonPressed:(UIBarButtonItem *)sender {
    NSLog(@"Done Pressed");
}


@end
