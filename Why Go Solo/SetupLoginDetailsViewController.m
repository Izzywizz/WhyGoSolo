//
//  SetupLoginDetailsViewController.m
//  Why Go Solo
//
//  Created by Izzy on 14/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "SetupLoginDetailsViewController.h"

@interface SetupLoginDetailsViewController ()

@end

@implementation SetupLoginDetailsViewController

#pragma mark - UI Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationButtonFontAndSize];
    NSLog(@"Setup Login Details");
        // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helper Functions
-(void) setNavigationButtonFontAndSize  {
    
    NSUInteger size = 12;
    NSString *fontName = @"Lato";
    UIFont *font = [UIFont fontWithName:fontName size:size];
    NSDictionary * attributes = @{NSFontAttributeName: font};
    [_nextButton setTitleTextAttributes:attributes forState:UIControlStateNormal];
}

#pragma mark - Actions Methods
- (IBAction)backbuttonPressed:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)termsAndConditionButtonPressed:(UIButton *)sender {
    NSLog(@"Activate Terms and condtion");
}

- (IBAction)nextButtonPressed:(UIBarButtonItem *)sender {
}

@end
