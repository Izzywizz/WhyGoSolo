//
//  OverlayView.h
//  Why Go Solo
//
//  Created by Izzy on 05/10/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OverlayView : UIView

@property (weak, nonatomic) IBOutlet UIView *internalView;
@property (weak, nonatomic) IBOutlet UILabel *eventText;
@property (weak, nonatomic) IBOutlet UILabel *eventTitle;


+ (id)overlayView;

@end
