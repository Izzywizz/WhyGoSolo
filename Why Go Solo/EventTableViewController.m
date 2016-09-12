//
//  EventTableViewController.m
//  UnderstandingAddingMapAnnotations
//
//  Created by Izzy on 02/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "EventTableViewController.h"

#import "EventsTableViewCell.h"
#import "HeaderEventsTableViewCell.h"
#import "FooterEventsTableViewCell.h"

#import "MapViewController.h"
#import "CurrentUserLocation.h"

@interface EventTableViewController ()

@property (nonatomic, strong) MapViewController *mapController;
@property (nonatomic, strong) CurrentUserLocation *userLocation;

@end

@implementation EventTableViewController
NSDictionary *tableData;
NSArray *sectionTitles;

#pragma mark - UI View Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDummyData];
    [self setupTable];
    [self ListenOutProfileBeingPressed];

}



-(void)viewWillAppear:(BOOL)animated  {
    _mapController = [[MapViewController alloc] init];
    _userLocation =[[CurrentUserLocation alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Observer Methods

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

#pragma mark - Helper Functions

-(void) moveToOtherUserProfile  {
    [self performSegueWithIdentifier:@"GoToOtherUserProfile" sender:self];
}

-(void) setupDummyData  {
    //Dummy Data
    tableData = @{@"My Events" : @[@"Andy Jones"],
                  @"Events Near Me" : @[@"Jennifer Cooper", @"Nathan Barnes"]};
    NSSortDescriptor *decending = [[NSSortDescriptor alloc] initWithKey:@"self" ascending:NO];
    NSArray *decendingOrder = [NSArray arrayWithObject:decending];
    sectionTitles = [[tableData allKeys] sortedArrayUsingDescriptors:decendingOrder];
}

-(void) setupTable  {
    self.tableView.allowsSelectionDuringEditing=YES;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 140;
//    self.tableView.allowsSelection = NO;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [sectionTitles count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    NSString *sectionTitle = [sectionTitles objectAtIndex:section];
    NSArray *sectionEvents = [tableData objectForKey:sectionTitle];
    return [sectionEvents count];
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return [self headerCellAtIndex:section];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section    {
    
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    if (cell == nil) {
    //        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options: nil];
    //        cell = [nib objectAtIndex:0];
    //    }
    
    return [self eventCellAtIndex:indexPath];
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [self footerCellAtIndex:section];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section    {
    
    //Forced the Footer to conform to a specific height that is equal to the header space between the cell
    return 15;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"Bring up maps!: row: %ld, section: %ld", (long)indexPath.row, (long)indexPath.section);
    [self performSegueWithIdentifier:@"GoToMap" sender:self];
}


#pragma mark - Custom Cells
-(HeaderEventsTableViewCell *) headerCellAtIndex:(NSInteger) section  {
    
    NSString *resuseID = @"HeaderEventsCell";
    NSString *nibName = @"HeaderEvents";
    
    [self.tableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:resuseID];
    HeaderEventsTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:resuseID];
    
    NSString *sectionTitle = [sectionTitles objectAtIndex:section];
    
    if ([sectionTitle  isEqual: @"My Events"]) {
        [cell.filterButton setHidden:YES];
        [cell.numberOfEventsLabel setHidden:YES];
    } else {
        [cell.numberOfEventsLabel setHidden:YES];
    }
    cell.MyEventsLabel.text = sectionTitle;
    
    return cell;
}

-(FooterEventsTableViewCell *) footerCellAtIndex:(NSInteger) section    {
    
    NSString *resuseID = @"FooterEventsCell";
    NSString *nibName = @"FooterEvents";
    
    [self.tableView registerNib: [UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:resuseID];
    FooterEventsTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:resuseID];
    
    return cell;
}

-(EventsTableViewCell *) eventCellAtIndex: (NSIndexPath *) indexPath {
    
    NSString *reuseID = @"EventsTableViewCell";
    NSString *nibName = @"Events";
    
    [self.tableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:reuseID];
    EventsTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:reuseID forIndexPath:indexPath];
    
    //Setup cell using data pull down from the server, this is using dummy data
    NSString *sectionTitle = [sectionTitles objectAtIndex:indexPath.section];
    NSArray *sectionEvents = [tableData objectForKey:sectionTitle];
    NSString *eventName = [sectionEvents objectAtIndex:indexPath.row];
    
    //Basic logic to ensure that the correct join/ edit are displayed for events
    if ([sectionTitle isEqualToString:@"My Events"]) {
        [cell viewWithTag:JOIN].alpha = 0;
    } else  {
        [cell viewWithTag:EDIT].alpha = 0; // Edit is hidden
    }
    
    cell.timeLabel.hidden = YES;
    cell.nameLabel.text = eventName;
    //    cell.eventEmoticonLabel.text = @"\ue057"; //pass the emoticon in unicode 6.0 +
    
    return cell;
}


#pragma mark - Actions
- (IBAction)peopleButtonPressed:(UIBarButtonItem *)sender {
    NSLog(@"People Button Pressed");

}

- (IBAction)testButton:(id)sender {
    [self moveToOtherUserProfile];
}


@end
