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

@property BOOL isHallsSwitchOn;
@property (weak, nonatomic) IBOutlet UISwitch *hallsSwitch;

//test
@property NSMutableArray *dataArray;

@end

@implementation FilterViewController

#pragma mark - UI View Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    
    //test to get checkmarks working,
    NSString *path = [[NSBundle mainBundle] pathForResource:@"HallsOfResidenceMark" ofType:@"plist"];
    self.dataArray = [NSMutableArray arrayWithContentsOfFile:path];
    
    

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
    
    NSDictionary *attributes = [ViewSetupHelper setNavigationButtonFontAndSize];
    
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
    
    //test
    return [_dataArray count];
    
    //return self.halls.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    NSString *reuseID = @"residentCell";
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:reuseID forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
    
    //removed temporarily
    //cell.textLabel.text = [_halls objectAtIndex:indexPath.row];
    
    NSMutableDictionary *item = [_dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [item objectForKey:@"text"];
    
    [item setObject:cell forKey:@"cell"];
    
    BOOL checked = [[item objectForKey:@"checked"] boolValue];
    NSLog(@"BOOL: %d", checked);
    
    UIImage *image = (checked) ? [UIImage imageNamed:@"check-button-20-20"] : [UIImage imageNamed:@"blank-checkmark"];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame = CGRectMake(0.0, 0.0, image.size.width, image.size.height);
    button.frame = frame;
    [button setBackgroundImage:image forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(checkButtonTapped:event:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor clearColor];
    cell.accessoryView = button;
    
    return cell;
}

- (void)checkButtonTapped:(id)sender event:(id)event
{
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint: currentTouchPosition];
    
    if (indexPath != nil)
    {
        [self tableView: self.tableView accessoryButtonTappedForRowWithIndexPath: indexPath];
    }
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *item = [self.dataArray objectAtIndex:indexPath.row];
    
    BOOL checked = [[item objectForKey:@"checked"] boolValue];
    NSLog(@"BOOL: %d", checked);
    
    [item setObject:[NSNumber numberWithBool:!checked] forKey:@"checked"];
    
    UITableViewCell *cell = [item objectForKey:@"cell"];
    UIButton *button = (UIButton *)cell.accessoryView;
    
    UIImage *newImage = (checked) ? [UIImage imageNamed:@"blank-checkmark"] : [UIImage imageNamed:@"check-button-20-20"];
    [button setBackgroundImage:newImage forState:UIControlStateNormal];
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
    
    [self tableView: self.tableView accessoryButtonTappedForRowWithIndexPath: indexPath];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

    NSLog(@"Halls: %@", _dataArray);
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
