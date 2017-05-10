//
//  DirectionViewController.h
//  Why Go Solo
//
//  Created by Izzy on 06/10/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "ViewSetupHelper.h"

@interface DirectionViewController : UIViewController<MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) NSString *addressToBeReverse;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;

-(void) reverseEngineerAddressToCoodinates: (NSString *) address;


@end
