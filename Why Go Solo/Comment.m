//
//  Comment.m
//  Why Go Solo
//
//  Created by Andy Chamberlain on 28/10/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "Comment.h"
#import "WebService.h"
@implementation Comment

-(Comment*)initWithDict:(NSDictionary*)dict{
    if (self)
    {
        self.commentID = [dict valueForKey:COMMENT_PARAM_ID];
        self.commentText = [dict valueForKey:COMMENT_PARAM_TEXT];
        self.epochCreated = (int)[[dict valueForKey:COMMENT_PARAM_TEXT]integerValue];
        self.userID = [dict valueForKey:COMMENT_PARAM_USER_ID];
    }
    return self;

}




@end
