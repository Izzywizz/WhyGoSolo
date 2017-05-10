//
//  OverlayView.m
//  Why Go Solo
//
//  Created by Izzy on 05/10/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "OverlayView.h"

@implementation OverlayView

#pragma mark - View Methods

-(void)awakeFromNib {
    self.internalView.layer.cornerRadius = 5;
    self.internalHelpView.layer.cornerRadius = 5;
    self.internalHelpView.alpha = 0; //intially hide the help view
    [self setupObserver];
    
}

#pragma mark - Action Methods
- (IBAction)noButtonPressed:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"removeOverlay" object:self];
}

- (IBAction)yesButtonPressed:(UIButton *)sender {
    if (_internalView.tag == 1) {
        NSLog(@"Cancel event TAG");
    } else if (_internalView.tag == 2)  {
        NSLog(@"CLOSE TAG");
    } else if (_internalView.tag == 3)  {
        NSLog(@"Report User ***");
        _helpLabel.text = [NSString stringWithFormat:@"\n%@ profile has been reported and will be reviewed.\n",_reportedUserName];
        _helpLabel.textAlignment = NSTextAlignmentCenter;
        _helpViewTitleLabel.text = @"User Reported";
        _internalHelpView.alpha = 1;
    } else if (_internalView.tag == 4)  {
        NSLog(@"Delete comment from the user: Logic to be added to remove message from the server");
    } else if (_internalView.tag == 5)  {
        NSLog(@"Report comment from another user");
        _helpLabel.text = [NSString stringWithFormat:@"%@'s comment has been reported our moderators will review it\n",_commmentReportedUserName];
        _helpLabel.textAlignment = NSTextAlignmentCenter;
        _helpViewTitleLabel.text = @"Comment Reported";
        _internalHelpView.alpha = 1;
        _helpViewTopLine.alpha = 0; //hide the top line but leave it there hidden becasue we need the constraint
        
    } else if(_internalView.tag == 6)  {
        NSLog(@"Delete Account Comfirmation");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"deleteConfirmation" object:self];
    }
}

- (IBAction)okButtonPressed:(UIButton *)sender {
    NSLog(@"ok Button pressed, logif specifc tag or actions from previous notification can be added here");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"removeOverlay" object:self];
}

#pragma Helper Functions    

#pragma mark - Class Methods
+ (id)overlayView
{
    OverlayView *overlayView = [[[NSBundle mainBundle] loadNibNamed:@"OverlayView" owner:nil options:nil] lastObject];
    // make sure customView is not nil or the wrong class!
    
    if ([overlayView isKindOfClass:[OverlayView class]])
        return overlayView;
    else
        return nil;
}

#pragma mark - Observer Methods
-(void) showHelpView:(NSNotification *) notification    {
    if ([[notification name] isEqualToString:@"helpOverlayView"]) {
        self.internalHelpView.alpha = 1;
    } else  {
        self.internalHelpView.alpha = 0;
    }
}


-(void) setupObserver   {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showHelpView:) name:@"helpOverlayView" object:nil];
    
}

@end
