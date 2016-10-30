//
//  RREmojiParser.m
//  Why Go Solo
//
//  Created by Andy Chamberlain on 30/10/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "RREmojiParser.h"

@implementation RREmojiParser


+ (RREmojiParser*)sharedInstance
{
    static RREmojiParser *_sharedInstance = nil;
    
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^
                  {
                      _sharedInstance = [[RREmojiParser alloc]init];
                  });
    
    return _sharedInstance;
}
-(NSString*)parseStringontainingEmojis:(NSString*)originalString
{
    const char *jsonString = [originalString UTF8String];
    NSData *jsonData = [NSData dataWithBytes:jsonString length:strlen(jsonString)];
    return [[NSString alloc] initWithData:jsonData encoding:NSNonLossyASCIIStringEncoding];
    
    return @"";
}
@end
