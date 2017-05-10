//
//  CurrentUserLocation.h
//  UnderstandingAddingMapAnnotations
//
//  Created by Izzy on 31/08/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapViewController.h"

@interface CurrentUserLocation : NSObject <CLLocationManagerDelegate>

@property id <HandleCurrentUserLocation> delegate;

-(void) checkToSeeDelegateWorks;
-(CLLocationManager *) initializeLocationServices;

@end
