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
    
    NSDictionary *attributes = [ViewSetupHelper setNavigationButtonFontAndSize];

    [_cancelButton setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
}

#pragma mark - Action Methods

- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender {
//    [self.navigationController popViewControllerAnimated:YES];
    [self popViewControllerNumberOftimes:3];
}

- (IBAction)deleteButtonPressed:(UIButton *)sender {
    NSLog(@"confirm delete Button Pressed");
}

-(void) popViewControllerNumberOftimes: (int) times    {
    NSInteger noOfViewControllers = [self.navigationController.viewControllers count];
    [self.navigationController
     popToViewController:[self.navigationController.viewControllers
                          objectAtIndex:(noOfViewControllers-times)] animated:YES];
}
@end
