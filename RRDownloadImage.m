//
//  RRDownloadImage.m
//  Why Go Solo
//
//  Created by Andy Chamberlain on 30/10/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "RRDownloadImage.h"

#import "Event.h"
#import "User.h"
#import "Data.h"

#import "AFNetworking.h"

#import "UIImageView+AFNetworking.h"
#import "AFHTTPRequestOperation.h"
#import "UIImageView+AFNetworking.h"
@implementation RRDownloadImage


+ (RRDownloadImage*)sharedInstance
{
    static RRDownloadImage *_sharedInstance = nil;
    
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^
                  {
                      _sharedInstance = [[RRDownloadImage alloc]init];
                  });
    
    return _sharedInstance;
}

-(void)downloadAvatarImageForUserID:(NSString*)userID
{
    NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"http://139.59.180.166/storage/%@@3x.png",userID]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFImageResponseSerializer serializer];
    
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        [[Data sharedInstance]updateAvatarDictWithImage:responseObject forUserID:userID];
      //  self.avatarImageView.image = responseObject;
        
        NSLog(@"Success Article Image = %@", responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         
         // self.avatarImageView.image = [UIImage imageNamed:@"white-logo-125-125"];
         
  //       [[Data sharedInstance]updateAvatarDictWithImage:[UIImage imageNamed:@"white-logo-125-125"] forUserID:self.event.userID];
         
         NSLog(@"IMAGE DOWLOAD FAILED");
     }];
    
    [operation start];
    
}


-(UIImage*)avatarImageForUserID:(NSString*)userID
{
    NSLog(@"userID FOR IMAGE DOWNLOAD = %@", userID);
    if ([[Data sharedInstance].avatarDict objectForKey:userID] != nil)
    {
        return [[Data sharedInstance].avatarDict objectForKey:userID];
    }
    else
    {
        [self downloadAvatarImageForUserID:userID];        
    }
    
    return [UIImage new];
}

@end
