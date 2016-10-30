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

#import "FilterViewController.h"
#import "WebService.h"
#import "Event.h"
#import "Data.h"
#import "User.h"

#import "WebService.h"
@interface EventTableViewController () <DataDelegate>

@property (nonatomic, strong) MapViewController *mapController;
@property (nonatomic, strong) CurrentUserLocation *userLocation;
@property (nonatomic) NSDictionary *tableData;

@property NSArray *myEventsDataArray;
@property NSArray *dataArray;

@end

@implementation EventTableViewController

NSArray *sectionTitles;

- (instancetype)initWithStoryboard
{
    self = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
    if (self)
    {
    }
    return self;
}

#pragma mark - UI View Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationController];
 //   [self setupDummyData];
    [self setupTable];
    
 //   [[WebService sharedInstance]eventsApiRequest:EVENT_API_ALL];
    //  [Data sharedInstance].eventsArray = [NSMutableArray new];
    // By default, isHallsSwitchOn = 1 as when it passed by the observer for the FilterTableViewCell it comes actiavted and I couldn't find a way to pass a value via an observer
    _dataArray = [NSArray new];
    _myEventsDataArray = [NSArray new];
    
    
   // [self refreshEventsData];

}


-(void)viewWillAppear:(BOOL)animated  {
    [Data sharedInstance].delegate = self;
    [self setupObservers];

    
       if (!_mapController) {
        _mapController = [[MapViewController alloc] init];
    }
    if(!_userLocation)
    {
        _userLocation =[[CurrentUserLocation alloc] init];
    }
 //   [self refreshEventsData];
  //  [[WebService sharedInstance]events];
    [[WebService sharedInstance]eventsApiRequest:EVENT_API_ALL];
    NSLog(@"dsdsddsdsdsdz");
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [Data sharedInstance].delegate = nil;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)eventsDownloadedSuccessfully
{
    _myEventsDataArray = [Data sharedInstance].myEventsArray;
    _dataArray = [Data sharedInstance].eventsArray;
    [self.tableView reloadData];

    [self performSelectorOnMainThread:@selector(handleUpdates) withObject:nil waitUntilDone:YES];
}
/*
- (void)receivedNotification:(NSNotification *) notification {
    if ([[notification name] isEqualToString:[NSString stringWithFormat:@"Respose%li",(long)EVENT_API_ALL]]) {
        [self handleUpdates];
    }
}
*/

-(void)avatarDownloaded
{
    
    NSLog(@"EVENT TV AVATAR DOWNLOADED");
    [self performSelectorOnMainThread:@selector(refreshCellInputViews) withObject:nil waitUntilDone:YES];
}


-(void)refreshCellInputViews
{
    NSLog(@"EVENT TV AVATAR RELOAD INPUT VIEWS");
    [self.tableView reloadData];
   // [self.tableView reloadInputViews];
}

-(void)updatedJoinStatus
{
   // [self refreshEventsData];
   // [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];

}

-(void)refreshEventsData
{
    [[WebService sharedInstance]eventsApiRequest:EVENT_API_ALL];
}

-(void)handleUpdates
{

    
    [self.tableView reloadInputViews];

   // [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
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
        
        [Data sharedInstance].selectedEvent = notification.object;
        
                [Data sharedInstance].selectedEventID = [NSString stringWithFormat:@"%i", [Data sharedInstance].selectedEvent.eventID];
        [self moveToOtherUserProfile];
    }
}

-(void)moveToEdit:(NSNotification *) notification   {
    if ([[notification name] isEqualToString:@"Edit Found"]) {
        [Data sharedInstance].selectedEvent = notification.object;
        [Data sharedInstance].selectedEventID = [NSString stringWithFormat:@"%i", [Data sharedInstance].selectedEvent.eventID];
        [self moveToEdit];
    }
}

-(void)moveToEvent:(NSNotification *) notification  {
    if ([[notification name] isEqualToString:@"People Event"])  {
        NSLog(@"Moving to Event related to People");
        [Data sharedInstance].selectedEvent = notification.object;
              [Data sharedInstance].selectedEventID = [NSString stringWithFormat:@"%i", [Data sharedInstance].selectedEvent.eventID];
        [self moveToEvent];
    }
}



-(void) commentsButton:(NSNotification *) notification    {
    if ([[notification name] isEqualToString:@"Comments"]) {
        [Data sharedInstance].selectedEvent = notification.object;
  [Data sharedInstance].selectedEventID = [NSString stringWithFormat:@"%i", [Data sharedInstance].selectedEvent.eventID];
        [self moveToComments];
    }
}

/*
 
 -(void)joinedButton:(NSNotification *) notification {
 if ([[notification name] isEqualToString:@"Joined"]) {
 NSLog(@"NOTIFICATION DATA = %@", notification);
 [Data sharedInstance].selectedEvent = notification.object;
 [Data sharedInstance].selectedEventID = [NSString stringWithFormat:@"%i", [Data sharedInstance].selectedEvent.eventID];
 [[WebService sharedInstance]eventsApiRequest:EVENT_API_JOIN];
 NSLog(@"Joined logic needs to be added here similar to collection cell");
 }
 }
-(void)joinedStatusUpdatedSuccessfully
{
  //  [self performSelector:@selector(refreshEventsData) withObject:nil afterDelay:1.0 inModes:@[]];
    [[WebService sharedInstance]eventsApiRequest:EVENT_API_ALL];
    
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    
    NSLog(@"DATATxxxx RELOAD");
}
*/

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

-(void) setupNavigationController   {
    
    UIImage *image = [UIImage imageNamed:@"title-bar-logo"];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:image];
}

/** Segue to another viewController */
-(void) moveToOtherUserProfile  {
    [self performSegueWithIdentifier:@"GoToOtherUserProfile" sender:self];
}

-(void)moveToFilter {
    if(![self.navigationController.topViewController isKindOfClass:[FilterViewController class]]) {
        [self performSegueWithIdentifier:@"GoToFilter" sender:self];
    }
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

/*
-(void) setupDummyData  {
    //Dummy Data
    _tableData = @{@"My Events" : @[@"Andy Jones"],
                   @"Events Near Me" : @[@"Jennifer Cooper", @"Nathan Barnes"]};
    NSSortDescriptor *decending = [[NSSortDescriptor alloc] initWithKey:@"self" ascending:NO];
    NSArray *decendingOrder = [NSArray arrayWithObject:decending];
    sectionTitles = [[_tableData allKeys] sortedArrayUsingDescriptors:decendingOrder];
}*/

-(void) setupTable  {
    self.tableView.allowsSelectionDuringEditing=YES;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 140;
    NSSortDescriptor *decending = [[NSSortDescriptor alloc] initWithKey:@"self" ascending:NO];
    
    NSArray *decendingOrder = [NSArray arrayWithObject:decending];
  //  sectionTitles = @[@"My Events", @"Events Near Me"];
    //    self.tableView.allowsSelection = NO;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if ([_myEventsDataArray count] > 0)
    {
        return 2;
    }
    
    return 1;
    
    return [sectionTitles count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    


    switch (section) {
        case 0:
            if ([_myEventsDataArray count] > 0)
            {
                return [_myEventsDataArray count];
            }
            return [_dataArray count];
            break;
        case 1:
            return [_dataArray count];
            break;
        default:
            return 0;
            break;
    }
    
    return 1;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    return [self headerCellAtIndex:section];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section    {
    
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return [self eventCellAtIndex:indexPath];
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 10)];
    view.backgroundColor = [UIColor clearColor];
    return view;
    
    return [self footerCellAtIndex:section];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section    {
    
    //Forced the Footer to conform to a specific height that is equal to the header space between the cell
    return 14;
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
    
    NSString *sectionTitle = @"EVENTS NEAR ME";
    if ([_myEventsDataArray count] > 0 && section == 0)
    {
        sectionTitle = @"MY EVENTS";
        [cell.filterButton setHidden:YES];
        [cell.numberOfEventsLabel setHidden:YES];
    }
    else
    {
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
    

    [cell configureCellWithEventForTableView:self.tableView atIndexPath:indexPath];
    
    return cell;
}


#pragma mark - Actions
- (IBAction)peopleButtonPressed:(UIBarButtonItem *)sender {
    NSLog(@"People Button Pressed");
    
}

@end
