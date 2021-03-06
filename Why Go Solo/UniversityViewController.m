//
//  UniversityViewController.m
//  Why Go Solo
//
//  Created by Izzy on 14/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "UniversityViewController.h"
#import "UniversityLocations.h"
#import "WebService.h"
#import "Data.h"
#import "University.h"
#import "Residence.h"
#import "RRRegistration.h"


@interface UniversityViewController () <UITableViewDelegate, UITableViewDataSource, DataDelegate>
@property NSArray *universityList;
@property (nonatomic) UniversityLocations *locations;
@property BOOL hasUniBeenSelected;

@property int selectedIndex;

@end

@implementation UniversityViewController

-(void)viewWillAppear:(BOOL)animated
{
    [[WebService sharedInstance]universities];
    [Data sharedInstance].delegate = self; // Set Data delegate
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [Data sharedInstance].delegate = nil; // Remove Data delegate
}

-(void)universitiesDownloadedSuccessfully // Data protocol response method
{
    [self performSelectorOnMainThread:@selector(handleUpdates) withObject:nil waitUntilDone:YES];
    // Need to set to main thread as this is currently running on a background thread
}

-(void)handleUpdates
{
    _universityList = [[NSArray alloc]initWithArray:[Data sharedInstance].universitesArray];
    [_tableView reloadData];
}

#pragma mark - UI Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    _locations = [[UniversityLocations alloc] init];
    self.hasUniBeenSelected = false; //intially set selction false becasue nothing has been selected!
    
    NSLog(@"University");
    //  _universityList = [self unpackData];
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

/** Ensures that the selection seperators are setup before the main views are shown*/
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self setNavigationButtonFontAndSize];
    
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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _universityList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"universityCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if(cell == nil )
    {
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    University *uni = [_universityList objectAtIndex:indexPath.row];
    
    cell.textLabel.text = uni.universityName;
    
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    
    if (_selectedIndex == indexPath.row &&  _hasUniBeenSelected == YES)
    {
        
        cell.accessoryView =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"check-button-20-20"]];
        NSLog(@"SELECTED %i", indexPath.row);
    }
    else
    {
        cell.accessoryView =  [[UIImageView alloc] initWithImage:[UIImage new]];
    }
    
    
    [tableView reloadInputViews];
    
    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    NSLog(@"row: %ld, section: %ld", (long)indexPath.row, (long)indexPath.section);
    NSLog(@"Location: %@,", [_universityList objectAtIndex:indexPath.row]);
    _hasUniBeenSelected = YES;
    _selectedIndex = indexPath.row;
    
   
    
    [Data sharedInstance].selectedUniversity = [_universityList objectAtIndex:indexPath.row];
    
    [RRRegistration sharedInstance].universityID = [Data sharedInstance].selectedUniversity.universityID;
    [tableView reloadData];
    
    return;
    
}

-(void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath   {
    [tableView cellForRowAtIndexPath:indexPath].accessoryView = UITableViewCellAccessoryNone;
}

#pragma mark - Action Methods

- (IBAction)backButtonPressed:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)nextButtonPressed:(UIBarButtonItem *)sender {
    NSLog(@"Next button pressed: %@", [Data sharedInstance].selectedUniversity.universityName);
    if (_hasUniBeenSelected == false) {
        [self alertSetupandView];
    } else  {
        [self performSegueWithIdentifier:@"GoToSetupLoginDetails" sender:self];
    }
}

-(void) alertSetupandView  {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"No Uni Selected" message:@"Please select a university before proceededing" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *dismiss = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Dismiss");
    }];
    [alertVC addAction:dismiss];
    [self presentViewController:alertVC animated:YES completion:nil];
}


@end
