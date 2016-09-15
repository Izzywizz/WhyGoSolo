//
//  TermsViewController.m
//  Why Go Solo
//
//  Created by Izzy on 15/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "TermsViewController.h"

@interface TermsViewController ()
@property (weak, nonatomic) IBOutlet UITextView *termsTextView;

@end

@implementation TermsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _viewLayer.layer.cornerRadius = 5;
    [self.termsTextView setContentOffset:CGPointZero];
}

-(void)viewWillAppear:(BOOL)animated    {
    [self.termsTextView setContentOffset:CGPointZero animated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)backButtonPressed:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
