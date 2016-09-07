//
//  ViewController.m
//  Why Go Solo
//
//  Created by Izzy on 07/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *topBorderView;
@property (weak, nonatomic) IBOutlet UIView *middleBorderView;
@property (weak, nonatomic) IBOutlet UILabel *emailAddressLabel;
@property (weak, nonatomic) IBOutlet UITextField *emailInputField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    _test.textColor = [UIColor redColor];
//    _topView.backgroundColor = [UIColor redColor];
    NSLog(@"Test Two");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
