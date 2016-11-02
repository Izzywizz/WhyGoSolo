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
        self.commentID = [NSString stringWithFormat:@"%i", (int)[[dict valueForKey:COMMENT_ID_KEY]integerValue] ];
        self.commentText = [dict valueForKey:COMMENT_TEXT_KEY];
        self.epochCreated = (int)[[dict valueForKey:COMMENT_EPOCH_CREATED_KEY]integerValue];
        self.userID = [NSString stringWithFormat:@"%i", (int)[[dict valueForKey:COMMENT_USER_ID_KEY]integerValue] ];
    }
    return self;

}




@end
