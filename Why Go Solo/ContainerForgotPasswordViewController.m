//
//  ContainerForgotPasswordViewController.m
//  Why Go Solo
//
//  Created by Izzy on 19/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "ContainerForgotPasswordViewController.h"

@interface ContainerForgotPasswordViewController ()
@property (weak, nonatomic) IBOutlet UIView *overlayView;
@property (weak, nonatomic) IBOutlet UIView *internalView;

@end

@implementation ContainerForgotPasswordViewController

#pragma mark - UI View Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self forgotOverlayAlpha:0 animationDuration:0.0];
    self.internalView.layer.cornerRadius = 5;
    [self ListenOutPasswordResetButtonPressed];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Helper Functions

-(void)forgotOverlayAlpha:(int)a animationDuration:(float)duration
{
    [UIView animateWithDuration:duration delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        for (id x in _overlayView.subviews)
        {
            if ([x class] == [UIView class])
            {
                [(UIView*)x setAlpha:a];
            }
        }
        _overlayView.alpha = a;
    } completion:nil];
}


#pragma mark - Action Method

- (IBAction)backButtonPressed:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)okButtonPressed:(UIButton *)sender {
    NSLog(@"Email has been sent for password reset");
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Observer Methods
- (void)receivedNotification:(NSNotification *) notification {
    if ([[notification name] isEqualToString:@"passwordReset"]) {
        [self.view endEditing:YES];//remove keyborad
        [self forgotOverlayAlpha:1 animationDuration:0.2f];
    }
}

-(void) ListenOutPasswordResetButtonPressed    {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivedNotification:)
                                                 name:@"passwordReset"
                                               object:nil];
}

@end
