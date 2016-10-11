//
//  SetupLoginDetailsViewController.h
//  Why Go Solo
//
//  Created by Izzy on 14/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FontSetup.h"

@interface SetupLoginDetailsViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextButton;
@property BOOL hasTermsAgreed;

@property (weak, nonatomic) IBOutlet UITextField *emailAddressTextField;
@property (weak, nonatomic) IBOutlet UILabel *emailAddressLabel;
@property (weak, nonatomic) IBOutlet UIView *emailContentView;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIView *passwordContentView;
@property (weak, nonatomic) IBOutlet UILabel *passwordLabel;

@property (weak, nonatomic) IBOutlet UIView *confirmPasswordContentView;
@property (weak, nonatomic) IBOutlet UILabel *confirmPasswordLabel;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;

@end
