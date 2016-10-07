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
@property (nonatomic) NSDictionary *tableData;

@end

@implementation EventTableViewController

NSArray *sectionTitles;

#pragma mark - UI View Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDummyData];
    [self setupTable];
    [self setupObservers];
    
    // By default, isHallsSwitchOn = 1 as when it passed by the observer for the FilterTableViewCell it comes actiavted and I couldn't find a way to pass a value via an observer
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

/** The actual method that handles the observer that has been posted*/
- (void)moveToFilter:(NSNotification *) notification {
    if ([[notification name] isEqualToString:@"Filter Found"]) {
        NSLog(@"Filter Time");
        [self moveToFilter];
    }
    
}

- (void)profileFound:(NSNotification *) notification {
    if ([[notification name] isEqualToString:@"Profile Found"]) {
        [self moveToOtherUserProfile];
    }
}

-(void)moveToEdit:(NSNotification *) notification   {
    if ([[notification name] isEqualToString:@"Edit Found"]) {
        [self moveToEdit];
    }
}

-(void)moveToEvent:(NSNotification *) notification  {
    if ([[notification name] isEqualToString:@"People Event"])  {
        NSLog(@"Moving to Event related to People");
        [self moveToEvent];
    }
}

-(void)joinedButton:(NSNotification *) notification {
    if ([[notification name] isEqualToString:@"Joined"]) {
        NSLog(@"Joined logic needs to be added here similar to collection cell");
    }
}

-(void) commentsButton:(NSNotification *) notication    {
    if ([[notication name] isEqualToString:@"Comments"]) {
        [self moveToComments];
    }
}



-(void) setupObservers    {
    //When the profile button is pressed the observer knows it has been pressed and this actiavted the the action assiociated with it
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(profileFound:)
                                                 name:@"Profile Found"
                                               object:nil];
    //Filter button is pressed
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moveToFilter:) name:@"Filter Found" object:nil];
    
    //Edit
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moveToEdit:) name:@"Edit Found" object:nil];
    
    //People Event
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moveToEvent:) name:@"People Event" object:nil];
    
    //Joined button
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(joinedButton:) name:@"Joined" object:nil];
    
    //comments page
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(commentsButton:) name:@"Comments" object:nil];
    
}

#pragma mark - Helper Functions

/** Segue to another viewController */
-(void) moveToOtherUserProfile  {
    [self performSegueWithIdentifier:@"GoToOtherUserProfile" sender:self];
}

-(void)moveToFilter {
    [self performSegueWithIdentifier:@"GoToFilter" sender:self];
}

-(void) moveToEdit  {
    [self performSegueWithIdentifier:@"GoToEdit" sender:self];
}

-(void) moveToEvent {
    [self performSegueWithIdentifier:@"GoToEvent" sender:self];
}

-(void) moveToComments  {
    [self performSegueWithIdentifier:@"GoToComments" sender:self];
}

-(void) setupDummyData  {
    //Dummy Data
    _tableData = @{@"My Events" : @[@"Andy Jones"],
                  @"Events Near Me" : @[@"Jennifer Cooper", @"Nathan Barnes"]};
    NSSortDescriptor *decending = [[NSSortDescriptor alloc] initWithKey:@"self" ascending:NO];
    NSArray *decendingOrder = [NSArray arrayWithObject:decending];
    sectionTitles = [[_tableData allKeys] sortedArrayUsingDescriptors:decendingOrder];
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
    NSArray *sectionEvents = [_tableData objectForKey:sectionTitle];
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
    DirectionViewController *map = [self.storyboard instantiateViewControllerWithIdentifier:@"DirectionViewController"];
    map.addressToBeReverse =@"14 Paradise Street, Liverpool, Merseyside, L1 8JF";
    [self.navigationController pushViewController:map animated:YES];
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
    NSArray *sectionEvents = [_tableData objectForKey:sectionTitle];
    NSString *eventName = [sectionEvents objectAtIndex:indexPath.row];
    
    //Basic logic to ensure that the correct join/ edit are displayed for events
    if ([sectionTitle isEqualToString:@"My Events"]) {
        [cell viewWithTag:JOIN].alpha = 0;
    } else  {
        [cell viewWithTag:EDIT].alpha = 0; // Edit is hidden
    }
    
    cell.eventAddressLabel.text = @"14 Paradise Street, Liverpool, Merseyside, L1 8JF";
    cell.timeLabel.hidden = YES;
    cell.nameLabel.text = eventName;
    //    cell.eventEmoticonLabel.text = @"\ue057"; //pass the emoticon in unicode 6.0 +
    
    return cell;
}


#pragma mark - Actions
- (IBAction)peopleButtonPressed:(UIBarButtonItem *)sender {
    NSLog(@"People Button Pressed");
    
}

@end
