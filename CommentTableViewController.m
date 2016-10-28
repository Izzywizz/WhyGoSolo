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

@property NSMutableArray *commentsArray;


@end

@implementation CommentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setupObservers];
    _testData = [@[@"Test", @"TEst TWo"] mutableCopy];
    [self setupTable];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];// remove extra tableViewCells at the bottom
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [Data sharedInstance].delegate = self;
    [[WebService sharedInstance]eventsApiRequest:EVENT_DETAILS];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [Data sharedInstance].delegate = nil;

}


-(void)eventParsedSuccessfully
{
    NSLog(@"CCCCC PPPPPP EVVVV = %@", [Data sharedInstance].selectedEvent.eventDescription);
    _commentsArray = [[NSMutableArray alloc]initWithArray:[Data sharedInstance].selectedEvent.commentsArray];
    
    [self performSelectorOnMainThread:@selector(handleUpdates) withObject:nil waitUntilDone:YES];
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
    
    if (indexPath.row % 2) {
        [cell setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        [cell.profileImage setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    } else  {
        [cell setBackgroundColor:[UIColor whiteColor]];
        [cell.profileImage setBackgroundColor:[UIColor whiteColor]];
    }
    
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


@end
