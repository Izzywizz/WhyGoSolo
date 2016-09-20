//
//  FilterViewController.m
//  Why Go Solo
//
//  Created by Izzy on 19/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "FilterViewController.h"

@interface FilterViewController ()
@property (weak, nonatomic) IBOutlet UILabel *testLabel;

@end

@implementation FilterViewController

#pragma mark - UI View Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Filter View Activated!");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helper Functions
-(void) setNavigationButtonFontAndSize  {
    
    NSDictionary *attributes = [FontSetup setNavigationButtonFontAndSize];
    
    [_applyButton setTitleTextAttributes:attributes forState:UIControlStateNormal];
}

#pragma mark - Action Methods

- (IBAction)backButtonPressed:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)applyButtonPressed:(UIBarButtonItem *)sender {
    NSLog(@"apply");
}

- (IBAction)sliderValueTest:(UISlider *)sender {
    int sliderValue;
    NSLog(@"Value: %d", (int) sender.value);
    sliderValue = (int) sender.value;
    _testLabel.text = [NSString stringWithFormat:@"%d", sliderValue];
}

@end
