//
//  AlternateProfileTableViewController.m
//  Why Go Solo
//
//  Created by Izzy on 17/10/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "AlternateProfileTableViewController.h"
#import "EventsTableViewCell.h"
#import "FooterEventsTableViewCell.h"
#import "HeaderEventsTableViewCell.h"
#import "OtherProfileTableViewCell.h"
#import "User.h"
#import "Event.h"
#import "OverlayView.h"
#import "EventCellView.h"
#import "WebService.h"

@interface AlternateProfileTableViewController ()

@property NSDictionary *tableData;
@property NSArray *sectionTitles;
@property NSArray *sectionData;
@property BOOL isUserBlocked;
@property BOOL isFriend;
@property (nonatomic) UIView *overlayView;



@end

@implementation AlternateProfileTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDummyData];
    [self setupTable];
    [self setupObservers];
    
    _isFriend = true;
    _reportedUserName = @"Andy Jones";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helper Functions
-(void) setupDummyData  {
    //Dummy Data
    _tableData = @{@"My Events" : @[@"test", @"test2"],
                   @"My Events Two" : @[@"Andy Jones", @"Nathan Barnes"]
                   };
    
    NSSortDescriptor *decending = [[NSSortDescriptor alloc] initWithKey:@"self" ascending:NO];
    NSArray *decendingOrder = [NSArray arrayWithObject:decending];
    _sectionTitles = [[_tableData allKeys] sortedArrayUsingDescriptors:decendingOrder];
}


-(void) setupTable  {
    self.tableView.allowsSelectionDuringEditing=YES;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 140;
    //    self.tableView.allowsSelection = NO;
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section    {
    
    if (section == 0) {
        return 1;
    } else  {
        return _tableData.count;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

/** Header View setup*/
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [self headerCellAtIndex:section];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section    {
    
    if (section == 0) {
        return 0;
    } else  {
        return 40;
    }
}

/** Footer view setup */
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    if (section == 0) {
        return nil;
    } else  {
        return [self footerCellAtIndex:section];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section    {
    
    //Forced the Footer to conform to a specific height that is equal to the header space between the cell
    if (section == 0) {
        return 0;
    } else  {
        return 94;
    }
    
}

/** Standard cell creation*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    if (indexPath.section == 0) {
        NSLog(@"Section 0");
        return [self otherProfileCellAtIndex:indexPath];
    }
    if (indexPath.section == 1) {
        NSLog(@"Section 1");
        return [self eventCellAtIndex:indexPath];
    }
    
    return [self eventCellAtIndex:indexPath];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"Bring up maps!: row: %ld, section: %ld", (long)indexPath.row, (long)indexPath.section);
    //    [self performSegueWithIdentifier:@"GoToMap" sender:self];
    //Map functionality has not been implemented as of yet.
}

#pragma mark - Custom Cells

-(HeaderEventsTableViewCell *) headerCellAtIndex:(NSInteger) section  {
    
    NSString *resuseID = @"HeaderEventsCell";
    NSString *nibName = @"HeaderEvents";
    
    [self.tableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:resuseID];
    HeaderEventsTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:resuseID];
    
    NSString *sectionTitle = [_sectionTitles objectAtIndex:section];
    
    if (_isUserBlocked == YES) {
        cell.numberOfEventsLabel.text = @"(0)";
        NSLog(@"Zero Events");
    } else  {
        cell.numberOfEventsLabel.text = @"(2)"; //Needs to be set to count with real data
    }
    if ([sectionTitle  isEqual: @"My Events"]) {
        [cell.filterButton setHidden:YES];
        
        
    }
    cell.MyEventsLabel.text = sectionTitle;
    
    return cell;
}

-(OtherProfileTableViewCell *) otherProfileCellAtIndex: (NSIndexPath *) indexPath    {
    
    NSString *reuseID = @"OtherProfileCell";
    NSString *nibName = @"OtherProfile";
    
    [self.tableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:reuseID];
    OtherProfileTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:reuseID forIndexPath:indexPath];
    
    [cell configureCollectionForOtherProfile:self.tableView atIndexPath:indexPath];
    return cell;
}

-(EventsTableViewCell *) eventCellAtIndex: (NSIndexPath *) indexPath {
    
    NSString *reuseID = @"EventsTableViewCell";
    NSString *nibName = @"Events";
    
    [self.tableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:reuseID];
    EventsTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:reuseID forIndexPath:indexPath];
    
    //Setup cell using data pull down from the server, this is using dummy data
    NSString *sectionTitle = [_sectionTitles objectAtIndex:indexPath.section];
    NSArray *sectionEvents = [_tableData objectForKey:sectionTitle];
    NSString *eventName = [sectionEvents objectAtIndex:indexPath.row];
    
    //Basic logic to ensure that the correct join/ edit are displayed for events
    if ([sectionTitle isEqualToString:@"My Events"]) {
        [cell viewWithTag:EDIT].alpha = 0;
    }
    if (_isUserBlocked) {
        cell.hidden = YES;
        [cell setUserInteractionEnabled:NO];
    }
    
//    cell.nameLabel.text = eventName;
    
    return cell;
}

-(FooterEventsTableViewCell *) footerCellAtIndex:(NSInteger) section    {
    
    NSString *resuseID = @"FooterEventsCell";
    NSString *nibName = @"FooterEvents";
    
    [self.tableView registerNib: [UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:resuseID];
    FooterEventsTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:resuseID];
    
    if (_isUserBlocked) {
        cell.blockButton.alpha = 0;
    } else  {
        cell.blockButton.alpha = 1;
    }
    
    return cell;
}

#pragma mark - Registering Observers

-(void) setupObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(blockUserPressed:) name:@"BlockUser" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(unblockButtonPressed:) name:@"UnblockUser" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reportButtonPressed:) name:@"ReportUser" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeOverlay:) name:@"removeOverlay" object:nil];
}

#pragma mark - Oberver MEthods
- (void)blockUserPressed:(NSNotification *) notification {
    if ([[notification name] isEqualToString:@"BlockUser"]) {
        NSLog(@"Block User Pressed from Observer");
        _isUserBlocked = YES;
        [self.tableView reloadData];
    }
}

- (void)unblockButtonPressed:(NSNotification *) notification {
    if ([[notification name] isEqualToString:@"UnblockUser"]) {
        NSLog(@"Unblock User Pressed from Observer");
        _isUserBlocked = NO;
        [self.tableView reloadData];
    }
}

- (void)reportButtonPressed:(NSNotification *) notification {
    if ([[notification name] isEqualToString:@"ReportUser"]) {
        NSLog(@"Report button pressed internally");
        [self setupReportUserOverlay:@"Report User" andTextBody:[NSString stringWithFormat:@"Are you sure you want to report %@", _reportedUserName] andTag:3 andReportedUser:_reportedUserName];
        }
    }

#pragma mark - Action Methods

- (IBAction)backButton:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addFriendButtonPressed:(UIBarButtonItem *)sender {
    NSLog(@"Friend LOgic needs to be added");
    if (_isFriend) {
        _addFriendButton.image = [UIImage imageNamed:@"minus-friend"];
        _isFriend = false;
        NSLog(@"Friend Added");
    } else {
        _addFriendButton.image = [UIImage imageNamed:@"add-event-20-20"];
        _isFriend = true;
        NSLog(@"Friend Removed");
    }
    
    [[WebService sharedInstance]eventsApiRequest:USER_API_FRIEND_STATUS_UPDATE];
}

#pragma mark - OverlayView Methods
/*ensures that the view added streches properly to the screen*/
- (void) stretchToSuperView:(UIView*) view {
    view.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *bindings = NSDictionaryOfVariableBindings(view);
    NSString *formatTemplate = @"%@:|[view]|";
    for (NSString * axis in @[@"H",@"V"]) {
        NSString * format = [NSString stringWithFormat:formatTemplate,axis];
        NSArray * constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:bindings];
        [view.superview addConstraints:constraints];
    }
}

-(void) setupReportUserOverlay:(NSString *)eventTitle andTextBody:(NSString *)textBody andTag:(NSInteger) tag andReportedUser:(NSString *)user    {
    OverlayView *overlayVC = [OverlayView overlayView];
    overlayVC.eventTitle.text = eventTitle;
    overlayVC.eventText.text = textBody;
    [overlayVC.internalView setTag:tag];
    overlayVC.reportedUserName = _reportedUserName;
    self.view.bounds = overlayVC.bounds;
    [self.view addSubview:overlayVC];
    [self stretchToSuperView:self.view];
    self.overlayView = overlayVC;
}

-(void) removeOverlay: (NSNotification *) notifcation   {
    if ([[notifcation name] isEqualToString:@"removeOverlay"]) {
        [self deleteOverlayAlpha:0 animationDuration:0.2f];
    }
}

-(void) deleteConfirmation: (NSNotification *) notifcation   {
    if ([[notifcation name] isEqualToString:@"deleteConfirmation"]) {
        [self performSegueWithIdentifier:@"GoToDeleteConfirmation" sender:self];
    }
}

-(void)deleteOverlayAlpha:(int)a animationDuration:(float)duration
{
    [UIView animateWithDuration:duration delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        for (id x in self.overlayView.subviews)
        {
            if ([x class] == [UIView class])
            {
                [(UIView*)x setAlpha:a];
            }
        }
        self.overlayView.alpha = a;
    } completion:nil];
}

@end
