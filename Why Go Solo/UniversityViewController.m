//
//  UniversityViewController.m
//  Why Go Solo
//
//  Created by Izzy on 14/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "UniversityViewController.h"
#import "UniversityLocations.h"


@interface UniversityViewController () <UITableViewDelegate, UITableViewDataSource>
@property NSArray *universityList;
@property (nonatomic) UniversityLocations *locations;
@property BOOL hasUniBeenSelected;

@end

@implementation UniversityViewController

#pragma mark - UI Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    self.hasUniBeenSelected = false; //intially set selction false becasue nothing has been selected!
    
    _locations = [[UniversityLocations alloc] init];
    [self unpackData];
    NSLog(@"University");
    _universityList = [self unpackData];
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

-(NSArray *) unpackData  {
    NSDictionary *dict = [[NSDictionary alloc] init];
    dict = [_locations returnListOfUniversity];
    
    NSArray *liverpoolArray = [[NSArray alloc] init];
    liverpoolArray =[dict valueForKey:@"Liverpool"];
    
    return liverpoolArray;
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
    
    cell.textLabel.text = [_universityList objectAtIndex:indexPath.row];
    
    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    self.hasUniBeenSelected = true;
    if (_hasUniBeenSelected) {
        NSLog(@"row: %ld, section: %ld", (long)indexPath.row, (long)indexPath.section);
        NSLog(@"Location: %@,", [_universityList objectAtIndex:indexPath.row]);
        [tableView cellForRowAtIndexPath:indexPath].accessoryView =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"check-button-20-20"]];
    }
}

-(void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath   {
    [tableView cellForRowAtIndexPath:indexPath].accessoryView = UITableViewCellAccessoryNone;
}

#pragma mark - Action Methods

- (IBAction)backButtonPressed:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)nextButtonPressed:(UIBarButtonItem *)sender {
    NSLog(@"Next button pressed");
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
