//
//  OtherProfileTableViewController.m
//  Why Go Solo
//
//  Created by Izzy on 08/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "OtherProfileTableViewController.h"

@interface OtherProfileTableViewController ()

@end

@implementation OtherProfileTableViewController
NSDictionary *testTableData;
NSArray *testSectionTitles;
NSArray *testSectionData;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"testing");
    [self setupData];
    [self setupTable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Dummy Data
-(void) setupData  {
    //Dummy Data
    testTableData = @{@"My Events" : @[@"Andy Jones", @"Nathan Barnes" ]};
    NSSortDescriptor *decending = [[NSSortDescriptor alloc] initWithKey:@"self" ascending:NO];
    NSArray *decendingOrder = [NSArray arrayWithObject:decending];
    testSectionTitles = [[testTableData allKeys] sortedArrayUsingDescriptors:decendingOrder];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return testSectionTitles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2; //test dat
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self eventCellAtIndex:indexPath];
}


#pragma mark - Table Methods
-(void) setupTable  {
    self.tableView.allowsSelectionDuringEditing=YES;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 140;
}

#pragma mark - Custom Table Cell


-(EventsTableViewCell *) eventCellAtIndex: (NSIndexPath *) indexPath {
    
    NSString *reuseID = @"EventsTableViewCell";
    NSString *nibName = @"Events";
    
    [self.tableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:reuseID];
    EventsTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:reuseID forIndexPath:indexPath];
    
    //Setup cell using data pull down from the server, this is using dummy data
    NSString *sectionTitle = [testSectionTitles objectAtIndex:indexPath.section];
    NSArray *sectionEvents = [testTableData objectForKey:sectionTitle];
    NSString *eventName = [sectionEvents objectAtIndex:indexPath.row];
    
    //Basic logic to ensure that the correct join/ edit are displayed for events

    cell.nameLabel.text = eventName;
    
    return cell;
}

@end

