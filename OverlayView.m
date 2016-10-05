//
//  OverlayView.m
//  Why Go Solo
//
//  Created by Izzy on 05/10/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "OverlayView.h"

@implementation OverlayView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
#pragma mark - View Methods

-(void)awakeFromNib {
    self.internalView.layer.cornerRadius = 5;
    

}

#pragma mark - Action Methods
- (IBAction)noButtonPressed:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"No" object:self];
}

- (IBAction)yesButtonPressed:(UIButton *)sender {
    if (_internalView.tag == 1) {
        NSLog(@"Cancel event TAG");
    } else  {
        NSLog(@"CLOSE TAG");
    }
}

+ (id)overlayView
{
    OverlayView *overlayView = [[[NSBundle mainBundle] loadNibNamed:@"OverlayView" owner:nil options:nil] lastObject];
    // make sure customView is not nil or the wrong class!
    
    if ([overlayView isKindOfClass:[OverlayView class]])
        return overlayView;
    else
        return nil;
}
@end
