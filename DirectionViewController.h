//
//  DirectionViewController.h
//  Why Go Solo
//
//  Created by Izzy on 06/10/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface DirectionViewController : UIViewController<MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) NSString *addressToBeReverse;

-(void) reverseEngineerAddressToCoodinates: (NSString *) address;


@end
