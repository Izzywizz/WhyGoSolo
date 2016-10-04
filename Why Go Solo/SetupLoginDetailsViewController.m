//
//  SetupLoginDetailsViewController.m
//  Why Go Solo
//
//  Created by Izzy on 14/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "SetupLoginDetailsViewController.h"

@interface SetupLoginDetailsViewController ()

//email/ password/ confrim password validation
@property (weak, nonatomic) IBOutlet UITextField *emailAddress;
@property (weak, nonatomic) IBOutlet UILabel *emailAddressLabel;
@property (weak, nonatomic) IBOutlet UIView *emailContentView;


@end

@implementation SetupLoginDetailsViewController

#pragma mark - UI Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationButtonFontAndSize];
    self.hasTermsAgreed = false;
    
    //This prevents the weird the selection animation occuring when the user selects a cell
    [self.tableView setAllowsSelection:NO];

    
    NSLog(@"Setup Login Details");
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helper Functions
-(void) setNavigationButtonFontAndSize  {
    
    NSDictionary *attributes = [FontSetup setNavigationButtonFontAndSize];
    
    [_nextButton setTitleTextAttributes:attributes forState:UIControlStateNormal];
}

-(void) setupTable  {
    self.tableView.allowsSelectionDuringEditing=YES;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 66;
//    self.tableView.allowsSelection = NO;
}


/** Ensures that the selection seperators are setup before the  main views are shown*/
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

#pragma mark - Actions Methods
- (IBAction)backbuttonPressed:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)nextButtonPressed:(UIBarButtonItem *)sender {
    
    if ([_emailAddress.text isEqualToString:@""] || _emailAddress == nil) {
        UIColor *colour = [UIColor redColor];

        _emailContentView.backgroundColor = colour;
        _emailAddressLabel.textColor = colour;
        _emailAddress.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter your University Address" attributes:@{NSForegroundColorAttributeName: colour}];

    }

    if (_hasTermsAgreed) {
        [self performSegueWithIdentifier:@"GoToProfile" sender:self];
    } else {
        [self alertSetupandView:@"Terms" andMessage:@"Please read and agree to the terms"];
    }
}

- (IBAction)termsAgreed:(UISwitch *)sender {
    self.hasTermsAgreed = false; //intially the switch is false

    if (sender.on) {
        self.hasTermsAgreed = true;
    } else {
        self.hasTermsAgreed = false;
    }
}

#pragma mark - Table view data source

/** Allows the cell selection seperators (the grey line across the tableView Cell) to extend across the entire table view */
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 3) {
        cell.separatorInset = UIEdgeInsetsMake(0, 1000, 0, 0); //removes insert
    }
    else  {
        [cell setSeparatorInset:UIEdgeInsetsZero];
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark - TableView Delegates

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    NSLog(@"row: %ld, section: %ld", (long)indexPath.row, (long)indexPath.section);
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; //remove the selection animation
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,tableView.frame.size.width,30)];
    
    [headerView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return  30.0;
}

#pragma mark - Alert View Controller

-(void) alertSetupandView: (NSString *) WithTitle andMessage: (NSString *) message  {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:WithTitle message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *dismiss = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Dismiss");
    }];
    [alertVC addAction:dismiss];
    [self presentViewController:alertVC animated:YES completion:nil];
}

@end
