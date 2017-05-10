//
//  PinLocationData.h
//  UnderstandingAddingMapAnnotations
//
//  Created by Izzy on 02/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PinLocationData : NSObject

@property (nonatomic) NSString *pinTitle;
@property (nonatomic) double latitude;
@property (nonatomic) double longatitude;

-(NSDictionary *) dictionaryOfPinLocations;

@end
