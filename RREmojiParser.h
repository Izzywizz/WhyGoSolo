//
//  RREmojiParser.h
//  Why Go Solo
//
//  Created by Andy Chamberlain on 30/10/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RREmojiParser : NSObject

+ (RREmojiParser*)sharedInstance;
-(NSString*)parseStringontainingEmojis:(NSString*)originalString;

@end
