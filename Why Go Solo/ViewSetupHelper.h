//
//  FontSetup.h
//  Why Go Solo
//
//  Created by Izzy on 19/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ViewSetupHelper : NSObject

/**Ensures that the Navigation Controller Bar Button items that are returned are of the correct font type/ size and colour */
+(NSDictionary *) setNavigationButtonFontAndSize;

/** */
-(void) setColourOf: (UIView *)view toLabel: (UILabel *)label toTextField: (UITextField *)textfield toMessage: (NSString *)message;
-(void) setColourGrayAndBlack: (UIView *)view toLabel: (UILabel *)label toTextField: (UITextField *)textfield toMessage: (NSString *)message;

/** This method creates the circular image view that is used throughout the app, however the ciruclar image is dependant on the constraints of the imageView*/
-(void) createCircularView:(UIImageView *) imageView;

@end
