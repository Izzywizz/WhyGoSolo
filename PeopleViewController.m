//
//  PeopleViewController.m
//  Why Go Solo
//
//  Created by Izzy on 12/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "PeopleViewController.h"
#import "HeaderEventsTableViewCell.h"
#import "PeopleEventTableViewCell.h"
#import "FooterEventsTableViewCell.h"
#import "PeopleNotAttendingTableViewCell.h"
#import "AlternateProfileTableViewController.h"

@interface PeopleViewController () <UITableViewDelegate, UITableViewDataSource>

@property NSDictionary *tableData;
@property NSArray *sectionTitles;

@property BOOL isFriendsSelected;
@end

@implementation PeopleViewController

#pragma mark - UI View Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTable];
    [self setupDummyData];
    [self initialButtonSetup];
    [self ListenOutProfileBeingPressed];
    [self setNavigationButtonFontAndSize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helper Functions


-(void) setNavigationButtonFontAndSize  {
    
    NSDictionary *attributes = [ViewSetupHelper setNavigationButtonFontAndSize];
    [_profileButton setTitleTextAttributes:attributes forState:UIControlStateNormal];
}

- (void)receivedNotification:(NSNotification *) notification {
    if ([[notification name] isEqualToString:@"Profile Found"]) {
        [self moveToOtherUserProfile];
    }
}

-(void) ListenOutProfileBeingPressed    {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivedNotification:)
                                                 name:@"Profile Found"
                                               object:nil];
}

-(void) moveToOtherUserProfile  {
    //Prevents the app from showing the viewController twice, also changing the fileName helps with this problem
    if(![self.navigationController.topViewController isKindOfClass:[AlternateProfileTableViewController class]]) {
        UIViewController* infoController = [self.storyboard instantiateViewControllerWithIdentifier:@"AlternateProfileTableViewController"];
        [self.navigationController pushViewController:infoController animated:YES];
    }
}

-(void) setupTable  {
    self.tableView.allowsSelectionDuringEditing = YES;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    //    self.tableView.allowsSelection = NO;
}

-(void) initialButtonSetup  {
    _isFriendsSelected = YES;
    [_everyoneButton setBackgroundColor:[UIColor lightGrayColor]];
    _everyoneButton.tintColor = [UIColor grayColor];
}

-(void) setupDummyData  {
    //Dummy Data
    _tableData = @{@"ATTENDING EVENTS" : @[@"Patrick", @"Steven", @"Philipe"],
                   @"NOT ATTENDING EVENTS" : @[@"Nathan Barnes", @"Izzy Ali"]};
    
    NSSortDescriptor *ascending = [[NSSortDescriptor alloc] initWithKey:@"self" ascending:YES];
    NSArray *ascendingOrder = [NSArray arrayWithObject:ascending];
    _sectionTitles = [[_tableData allKeys] sortedArrayUsingDescriptors:ascendingOrder];
}

#pragma mark - Table View Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_sectionTitles count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    NSString *sectionTitle = [_sectionTitles objectAtIndex:section];
    NSArray *sectionEvents = [_tableData objectForKey:sectionTitle];
    return [sectionEvents count];
}

//Custom Height View
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return [self headerCellAtIndex:section];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section    {
    
    return 40;
}

//Custom Footer View
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [self footerCellAtIndex:section];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section    {
    
    //Forced the Footer to conform to a specific height that is equal to the header space between the cell
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
//    NSString *sectionTitle = [_sectionTitles objectAtIndex:indexPath.section];
    if (indexPath.section == 1) {
        return [self eventNotAttendingCellAtIndex: indexPath];
    } else 
    return [self eventCellAtIndex:indexPath];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"Bring up maps!: row: %ld, section: %ld", (long)indexPath.row, (long)indexPath.section);
}

#pragma mark - Custom Cells
-(HeaderEventsTableViewCell *) headerCellAtIndex:(NSInteger) section  {
    
    NSString *resuseID = @"HeaderEventsCell";
    NSString *nibName = @"HeaderEvents";
    
    [self.tableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:resuseID];
    HeaderEventsTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:resuseID];
    
    NSString *sectionTitle = [_sectionTitles objectAtIndex:section];
    
    cell.MyEventsLabel.text = sectionTitle;
    cell.filterButton.hidden = YES;
    cell.numberOfEventsLabel.hidden = YES;
    
    
    return cell;
}

-(PeopleNotAttendingTableViewCell*) eventNotAttendingCellAtIndex: (NSIndexPath *) indexPath {
    
    NSString *reuseID = @"PeopleEventsTableViewCell";
    NSString *nibName = @"PeopleNotAttending";
    
    [self.tableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:reuseID];
    PeopleNotAttendingTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:reuseID forIndexPath:indexPath];
    
    cell.profileName.text = @"Isfandyar";
    
    return cell;
}

-(PeopleEventTableViewCell *) eventCellAtIndex: (NSIndexPath *) indexPath {
    
    NSString *reuseID = @"PeopleEventsTableViewCell";
    NSString *nibName = @"PeopleEvent";
    
    [self.tableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:reuseID];
    PeopleEventTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:reuseID forIndexPath:indexPath];
    
    //Setup cell using data pull down from the server, this is using dummy data
    NSString *sectionTitle = [_sectionTitles objectAtIndex:indexPath.section];
    NSArray *sectionEvents = [_tableData objectForKey:sectionTitle];
    NSString *personName = [sectionEvents objectAtIndex:indexPath.row];
    
    cell.nameLabel.text = personName;
    
    return cell;
}

-(FooterEventsTableViewCell *) footerCellAtIndex:(NSInteger) section    {
    
    NSString *resuseID = @"FooterEventsCell";
    NSString *nibName = @"FooterEvents";
    
    [self.tableView registerNib: [UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:resuseID];
    FooterEventsTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:resuseID];
    
    return cell;
}

#pragma mark - Action Methods
- (IBAction)backButtonPressed:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)friendsButtonPressed:(UIButton *)sender {
    if (_isFriendsSelected) {
        NSLog(@"Friends");
        [_friendsButton setBackgroundColor:[UIColor whiteColor]];
        [_everyoneButton setBackgroundColor:[UIColor lightGrayColor]];
        _everyoneButton.tintColor = [UIColor grayColor];
        _isFriendsSelected = NO;
    }
}

- (IBAction)everyoneButtonPressed:(UIButton *)sender {
    _isFriendsSelected = NO;
    if (_isFriendsSelected == NO) {
        NSLog(@"Everyone");
        [_everyoneButton setBackgroundColor:[UIColor whiteColor]];
        [_friendsButton setBackgroundColor:[UIColor lightGrayColor]];
        _friendsButton.tintColor = [UIColor grayColor];
        _isFriendsSelected = YES;
    }
}

@end
