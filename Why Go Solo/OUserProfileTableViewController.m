//
//  OtherUserProfileTableViewController.m
//  Why Go Solo
//
//  Created by Izzy on 09/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "OUserProfileTableViewController.h"
#import "EventsTableViewCell.h"
#import "FooterEventsTableViewCell.h"
#import "HeaderEventsTableViewCell.h"
#import "OtherProfileTableViewCell.h"


@interface OtherUserProfileTableViewController () <UITableViewDataSource, UITableViewDelegate>
@property NSDictionary *tableData;
@property NSArray *sectionTitles;
@property NSArray *sectionData;
@property BOOL isUserBlocked;
@property BOOL isFriend;


//TextProperties

@property (weak, nonatomic) IBOutlet UILabel *universityLabel;
@property (weak, nonatomic) IBOutlet UILabel *accomodationLabel;


@end

@implementation OtherUserProfileTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDummyData];
    [self setupTable];
    [self setupUserReportingName:@"Andy Jones"];
    [self internalViewSetup];
    _isFriend = true;
    
    _accomodationLabel.text = @"The Killers";
}

-(void) viewWillAppear:(BOOL)animated   {
    [self reportOverlayAlpha:0 animationDuration:0.0f]; //Hide the overlay
    [_unBlockButton viewWithTag:0].alpha = 0;
    _unBlockButton.layer.cornerRadius = 3;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helper Functions

-(void) internalViewSetup   {
    _internalView.layer.cornerRadius = 5;
    _userReportedView.layer.cornerRadius = 5;
}

-(void) setupDummyData  {
    //Dummy Data
    _tableData = @{@"My Events" : @[@"test"],
                   @"My Events Two" : @[@"Andy Jones", @"Nathan Barnes"]
                   };
    
    NSSortDescriptor *decending = [[NSSortDescriptor alloc] initWithKey:@"self" ascending:NO];
    NSArray *decendingOrder = [NSArray arrayWithObject:decending];
    _sectionTitles = [[_tableData allKeys] sortedArrayUsingDescriptors:decendingOrder];
}

-(void) setupUserReportingName: (NSString *) name  {
    _reportName.text = [NSString stringWithFormat:@"Are you sure report you want to report %@", name];
    _userHasBeenReportedLabel.text = [NSString stringWithFormat:@"Are you sure report you want to report %@", name];
}

-(void) setupTable  {
    self.tableView.allowsSelectionDuringEditing=YES;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 140;
    //    self.tableView.allowsSelection = NO;
}

-(void)reportOverlayAlpha:(int)a animationDuration:(float)duration
{
    [UIView animateWithDuration:duration delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        for (id x in _overlayView.subviews)
        {
            if ([x class] == [UIView class])
            {
                [(UIView*)x setAlpha:a];
            }
        }
        _overlayView.alpha = a;
    } completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section    {
    
    return 1;
    
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
    
    return [self footerCellAtIndex:section];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section    {
    
    //Forced the Footer to conform to a specific height that is equal to the header space between the cell
    if (section == 0) {
        return 0;
    } else  {
        return 15;
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
        [_tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
        _tableView.scrollEnabled = NO;
    }
    
    cell.nameLabel.text = eventName;
    //    cell.eventEmoticonLabel.text = @"\ue057"; //pass the emoticon in unicode 6.0 +
    
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

- (IBAction)reportUserPressed:(UIButton *)sender {
    NSLog(@"Report User button  pressed");
    [self reportOverlayAlpha:1 animationDuration:0.2f];
    [_userReportedView viewWithTag:0].alpha = 0;
}

- (IBAction)blockUserPressed:(UIButton *)sender {
    NSLog(@"Block User Pressed");
    [_unBlockButton viewWithTag:0].alpha = 1;
    _isUserBlocked = YES;
    [_tableView reloadData];
}

- (IBAction)unblockButtonPressed:(UIButton *)sender {
    NSLog(@"Unblock User Pressed");
    [_unBlockButton viewWithTag:0].alpha = 0;
    _isUserBlocked = NO;
    _tableView.scrollEnabled = YES;
    [_tableView reloadData];
}


- (IBAction)addFriendButton:(UIBarButtonItem *)sender {
    NSLog(@"Friend LOgic needs to be added");
    if (_isFriend) {
        _addFriendButton.image = [UIImage imageNamed:@"check-button-20-20"];
        _isFriend = false;
        NSLog(@"Friend Added");
    } else {
        _addFriendButton.image = [UIImage imageNamed:@"add-event-20-20"];
        _isFriend = true;
        NSLog(@"Friend Removed");
    }
}

- (IBAction)noButtonPressed:(UIButton *)sender {
    [self reportOverlayAlpha:0 animationDuration:0];
}

- (IBAction)yesButtonPressed:(UIButton *)sender {
    NSLog(@"Reporting User...");
    [_tableView reloadData];
    [_userReportedView viewWithTag:0].alpha = 1;
}

- (IBAction)OkReportedButtonPressed:(UIButton *)sender {
    NSLog(@"Ok User has been Reported");
    [self reportOverlayAlpha:0 animationDuration:0];
}
#pragma mark - Scroll locking methods

/** SO allows masking of the top of the table*/
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    for (UITableViewCell *cell in self.tableView.visibleCells) {
        CGFloat hiddenFrameHeight = scrollView.contentOffset.y + self.navigationController.navigationBar.frame.size.height + 40 - cell.frame.origin.y;
        if (hiddenFrameHeight >= 0 || hiddenFrameHeight <= cell.frame.size.height) {
            [self maskCell:cell fromTopWithMargin:hiddenFrameHeight];
        }
    }
}

- (void)maskCell:(UITableViewCell *)cell fromTopWithMargin:(CGFloat)margin
{
    cell.layer.mask = [self visibilityMaskForCell:cell withLocation:margin/cell.frame.size.height];
    cell.layer.masksToBounds = YES;
}

- (CAGradientLayer *)visibilityMaskForCell:(UITableViewCell *)cell withLocation:(CGFloat)location
{
    CAGradientLayer *mask = [CAGradientLayer layer];
    mask.frame = cell.bounds;
    mask.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithWhite:1 alpha:0] CGColor], (id)[[UIColor colorWithWhite:1 alpha:1] CGColor], nil];
    mask.locations = [NSArray arrayWithObjects:[NSNumber numberWithFloat:location], [NSNumber numberWithFloat:location], nil];
    return mask;
}

@end
