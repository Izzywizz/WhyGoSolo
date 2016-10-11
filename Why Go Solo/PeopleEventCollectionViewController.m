//
//  PeopleEventCollectionViewController.m
//  Why Go Solo
//
//  Created by Izzy on 03/10/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "PeopleEventCollectionViewController.h"

@interface PeopleEventCollectionViewController ()
@property NSArray *dummyData;
@property NSArray *sectionTitles;

@property BOOL hasJoinedEvent;
@end

@implementation PeopleEventCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createDummyData];
    [self setupObservers];
    
    //Register The Nib for the collection cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"EventCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"EventCollectionCell"];
    
    self.collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    //Add padding betweeen the section headers
    UICollectionViewFlowLayout *collectionViewLayout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    collectionViewLayout.sectionInset = UIEdgeInsetsMake(5, 0, 5, 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark <UICollectionViewDataSource>

-(void) createDummyData {
    
    // Initialize recipe image array
    NSArray *mainDishImages = [NSArray arrayWithObjects:@"egg_benedict.jpg", @"full_breakfast.jpg", @"ham_and_cheese_panini.jpg", @"ham_and_egg_sandwich.jpg", @"hamburger.jpg", @"instant_noodle_with_egg.jpg", @"japanese_noodle_with_pork.jpg", @"mushroom_risotto.jpg", @"noodle_with_bbq_pork.jpg", @"thai_shrimp_cake.jpg", @"vegetable_curry.jpg", nil];
    NSArray *drinkDessertImages = [NSArray arrayWithObjects:@"angry_birds_cake.jpg", @"creme_brelee.jpg", @"green_tea.jpg", @"starbucks_coffee.jpg", @"white_chocolate_donut.jpg", nil];
    NSArray *blankArray = @[@"testing"];
    self.dummyData = [NSArray arrayWithObjects: blankArray, mainDishImages, drinkDessertImages, nil];
    
    _sectionTitles = [[NSArray alloc] init];
    _sectionTitles = @[@"EVENT", @"FRIENDS", @"OTHER"];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    NSLog(@"Sections Count: %d", self.dummyData.count);
//    return 2;
    return self.dummyData.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
        if (section == 0) {
            return 1; //return just the event cell
        } else  {
            return [[self.dummyData objectAtIndex:section] count]; //bring back the specific count for that object in the
        }
}

#pragma mark <UICollectionViewDelegate>

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return [self eventCell:indexPath];
    } else  {
        return [self friendOtherCell:indexPath];
    }
}


#pragma mark - Collection View Delegates

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeZero;
    }  else {
        return CGSizeMake(self.collectionView.bounds.size.width, 50); //Modify the 100 value to adjust the height of the HEader
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath    {
    if (indexPath.section == 0) {
        //        return self.view.frame.size;
        return CGSizeMake(self.collectionView.bounds.size.width, 220);
    } else  {
        return CGSizeMake(100, 120);
    }
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        HeaderCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderCell" forIndexPath:indexPath];
        
        headerView.sectionHeader.text = [_sectionTitles objectAtIndex:indexPath.section];
        
        reusableview = headerView;
    }
    
    return reusableview;
}


#pragma mark - Custom Collection Cells

-(FriendCollectionViewCell *) friendOtherCell:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"Cell";
    
    FriendCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.profileImageView.image = [UIImage imageNamed:[self.dummyData[indexPath.section] objectAtIndex:indexPath.row]];
    cell.profileName.text = @"Izzy";
    
    return cell;
}

-(EventCollectionViewCell *) eventCell:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"EventCollectionCell";
    
    EventCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    [cell configureCellWithEventForTableView:self.collectionView atIndexPath:indexPath];
    
    return cell;
}

#pragma mark - Observer Methods

-(void) joinButton:(NSNotification *) notification  {
    if ([[notification name] isEqualToString:@"Join"]) {
        self.hasJoinedEvent = [[NSUserDefaults standardUserDefaults] boolForKey:@"hasJoinedEvent"];
        NSLog(@"Intiate Join Thingy, Bool: %d", self.hasJoinedEvent);
    }
}


-(void) joinedButton:(NSNotification *) notification    {
    if ([[notification name] isEqualToString:@"Joined"]) {
        self.hasJoinedEvent = [[NSUserDefaults standardUserDefaults] boolForKey:@"hasJoinedEvent"];
        NSLog(@"Joined, Bool: %d", self.hasJoinedEvent);
    }
}


-(void) setupObservers    {
    //When the join button is pressed the observer knows it has been pressed and this actiavted the the action assiociated with it
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(joinButton:) name:@"Join" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(joinedButton:) name:@"Joined" object:nil];
}

#pragma mark - ACtion Methods

- (IBAction)backButtonPressed:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



@end
