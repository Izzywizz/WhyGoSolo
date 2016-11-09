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

#import "Data.h"
#import "WebService.h"
#import "User.h"
#import "Event.h"

@interface PeopleViewController () <UITableViewDelegate, UITableViewDataSource, DataDelegate>

//@property NSDictionary *tableData;
//@property NSArray *sectionTitles;



@property NSArray *friendsAttendingArray;
@property NSArray *friendsNotAttendingArray;
@property NSArray *everyoneArray;

@property BOOL isFriendsSelected;

@end

@implementation PeopleViewController

#pragma mark - UI View Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTable];
  //  [self setupDummyData];
[self initialButtonSetup];
  //  [self ListenOutProfileBeingPressed];
 [self setNavigationButtonFontAndSize];
    [[WebService sharedInstance]eventsApiRequest:USER_API_PEOPLE_FRIENDS];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moveToEvent:) name:@"People Event" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moveToOtherUserProfile) name:@"Profile Found" object:nil];
    [Data sharedInstance].delegate = self;
    

  //  [[WebService sharedInstance]eventsApiRequest:USER_API_FRIENDS];
    
    

 //   _friendsNotAttendingArray = @[];
   // _friendsAttendingArray = @[];
}


-(void)viewWillDisappear:(BOOL)animated
{
    [Data sharedInstance].delegate = nil;
 //   _friendsAttendingArray = nil;
   // _friendsNotAttendingArray = nil;
 //   _everyoneArray = nil;
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)friendsParsedSuccessfully
{
    _isFriendsSelected =  YES;

    NSLog(@"Freinds Array = %@", [Data sharedInstance].friendsAttendingEventsArray);
    _isFriendsSelected =  YES;

    _friendsAttendingArray = [[NSArray alloc]initWithArray:[Data sharedInstance].friendsAttendingEventsArray];
    _friendsNotAttendingArray = [[NSArray alloc]initWithArray:[Data sharedInstance].friendsNotAttendingEventsArray];
    _everyoneArray = @[];

    
    NSLog(@"LOCAL F ATTENDING= %@", _friendsAttendingArray);
    
    NSLog(@"LOCAL F NOT ATTENDING= %@", _friendsNotAttendingArray);

    
    [self performSelectorOnMainThread:@selector(handleUpdates) withObject:nil waitUntilDone:NO];// handleUpdates];
 //   [[WebService sharedInstance]eventsApiRequest:USER_API_EVERYONE];

}
-(void)everyoneParsedSuccessfully
{
    
    _everyoneArray = [[NSArray alloc]initWithArray:[Data sharedInstance].everyoneArray];

    NSLog(@"EVERYOEN Array = %@", [Data sharedInstance].everyoneArray);
    [self handleUpdates];


}

-(void)handleUpdates
{
    NSLog(@"1");

    [_tableView reloadData];
}

#pragma mark - Helper Functions
- (void)profileFound:(NSNotification *) notification {
    if ([[notification name] isEqualToString:@"Profile Found"]) {
        
        [self moveToOtherUserProfile];
    }
}


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
  //  _tableData = @{@"ATTENDING EVENTS" : @[@"Patrick", @"Steven", @"Philipe"],
    //               @"NOT ATTENDING EVENTS" : @[@"Nathan Barnes", @"Izzy Ali"]};
    
    //NSSortDescriptor *ascending = [[NSSortDescriptor alloc] initWithKey:@"self" ascending:YES];
   // NSArray *ascendingOrder = [NSArray arrayWithObject:ascending];
  //  _sectionTitles = [[_tableData allKeys] sortedArrayUsingDescriptors:ascendingOrder];
}

#pragma mark - Table View Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   
    NSLog(@"2");
  //  return 1;
    if (_isFriendsSelected && ([_friendsAttendingArray count] > 0 && [_friendsNotAttendingArray count] > 0))
    {
        return 2;
    }
    return 1;//[_sectionTitles count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSLog(@"3 - SECTION = %i", section);

    if (_isFriendsSelected && ([_friendsAttendingArray count] > 0 && section ==0))
    {
        return [_friendsAttendingArray count];
    }
    
    NSLog(@"3AAAA");
 //   return 2;
    if (_isFriendsSelected)
    {
        
        if (section == 0 && [_friendsAttendingArray count]>0)
        {
            return [_friendsAttendingArray count];
        }
        else
        {
            return [_friendsNotAttendingArray count];
        }
    
    }
    else
    {

        if (section == 0) {
            return [_everyoneArray count];
        }
        else
        {
            return 0;
        }
    }
    
    return 0;
    // Return the number of rows in the section.
 //   NSString *sectionTitle = [_sectionTitles objectAtIndex:section];
   // NSArray *sectionEvents = [_tableData objectForKey:sectionTitle];
  //  return [sectionEvents count];
}

//Custom Height View
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    NSLog(@"4");

    return [self headerCellAtIndex:section];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section    {
    
    return 40;
}

//Custom Footer View
/*
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
   
    NSLog(@"5");

    return [self footerCellAtIndex:section];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section    {
    
    //Forced the Footer to conform to a specific height that is equal to the header space between the cell
    return 15;
}
*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
    NSLog(@"6");

//    return [self eventCellAtIndex:indexPath];
    if (_isFriendsSelected)
    {
        
        if (indexPath.section == 0 && [_friendsAttendingArray count]>0)
        {
            return [self eventCellAtIndex:indexPath];
        }
        else
        {
            return [self eventNotAttendingCellAtIndex: indexPath];
        }
        
    }
    else
    {
        if (indexPath.section == 0 && [_everyoneArray count]>0) {
            return [self eventCellAtIndex:indexPath];

        }
        
        if (indexPath.section == 0) {
            return [self eventNotAttendingCellAtIndex: indexPath];
        }
        else
        {
            return nil;
        }
    }

    
//    NSString *sectionTitle = [_sectionTitles objectAtIndex:indexPath.section];
    if (_isFriendsSelected && indexPath.section == 1 && [_friendsAttendingArray count]>1) {
        return [self eventCellAtIndex:indexPath];

    } else
        return [self eventNotAttendingCellAtIndex: indexPath];

}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"Bring up maps!: row: %ld, section: %ld", (long)indexPath.row, (long)indexPath.section);
    
    

}



//People Event
-(void)moveToEvent:(NSNotification *) notification  {
    if ([[notification name] isEqualToString:@"People Event"])  {
        NSLog(@"Moving to Event related to People");
     //   [Data sharedInstance].selectedEvent = notification.object;
        [Data sharedInstance].selectedEventID = [NSString stringWithFormat:@"%i", [Data sharedInstance].selectedEvent.eventID];
        [self performSegueWithIdentifier:@"GoToEvent" sender:self];

    }
}
#pragma mark - Custom Cells
-(HeaderEventsTableViewCell *) headerCellAtIndex:(NSInteger) section  {
    
    
    NSLog(@"7");

    NSString *resuseID = @"HeaderEventsCell";
    NSString *nibName = @"HeaderEvents";
    
    [self.tableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:resuseID];
    HeaderEventsTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:resuseID];
    
    NSString *sectionTitle = @"NOT ATTENDING EVENTS";

    
    
    if (section == 0 && ((_isFriendsSelected && [_friendsAttendingArray count]>0 )|| !_isFriendsSelected))
    {
        sectionTitle = @"ATTENDING EVENTS";
    }
    
    cell.MyEventsLabel.text = sectionTitle;
    cell.filterButton.hidden = YES;
    cell.numberOfEventsLabel.hidden = YES;
    
    
    return cell;
}

/*
-(PeopleNotAttendingTableViewCell*) eventNotAttendingCellAtIndex: (NSIndexPath *) indexPath {
    
    NSLog(@"8");

    NSString *reuseID = @"PeopleEventsTableViewCell";
    NSString *nibName = @"PeopleNotAttending";
    
    [self.tableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:reuseID];
    PeopleNotAttendingTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:reuseID forIndexPath:indexPath];
    
    User *user = [User new];
    if (_isFriendsSelected)
    {
        user = [_friendsNotAttendingArray objectAtIndex:indexPath.row];
        
    }
    else
    {
        user = [_everyoneArray objectAtIndex:indexPath.row];
    }
    

    
    
    cell.profileName.text = @"Isfandyar";
    
    return cell;
}


*/
-(PeopleEventTableViewCell*) eventNotAttendingCellAtIndex: (NSIndexPath *) indexPath {
    
    NSLog(@"8");
    
    
    NSString *reuseID = @"PeopleEventsTableViewCell";
    NSString *nibName = @"PeopleEvent";
    
    [self.tableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:reuseID];
    PeopleEventTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:reuseID forIndexPath:indexPath];
    
    
    User *user = [User new];
    if (_isFriendsSelected)
    {
        user = [_friendsNotAttendingArray objectAtIndex:indexPath.row];
    }
    else
    {
        user = [_everyoneArray objectAtIndex:indexPath.row];
    }
    
    cell.user = user;
    cell.event = [Event new];
    
    return  [cell configureCell];
    
    //Setup cell using data pull down from the server, this is using dummy data
    //    NSString *sectionTitle = [_sectionTitles objectAtIndex:indexPath.section];
    //  NSArray *sectionEvents = [_tableData objectForKey:sectionTitle];
    //  NSString *personName = [sectionEvents objectAtIndex:indexPath.row];
    
    //  cell.nameLabel.text = personName;
    
    return cell;
    
    return cell;
}

-(PeopleEventTableViewCell *) eventCellAtIndex: (NSIndexPath *) indexPath {
    
    NSLog(@"9");

    NSString *reuseID = @"PeopleEventsTableViewCell";
    NSString *nibName = @"PeopleEvent";
    
    [self.tableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:reuseID];
    PeopleEventTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:reuseID forIndexPath:indexPath];
    
    
    User *user = [User new];
    if (_isFriendsSelected)
    {
        user = [_friendsAttendingArray objectAtIndex:indexPath.row];
    }
    else
    {
        user = [_everyoneArray objectAtIndex:indexPath.row];
    }

    cell.user = user;
    cell.event = [user.eventsArray objectAtIndex:0];
    
    return  [cell configureCell];
    
    //Setup cell using data pull down from the server, this is using dummy data
//    NSString *sectionTitle = [_sectionTitles objectAtIndex:indexPath.section];
  //  NSArray *sectionEvents = [_tableData objectForKey:sectionTitle];
  //  NSString *personName = [sectionEvents objectAtIndex:indexPath.row];
    
  //  cell.nameLabel.text = personName;
    
    return cell;
}

-(FooterEventsTableViewCell *) footerCellAtIndex:(NSInteger) section    {
    
    NSLog(@"10");

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
    if (!_isFriendsSelected) {
        _isFriendsSelected = YES;

        NSLog(@"Friends");
        [_friendsButton setBackgroundColor:[UIColor whiteColor]];
        [_everyoneButton setBackgroundColor:[UIColor lightGrayColor]];
        _everyoneButton.tintColor = [UIColor grayColor];
        
        
        //[_tableView reloadData];
    [[WebService sharedInstance]eventsApiRequest:USER_API_PEOPLE_FRIENDS];
        [_tableView reloadData];
    }
}

- (IBAction)everyoneButtonPressed:(UIButton *)sender {

    if (_isFriendsSelected) {
        NSLog(@"Everyone");
        [_everyoneButton setBackgroundColor:[UIColor whiteColor]];
        [_friendsButton setBackgroundColor:[UIColor lightGrayColor]];
        _friendsButton.tintColor = [UIColor grayColor];
        _isFriendsSelected = NO;
        
        [[WebService sharedInstance]eventsApiRequest:USER_API_PEOPLE_EVERYONE];
        [_tableView reloadData];
     //   [_tableView reloadData];

        // [[WebService sharedInstance]eventsApiRequest:USER_API_EVERYONE];
    }
}

@end
