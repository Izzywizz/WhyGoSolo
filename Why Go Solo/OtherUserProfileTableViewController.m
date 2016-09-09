//
//  OtherUserProfileTableViewController.m
//  Why Go Solo
//
//  Created by Izzy on 09/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "OtherUserProfileTableViewController.h"
#import "EventsTableViewCell.h"
#import "FooterEventsTableViewCell.h"
#import "HeaderEventsTableViewCell.h"


@interface OtherUserProfileTableViewController () <UITableViewDataSource, UITableViewDelegate>
@property NSDictionary *tableData;
@property NSArray *sectionTitles;
@property NSArray *sectionData;

//TextProperties

@property (weak, nonatomic) IBOutlet UILabel *universityLabel;
@property (weak, nonatomic) IBOutlet UILabel *accomodationLabel;


@end

@implementation OtherUserProfileTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDummyData];
    [self setupTable];
    _accomodationLabel.text = @"The Killers";

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helper Functions

-(void) setupDummyData  {
    //Dummy Data
    _tableData = @{@"My Events" : @[@"Andy Jones", @"Nathan Barnes"]
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
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _tableData.count;
}

/** Header View setup*/
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return [self headerCellAtIndex:section];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section    {
    
    return 40;
}

/** Footer view setup */
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [self footerCellAtIndex:section];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section    {
    
    //Forced the Footer to conform to a specific height that is equal to the header space between the cell
    return 15;
}

/** Standard cell creation*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    return [self eventCellAtIndex:indexPath];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"Bring up maps!: row: %ld, section: %ld", (long)indexPath.row, (long)indexPath.section);
//    [self performSegueWithIdentifier:@"GoToMap" sender:self];
    //Map functionality has not been implemented as of yet.
}

#pragma mark - Customer Cells

-(HeaderEventsTableViewCell *) headerCellAtIndex:(NSInteger) section  {
    
    NSString *resuseID = @"HeaderEventsCell";
    NSString *nibName = @"HeaderEvents";
    
    [self.tableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:resuseID];
    HeaderEventsTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:resuseID];
    
    NSString *sectionTitle = [_sectionTitles objectAtIndex:section];
    
    if ([sectionTitle  isEqual: @"My Events"]) {
        [cell.filterButton setHidden:YES];
    }
    cell.MyEventsLabel.text = sectionTitle;
    
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
}


- (IBAction)blockUserPressed:(UIButton *)sender {
    NSLog(@"Block User Pressed");
}



#pragma mark - Scroll locking methods

/** SO allows masking of the*/
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
