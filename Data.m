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
#import "Comment.h"
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
    NSLog(@"Residence Dict inside DAta: %@", [dict valueForKey:@"residences"]);
    
    for (NSDictionary *d in [dict valueForKey:@"residences"])
    {
        Residence *res = [[Residence alloc] initWithDict:d];
        
        [_residencesArray addObject:res];
    }
        
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

        [_eventsArray addObject:event];
    }
    
    for (NSDictionary *d in [dict valueForKey:@"my_events"])
    {
        Event *event = [[Event alloc]initWithDict:d];
        [_myEventsArray addObject:event];
    }
    
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

-(void)parseEventFromDict:(NSDictionary*)dict;
{
    NSLog(@"SINGLE EVENT DICT = %@", dict);
    
    [Data sharedInstance].selectedEvent = [[Event alloc]initWithDict:[dict valueForKey:@"event"]];
    
    [Data sharedInstance].selectedEvent.friendsArray = [NSMutableArray new];
    [Data sharedInstance].selectedEvent.otherUsersArray = [NSMutableArray new];
    [Data sharedInstance].selectedEvent.commentsArray = [NSMutableArray new];

    
    for (NSDictionary* d in [[dict valueForKey:@"event"] valueForKey:@"friends"])
    {
        User *friend = [[User alloc]initWithDict:d];
        NSLog(@"Other Frinend name = %@", friend.firstName);

        [[Data sharedInstance].selectedEvent.friendsArray addObject:friend];
    }
    
    for (NSDictionary* d in [[dict valueForKey:@"event"] valueForKey:@"other_users"])
    {
        User *otherUser = [[User alloc]initWithDict:d];
        NSLog(@"Other USer name = %@", otherUser.firstName);
        [[Data sharedInstance].selectedEvent.otherUsersArray addObject:otherUser];
    }

    for (NSDictionary *d in [[dict valueForKey:@"event" ] valueForKey:@"comments"]) {
     
        NSLog(@"C DICT = %@",d);
        Comment *comment = [[Comment alloc]initWithDict:d];
        
        comment.commentUser = [[User alloc]initWithDict:[d valueForKey:@"user"]];

        [[Data sharedInstance].selectedEvent.commentsArray addObject:comment];
    
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(eventParsedSuccessfully)])
    {
        [self.delegate eventParsedSuccessfully];
    }
}

@end
