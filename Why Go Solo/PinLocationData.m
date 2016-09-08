//
//  PinLocationData.m
//  UnderstandingAddingMapAnnotations
//
//  Created by Izzy on 02/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "PinLocationData.h"

@implementation PinLocationData

-(NSDictionary *) dictionaryOfPinLocations    {
    
    NSDictionary *dictionary = @{@"Pin One" :
                                     @{ @"Latitude" : [NSNumber numberWithDouble:53.4093436],
                                        @"Longitude" : [NSNumber numberWithDouble:-2.9887912]},
                                 
                                 @"Pin Two" :
                                     @{ @"Latitude" : [NSNumber numberWithDouble:53.4022152],
                                        @"Longitude" : [NSNumber numberWithDouble:-2.9796373]},
                                 
                                 @"Pin Three" :
                                     @{ @"Latitude" : [NSNumber numberWithDouble:53.40166],
                                        @"Longitude" : [NSNumber numberWithDouble:-2.98684]}
                                 };
    
    return dictionary;
}


@end
