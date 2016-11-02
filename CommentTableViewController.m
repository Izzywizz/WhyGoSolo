//
//  CommentTableViewController.m
//  Why Go Solo
//
//  Created by Izzy on 14/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "CommentTableViewController.h"
#import "CommentsTableViewCell.h"
#import "WebService.h"
#import "Data.h"
#import "Event.h"
#import "User.h"

@interface CommentTableViewController () <DataDelegate>

@property NSMutableArray *testData;
@property (nonatomic) NSMutableString *textInput;
@property (nonatomic) UIView *overlayView;


@property NSMutableArray *commentsArray;


@end

@implementation CommentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setupObservers];
    _testData = [@[@"Test", @"TEst TWo"] mutableCopy];
    [self setupTable];
    [self setupObservers];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];// remove extra tableViewCells at the bottom
    _commmentReportedUserName = @"Neel";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [Data sharedInstance].delegate = self;
    [[WebService sharedInstance]eventsApiRequest:EVENT_API_SINGLE];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [Data sharedInstance].delegate = nil;

}


-(void)eventParsedSuccessfully
{
    NSLog(@"CCCCC PPPPPP EVVVV = %@", [Data sharedInstance].selectedEvent.eventDescription);
    _commentsArray = [NSMutableArray new];
    _commentsArray = [[NSMutableArray alloc]initWithArray:[Data sharedInstance].selectedEvent.commentsArray];
    
    [self performSelectorOnMainThread:@selector(handleUpdates) withObject:nil waitUntilDone:YES];
}
-(void)avatarDownloaded
{
        [self performSelectorOnMainThread:@selector(refreshCellInputViews) withObject:nil waitUntilDone:YES];
}

-(void)commentReported
{
    [self performSelectorOnMainThread:@selector(showCommentReportedAlert) withObject:nil waitUntilDone:NO];
}

-(void)showCommentReportedAlert
{
            [self setupOverlay:@"Report Comment" andTextBody:[NSString stringWithFormat:@"Are you sure you want to report %@ comment",_commmentReportedUserName] andTag:5 andReportedUser:_commmentReportedUserName];
}

-(void)refreshCellInputViews
{
    NSLog(@"EVENT TV AVATAR RELOAD INPUT VIEWS");
    [self.tableView reloadData];
    // [self.tableView reloadInputViews];
}
-(void)handleUpdates
{
    NSLog(@"OMMENTS ARR COUNt = %i", [_commentsArray count]);
    [self.tableView reloadData];

}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_commentsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self commentsCellAtIndex:indexPath];
}

-(CommentsTableViewCell *) commentsCellAtIndex: (NSIndexPath *) indexPath   {
    
    NSString *reusedID = @"CommentCell";
    NSString *nibName = @"CommentCell";
    
    [self.tableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:reusedID];
    CommentsTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:reusedID forIndexPath:indexPath];
    
    [cell configureCellWithCommentForTableView:self.tableView atIndexPath:indexPath];

    return cell;
}

#pragma mark - Table Helper Methods

-(void) setupTable  {
    self.tableView.allowsSelectionDuringEditing=YES;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 115;
    //    self.tableView.allowsSelection = NO;
}


#pragma mark - Action Methods

- (IBAction)addCommmentsButtonPressed:(UIBarButtonItem *)sender {
    NSLog(@"Add comments");
    [self performSegueWithIdentifier:@"GoToAddComment" sender:self];
}
- (IBAction)backButtonPressed:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
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

-(void) setupOverlay:(NSString *)eventTitle andTextBody:(NSString *)textBody andTag:(NSInteger) tag andReportedUser:(NSString *)user    {
    OverlayView *overlayVC = [OverlayView overlayView];
    overlayVC.eventTitle.text = eventTitle;
    overlayVC.eventText.text = textBody;
    [overlayVC.internalView setTag:tag];
    overlayVC.commmentReportedUserName = _commmentReportedUserName;
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

-(void) deleteOverlay: (NSNotification *) notifcation   {
    if ([[notifcation name] isEqualToString:@"deleteUserComment"]) {
        NSLog(@"delete notification");
        [self setupOverlay:@"Delete Comment" andTextBody:@"Would you like to remove your comment?" andTag:4 andReportedUser:nil];
    }
}

-(void) reportOverlay: (NSNotification *) notification  {
    if ([[notification name] isEqualToString:@"reportUserComment"]) {
        [self setupOverlay:@"Report Comment" andTextBody:[NSString stringWithFormat:@"Are you sure you want to report %@ comment",_commmentReportedUserName] andTag:5 andReportedUser:_commmentReportedUserName];
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

#pragma mark - Helper Functions

-(void) setupObservers    {
    //When the profile button is pressed the observer knows it has been pressed and this actiavted the the action assiociated with it
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeOverlay:) name:@"removeOverlay" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteOverlay:) name:@"deleteUserComment" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reportOverlay:) name:@"reportUserComment" object:nil];

}

@end
