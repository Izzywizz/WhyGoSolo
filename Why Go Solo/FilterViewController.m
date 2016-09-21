//
//  FilterViewController.m
//  Why Go Solo
//
//  Created by Izzy on 19/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "FilterViewController.h"

@interface FilterViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *mileLabel;
@property NSMutableArray *halls;
@property NSMutableArray *selectedObjects;
@property BOOL isHallsSwitchOn;
@property (weak, nonatomic) IBOutlet UISwitch *hallsSwitch;


@end

@implementation FilterViewController

#pragma mark - UI View Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    _halls = [NSMutableArray new];
    _halls = [self unpackHallsData];
    self.tableView.rowHeight = UITableViewAutomaticDimension;

}

-(void) viewWillAppear:(BOOL)animated   {
    
    if (!_selectedObjects)
    {
        _selectedObjects = [NSMutableArray new];
    }
    [[UISlider appearance] setThumbImage:[UIImage imageNamed:@"thumb.png.png"] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)switchValueChanged:(UISwitch *)sender {
    
    if (sender.on) {
        NSLog(@"Halls Activated");
        _isHallsSwitchOn = YES;
        self.tableView.alpha = 1;
    } else  {
        NSLog(@"Halls Deactivated");
        _isHallsSwitchOn = NO;
        self.tableView.alpha = 0;
    }
    
}
#pragma mark - Helper Functions


-(void) setNavigationButtonFontAndSize  {
    
    NSDictionary *attributes = [FontSetup setNavigationButtonFontAndSize];
    
    [_applyButton setTitleTextAttributes:attributes forState:UIControlStateNormal];
}

-(NSMutableArray *) unpackHallsData {
    
    HallsOfResidence *hallsOfResidence = [[HallsOfResidence alloc] init];
    NSMutableArray *hallsArray = [[NSMutableArray alloc] init];
    hallsArray = [hallsOfResidence returnHallsOfResidence];
    
    return hallsArray;
}


/** Ensures that the selection seperators are setup before the main views are shown*/
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self setNavigationButtonFontAndSize];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}


#pragma mark - TableView DataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section    {
    
    return self.halls.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    NSString *reuseID = @"residentCell";
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:reuseID forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    
    cell.textLabel.text = [_halls objectAtIndex:indexPath.row];

    
//    cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"check-button-20-20"]];
//    cell.accessoryView.alpha = 0;
//    NSLog(@"SELECETED OBJECTS = %@", _selectedObjects);
    
 /*   if (![_selectedObjects containsObject:[_halls objectAtIndex:indexPath.row]])
    {
        cell.accessoryView.alpha = 0;
    }
    else
    {
        cell.accessoryView.alpha = 1;
    }*/
    return cell;
}

/** Allows the cell selection seperators (the grey line across the tableView Cell) to extend across the entire table view */
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    
   /* HallsOfResidence *object = [_halls objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
   if (cell.accessoryView != nil) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        [_selectedObjects removeObject:object];
    }
    else {
        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"check-button-20-20"]];
        [_selectedObjects addObject:object];
    }*/
    
    HallsOfResidence *object = [_halls objectAtIndex:indexPath.row]; //This assumes that your table has only one section and all cells are populated directly into that section from sourceArray.
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        [_selectedObjects removeObject:object];
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [_selectedObjects addObject:object];
    }
}



#pragma mark - Action Methods

- (IBAction)backButtonPressed:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)applyButtonPressed:(UIBarButtonItem *)sender {
    NSLog(@"apply filter");
}

- (IBAction)sliderMileValueChange:(UISlider *)sender {
    self.mileLabel.text = [NSString stringWithFormat:@"%d MILES", (int) sender.value];
}

@end
