//
//  EventCollectionViewCell.m
//  Why Go Solo
//
//  Created by Izzy on 03/10/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "EventCollectionViewCell.h"

@implementation EventCollectionViewCell

-(void)awakeFromNib {
    self.innerView.layer.cornerRadius = 5;
}
- (IBAction)eventButtonPressed:(UIButton *)sender {
    switch (sender.tag) {
        case JOIN: NSLog(@"Join Button Pressed");
            break;
        case EDIT: NSLog(@"Edit Button Pressed");
            break;
        case PROFILE: NSLog(@"Profile Button Pressed");
            break;
        default:
            break;
    }
    
}

@end
