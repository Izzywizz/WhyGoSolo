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
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

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

- (IBAction)termsAndConditionButtonPressed:(UIButton *)sender {
    NSLog(@"Activate Terms and condtion");
}
- (IBAction)nextButtonPressed:(UIBarButtonItem *)sender {
    NSLog(@"Next Button Pressed");
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    NSLog(@"row: %ld, section: %ld", (long)indexPath.row, (long)indexPath.section);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

     UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,tableView.frame.size.width,30)];
    
    [headerView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return  30.0;
}

@end
