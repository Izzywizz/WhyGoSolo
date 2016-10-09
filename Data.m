//
//  Data.m
//  Why Go Solo
//
//  Created by Andy Chamberlain on 18/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "Data.h"
#import "University.h"
#import "Residence.h"
@interface Data ()

@end

@implementation Data

+ (Data*)sharedInstance
{
    static Data *_sharedInstance = nil;
    
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^
                  {
                      _sharedInstance = [[Data alloc]init];
                  });
    
    return _sharedInstance;
}


-(void)createUniversitesArrayFromDict:(NSDictionary *)dict
{
    _universitesArray = [NSMutableArray new];
    
    for (NSDictionary *d in dict)
    {
        University *uni = [University new];
        
        uni.universityID = [d valueForKey:@"id"];
        uni.universityName = [d valueForKey:@"name"];
        uni.emailSuffix = [d valueForKey:@"email_suffix"];
        
        [_universitesArray addObject:uni];
    }
    
   // [_universitesArray sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    NSLog(@"UNI ARR = %@", _universitesArray);
    
    if (_delegate && [_delegate respondsToSelector:@selector(universitiesDownloadedSuccessfully)])
    {
        [self.delegate universitiesDownloadedSuccessfully];
    }
}


-(void)createResidencesArrayFromDict:(NSDictionary *)dict
{
    _residencesArray = [NSMutableArray new];
    
    for (NSDictionary *d in dict)
    {
        Residence *res = [Residence new];
        
        [_residencesArray addObject:res];
    }
    
    // [_universitesArray sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    NSLog(@"UNI ARR = %@", _residencesArray);
    
    if (_delegate && [_delegate respondsToSelector:@selector(residencesDownloadedSuccessfully)])
    {
        [self.delegate residencesDownloadedSuccessfully];
    }
}
@end
