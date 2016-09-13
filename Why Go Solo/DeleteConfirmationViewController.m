//
//  DeleteConfirmationViewController.m
//  Why Go Solo
//
//  Created by Izzy on 13/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "DeleteConfirmationViewController.h"

@interface DeleteConfirmationViewController ()

@end

@implementation DeleteConfirmationViewController

#pragma mark - UI View Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationButtonFontAndSize];
    _deleteButton.layer.cornerRadius = 5;
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
    [_cancelButton setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
}

#pragma mark - Action Methods

- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)deleteButtonPressed:(UIButton *)sender {
    NSLog(@"Delete Button Pressed");
}

@end
