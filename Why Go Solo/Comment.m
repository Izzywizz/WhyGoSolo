//
//  Comment.m
//  Why Go Solo
//
//  Created by Andy Chamberlain on 28/10/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "Comment.h"

@implementation Comment

-(Comment*)initWithDict:(NSDictionary*)dict{
    if (self)
    {
        self.commentID = [dict valueForKey:@"id"];
        self.commentText = [dict valueForKey:@"comment_text"];
        self.epochCreated = (int)[[dict valueForKey:@"epoch_created"]integerValue];
    
    }
    return self;

}




@end
