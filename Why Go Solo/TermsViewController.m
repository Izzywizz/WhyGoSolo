//
//  TermsViewController.m
//  Why Go Solo
//
//  Created by Izzy on 15/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "TermsViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface TermsViewController ()
@property (weak, nonatomic) IBOutlet UITextView *termsText;

@end

@implementation TermsViewController

#pragma mark - UI Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    self.termsText.layer.cornerRadius = 5;

}

/** Lays out the subview which is the termsTextView, it */
-(void) viewDidLayoutSubviews    {
    [self.termsText setContentOffset:CGPointZero animated:NO]; //forces the scroll bar to be at the top
}
-(void)viewWillAppear:(BOOL)animated    {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helper Functions

-(void) setupTermsTextBorder  {
    [[self.termsText layer] setBorderColor:[[UIColor grayColor] CGColor]];
    [[self.termsText layer] setBorderWidth:1.0];
    [[self.termsText layer] setCornerRadius:5];
}

#pragma mark - Action Methods
- (IBAction)backButtonPressed:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
