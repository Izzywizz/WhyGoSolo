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
#import "PersistanceManager.h"
#import "Event.h"
#import "User.h"
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

-(void)authenticationSuccessful
{
    if (_delegate && [_delegate respondsToSelector:@selector(authenticationSuccessful)])
    {
        [self.delegate authenticationSuccessful];
    }
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


-(void)createEventsArrayFromDict:(NSDictionary *)dict
{
    NSLog(@"EV DICT = %@", dict);
    _eventsArray = [NSMutableArray new];
    _myEventsArray = [NSMutableArray new];
    
    for (NSDictionary *d in [dict valueForKey:@"events"])
    {
        Event *event = [[Event alloc]initWithDict:d];
        
    //    Event *event = [Event new];
        
      //  event.userID = (int)[[[d valueForKey:@"user" ]valueForKey:@"id"]integerValue];
        //event.eventDescription = [d valueForKey:@"description" ];
        [_eventsArray addObject:event];
    }
    
    for (NSDictionary *d in [dict valueForKey:@"my_events"])
    {
        Event *event = [[Event alloc]initWithDict:d];
        
        //    Event *event = [Event new];
        
        //  event.userID = (int)[[[d valueForKey:@"user" ]valueForKey:@"id"]integerValue];
        //event.eventDescription = [d valueForKey:@"description" ];
        [_myEventsArray addObject:event];
    }
    
    // [_universitesArray sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    NSLog(@"Event ARR = %@", _eventsArray);
    
    if (_delegate && [_delegate respondsToSelector:@selector(eventsDownloadedSuccessfully)])
    {
        [self.delegate eventsDownloadedSuccessfully];
    }
}

-(void)updateJoinedStatusFromDict:(NSDictionary*)dict
{
    NSLog(@"UPDATE JOINED DATA DICT: %@", dict);
    
    if (_delegate && [_delegate respondsToSelector:@selector(joinedStatusUpdatedSuccessfully)])
    {
        [self.delegate joinedStatusUpdatedSuccessfully];
    }
}

-(void)parseUserFromDict:(NSDictionary*)dict;
{
    NSLog(@"USER DICT = %@", dict);
    
    [Data sharedInstance].selectedUser = [[User alloc]initWithDict:dict];
    
    if (_delegate && [_delegate respondsToSelector:@selector(userParsedSuccessfully)])
    {
        [self.delegate userParsedSuccessfully];
    }


}



@end
