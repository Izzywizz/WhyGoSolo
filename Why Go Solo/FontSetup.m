//
//  FontSetup.m
//  Why Go Solo
//
//  Created by Izzy on 19/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "FontSetup.h"

@implementation FontSetup


+(NSDictionary *) setNavigationButtonFontAndSize  {
    
    NSUInteger size = 12;
    NSString *fontName = @"Lato";
    UIFont *font = [UIFont fontWithName:fontName size:size];
    NSDictionary * attributes = @{NSFontAttributeName: font};
    
    return attributes;
}

/** Method that sets the colour of multiple views/ textfields to red to make it look like it failed validation*/
-(void) setColourOf: (UIView *)view toLabel: (UILabel *)label toTextField: (UITextField *)textfield toMessage: (NSString *)message  {
    UIColor *colour = [UIColor redColor];
    
    view.backgroundColor = colour;
    label.textColor = colour;
    textfield.textColor = colour;
    textfield.attributedPlaceholder = [[NSAttributedString alloc] initWithString:message attributes:@{NSForegroundColorAttributeName: colour}];
}

-(void) setColourGrayAndBlack: (UIView *)view toLabel: (UILabel *)label toTextField: (UITextField *)textfield toMessage: (NSString *)message  {
    UIColor *colourGray = [UIColor colorWithRed:188/ 255.0 green:186/255.0 blue:193/255.0 alpha:1.0];
    UIColor *colour = [UIColor blackColor];
    
    view.backgroundColor = colourGray;
    label.textColor = colour;
    textfield.textColor = colour;
    textfield.attributedPlaceholder = [[NSAttributedString alloc] initWithString:message attributes:@{NSForegroundColorAttributeName: colourGray}];
}

@end
