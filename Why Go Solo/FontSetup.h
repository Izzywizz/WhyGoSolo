//
//  FontSetup.h
//  Why Go Solo
//
//  Created by Izzy on 19/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FontSetup : NSObject


+(NSDictionary *) setNavigationButtonFontAndSize;
-(void) setColourOf: (UIView *)view toLabel: (UILabel *)label toTextField: (UITextField *)textfield toMessage: (NSString *)message;

@end
