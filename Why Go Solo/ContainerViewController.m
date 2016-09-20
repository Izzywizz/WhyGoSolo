//
//  ContainerViewController.m
//  Why Go Solo
//
//  Created by Izzy on 12/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "ContainerViewController.h"

@interface ContainerViewController ()

@end

@implementation ContainerViewController

#pragma mark - UI Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Container activated");
    [self setNavigationButtonFontAndSize];
    [self overlayAndDeleteButtonSetup];
}

-(void) viewWillAppear:(BOOL)animated   {
    [self deleteOverlayAlpha:0 animationDuration:0.0f]; //Hide the overlay
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helper Functions
-(void)deleteOverlayAlpha:(int)a animationDuration:(float)duration
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

#pragma mark - Helper Functions
-(void) setNavigationButtonFontAndSize  {
    
    NSDictionary *attributes = [FontSetup setNavigationButtonFontAndSize];

    [_saveButton setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [_cancelButton setTitleTextAttributes:attributes forState:UIControlStateNormal];
}

-(void)overlayAndDeleteButtonSetup  {
    _deleteButton.layer.cornerRadius = 5;
    self.internalView.layer.cornerRadius = 5;
}


#pragma mark - Action Methods
- (IBAction)deleteButtonPressed:(UIButton *)sender {
    NSLog(@"Real delete button pressed");
    [self deleteOverlayAlpha:1 animationDuration:0.2f];
}

- (IBAction)noButtonPressed:(UIButton *)sender {
    [self deleteOverlayAlpha:0 animationDuration:0.0f];
}

- (IBAction)yesButtonPressed:(UIButton *)sender {
    NSLog(@"Yes button Pressed"); // Handled on the main storyboard
}
    
- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender {
    NSLog(@"Save Button Pressed"); //Functionality to be added
}

@end
