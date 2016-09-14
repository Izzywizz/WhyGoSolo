//
//  UniversityLocations.m
//  Why Go Solo
//
//  Created by Izzy on 14/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "UniversityLocations.h"

@implementation UniversityLocations

-(NSDictionary *) returnListOfUniversity {
    
    NSDictionary *dict = [[NSDictionary alloc] init];
    dict = @{@"Liverpool" : @[@"Liverpool University", @"Liverpool John Moores", @"Liverpool University", @"Liverpool Hope", @"Liverpool Institude for Performing Arts", @"Edge Hill University"]
             };
    
    return dict;
}

@end
