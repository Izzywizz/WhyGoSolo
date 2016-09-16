//
//  SignInTableViewController.m
//  Why Go Solo
//
//  Created by Izzy on 16/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "SignInTableViewController.h"

@interface SignInTableViewController ()
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UITextField *emailInputField;
@property (weak, nonatomic) IBOutlet UIView *emailContentView;
@property (weak, nonatomic) IBOutlet UIView *passwordContentView;

/**
 Use the container view for each tableView cell and set the constraints of the view to 1 top/botom but 0 on the others
 make a reference to that specifc container like emailContentView
 */

@end

@implementation SignInTableViewController

#pragma mark - UI Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"SignIn Table VC");
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero]; // Prevents the tableView from drawing any more empty unused cell
    self.tableView.allowsSelection = NO; //becare this may disable button interaction.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action Methods

- (IBAction)backButtonPressed:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//TODO: Need tro validation propery for email and changing the colour of the selction inserts
- (IBAction)signinButtonPressed:(UIButton *)sender {
    NSLog(@"Sign In Button");
    if ([_emailInputField.text isEqualToString:@""] || _emailInputField == nil) {
        NSLog(@"EMpty");
        _emailLabel.textColor = [UIColor redColor];
        
        NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"Enter your email address" attributes:@{ NSForegroundColorAttributeName : [UIColor redColor] }];
        self.emailInputField.attributedPlaceholder = str;
        
//        [self.tableView setSeparatorColor:[UIColor redColor]];
        _emailContentView.backgroundColor = [UIColor redColor];
    }
}

- (IBAction)forgotButtonPressed:(UIButton *)sender {
    NSLog(@"Forgot Button");
}


#pragma mark - Helper Functions
/** Ensures that the selection seperators are setup before the main views are shown*/
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark - Table view data source

/** Allows the cell selection seperators (the grey line across the tableView Cell) to extend across the entire table view */
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

//** Creates a empty header but of the same colour stated in th design*/
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,tableView.frame.size.width,30)];
    
    [headerView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return  60.0;
}


@end
