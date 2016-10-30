//
//  RRDownloadImage.h
//  Why Go Solo
//
//  Created by Andy Chamberlain on 30/10/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface RRDownloadImage : NSObject
+ (RRDownloadImage*)sharedInstance;
-(UIImage*)avatarImageForUserID:(NSString*)userID;

@end
