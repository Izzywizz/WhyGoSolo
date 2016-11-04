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

#import "WebService.h"
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



-(void)updateAvatarDictWithImage:(UIImage*)avatarImage forUserID:(NSString*)userID
{
    [[Data sharedInstance].avatarDict setObject:avatarImage forKey:userID];
    
    if (_delegate && [_delegate respondsToSelector:@selector(avatarDownloaded)])
    {
        [self.delegate performSelector:@selector(avatarDownloaded)];
    }
}

-(void)login
{
    NSLog(@"XXXXXXewqr2r 2");
    [[PersistanceManager sharedInstance]saveUserID:[Data sharedInstance].userID andToken:[Data sharedInstance].userToken];
    [[WebService sharedInstance]authentication];

}

-(void)authenticationSuccessful
{
    [Data sharedInstance].filterDistance = FILTER_DEFAULT_VALUE_DISTANCE;
      [Data sharedInstance].residenceFilterArray = [NSMutableArray new];
    [Data sharedInstance].residenceFilterArrayString = FILTER_DEFAULT_VALUE_RESIDENCE_ID_ARRAY;
    
    [Data sharedInstance].avatarDict = [NSMutableDictionary new];
    if (_delegate && [_delegate respondsToSelector:@selector(authenticationSuccessful)])
    {
        
        [self.delegate performSelector:@selector(authenticationSuccessful)];
       // [self.delegate authenticationSuccessful];
    }
}

-(void)updateResidenceFilterArrayString
{
    if ([[Data sharedInstance].residenceFilterArray count]>0)
    {
        [Data sharedInstance].residenceFilterArrayString  = [[[Data sharedInstance].residenceFilterArray valueForKey:@"description"] componentsJoinedByString:@","];
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
    
  //  [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat:@"Respose%li",(long)EVENT_API_ALL] object:nil];
    
  //  return;
    
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

-(void)friendStatusUpdated:(NSDictionary*)dict
{
    [[WebService sharedInstance]eventsApiRequest:USER_API_SINGLE];
}

-(void)reportUserSuccessful
{
    NSLog(@"USER REPORTED SUCCESSFUL");
    [[WebService sharedInstance]eventsApiRequest:USER_API_SINGLE];

}
-(void)blockStatusUpdated
{
    NSLog(@"USER BLOCKED SUCCESSFUL");

    [[WebService sharedInstance]eventsApiRequest:USER_API_SINGLE];

}
-(void)createCommentSuccessful
{
    if (_delegate && [_delegate respondsToSelector:@selector(commentCreated)])
    {
        [self.delegate commentCreated];
    }
}

-(void)eventCancelSuccessful
{
     NSLog(@"EVENT CANCELLED");
    [[WebService sharedInstance]eventsApiRequest:EVENT_API_SINGLE];

}
-(void)eventCloseSuccessful
{
     NSLog(@"EVENT CLOSED");
    [[WebService sharedInstance]eventsApiRequest:EVENT_API_SINGLE];

}

-(void)deleteCommentSuccessful
{
    NSLog(@"COMMENT DELETED");
    [[WebService sharedInstance]eventsApiRequest:EVENT_API_SINGLE];
}
-(void)reportCommentSuccessful
{
    NSLog(@"COMMENT REPORTED");
    if (_delegate && [_delegate respondsToSelector:@selector(commentReported)])
    {
        [self.delegate commentReported];
    }
}
-(void)eventEditSuccessful
{
    NSLog(@"EVENT EDITED xx");
    
    [[WebService sharedInstance]eventsApiRequest:EVENT_API_ALL];
    return;
    if (_delegate && [_delegate respondsToSelector:@selector(eventEdited)])
    {
        [self.delegate eventEdited ];
    }
}

-(void)createFriendsFromDict:(NSDictionary*)dict
{
    NSLog(@"Friends  DICT -= %@", dict);
    
      _friendsAttendingEventsArray = [NSMutableArray new];
    _friendsNotAttendingEventsArray = [NSMutableArray new];
    
    for (NSDictionary* d in [dict valueForKey:@"attending_events"])
    {
        User *u = [[User alloc]initWithDict:[d valueForKey:@"user" ]];
        
        Event *e = [[Event alloc]initWithDict:[d valueForKey:@"event" ]];
        
        u.eventsArray = [[NSMutableArray alloc]initWithObjects:e, nil];
        
        [_friendsAttendingEventsArray addObject:u];
    }
   
    for (NSDictionary* d in [[dict valueForKey:@"not_attending_events"]valueForKey:@"user" ])
    {

        User *u = [[User alloc]initWithDict:d];
        
        [_friendsNotAttendingEventsArray addObject:u];
    }

    
    
    
    
    NSLog(@"Friends Attending Array %@", _friendsAttendingEventsArray);
    
    NSLog(@"Friends NOT Attending Array %@", _friendsNotAttendingEventsArray);

    if (_delegate && [_delegate respondsToSelector:@selector(friendsParsedSuccessfully)])
    {
        [self.delegate friendsParsedSuccessfully ];
    }
}
-(void)createEveryoneFromDict:(NSDictionary*)dict
{
    NSLog(@"EVERYUOPNE DICT -= %@", dict);
    
    _everyoneArray = [NSMutableArray new];
    
    for (NSDictionary* d in [dict valueForKey:@"attending_events"])
    {
        User *u = [[User alloc]initWithDict:[d valueForKey:@"user" ]];
        
        Event *e = [[Event alloc]initWithDict:[d valueForKey:@"event" ]];
        
        u.eventsArray = [[NSMutableArray alloc]initWithObjects:e, nil];
        
        [_everyoneArray addObject:u];
    }

    
    NSLog(@"Everyone Attending Array %@", _everyoneArray);


    if (_delegate && [_delegate respondsToSelector:@selector(everyoneParsedSuccessfully)])
    {
        [self.delegate everyoneParsedSuccessfully ];
    }

}
-(void)parseUserFromDict:(NSDictionary*)dict;
{
    NSLog(@"USER DICT = %@", dict);
    
    if ([[dict valueForKey:@"user" ]valueForKey:@"added_as_friend"]) {
        dict = [dict valueForKey:@"user" ];
    }
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
