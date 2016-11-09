//
//  Residence.m
//  Why Go Solo
//
//  Created by Andy Chamberlain on 19/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "Residence.h"

@implementation Residence

-(Residence *) initWithDict: (NSDictionary *)dict   {
    
    NSLog(@"Dictionary Inside Residence: %@", dict);
    if (self)
    {
        self.residenceName = [dict valueForKey:@"name"];
        self.address = [dict valueForKey:@"address"];
        self.city = [dict valueForKey:@"city"];
        self.postCode = [dict valueForKey:@"post_code"];
        self.longitude = (double)[[dict valueForKey:@"longitude"] doubleValue];
        self.latitude = (double)[[dict valueForKey:@"latitude"]doubleValue];
        self.residenceID = (int)[[dict valueForKey:@"id"] integerValue];
    }
    return self;
    
}

@end
