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
@property NSArray *halls;

@end

@implementation FilterViewController

#pragma mark - UI View Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Filter View Activated!");
    [self setNavigationButtonFontAndSize];
    [self unpackHallsData];
}

-(void) viewWillAppear:(BOOL)animated   {
    [[UISlider appearance] setThumbImage:[UIImage imageNamed:@"thumb.png.png"] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helper Functions
-(void) setNavigationButtonFontAndSize  {
    
    NSDictionary *attributes = [FontSetup setNavigationButtonFontAndSize];
    
    [_applyButton setTitleTextAttributes:attributes forState:UIControlStateNormal];
}

-(void) unpackHallsData {
    
    self.halls = [HallsOfResidence returnHallsOfResidence];
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
    
    return cell;
}

#pragma mark - TableView Header Methods




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
