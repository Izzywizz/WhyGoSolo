//
//  PeopleEventCollectionViewController.m
//  Why Go Solo
//
//  Created by Izzy on 03/10/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "PeopleEventCollectionViewController.h"
#import "WebService.h"
#import "Data.h"
#import "Event.h"
@interface PeopleEventCollectionViewController () <DataDelegate>
@property NSArray *dummyData;
@property NSArray *sectionTitles;
@property Event *event;


@property NSArray *friendsArray;
@property NSArray *otherPeopleArray;

@property BOOL hasJoinedEvent;
@end

@implementation PeopleEventCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // [self createDummyData];
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

-(void)viewWillAppear:(BOOL)animated
{
    _friendsArray = @[];
    _otherPeopleArray = @[];
    
    [Data sharedInstance].delegate = self;
    [[WebService sharedInstance]eventsApiRequest:EVENT_API_SINGLE];
    
    
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [Data sharedInstance].delegate = nil;
}


-(void)eventParsedSuccessfully
{
    _event = [Data sharedInstance].selectedEvent;
    _friendsArray = [[NSArray alloc]initWithArray:[Data sharedInstance].selectedEvent.friendsArray];
    _otherPeopleArray = [[NSArray alloc]initWithArray:[Data sharedInstance].selectedEvent.otherUsersArray];
    
    [self performSelectorOnMainThread:@selector(handleUpdates) withObject:nil waitUntilDone:YES];
    NSLog(@"PPPPPP EVVVV = %@", _event.eventDescription);
}

-(void)handleUpdates
{
    _sectionTitles = @[@"EVENT",[NSString stringWithFormat:@"FRIENDS (%lu)",(unsigned long)[ _friendsArray count]], [NSString stringWithFormat:@"OTHER ATTENDEES (%lu)",(unsigned long)[ _otherPeopleArray count]]];

    [self.collectionView reloadData];
}

-(void)avatarDownloaded
{
    
    NSLog(@"EVENT TV AVATAR DOWNLOADED");
    [self performSelectorOnMainThread:@selector(refreshCellInputViews) withObject:nil waitUntilDone:YES];
}


-(void)refreshCellInputViews
{
    NSLog(@"EVENT TV AVATAR RELOAD INPUT VIEWS");
    [self.collectionView reloadData];
    // [self.tableView reloadInputViews];
}
#pragma mark <UICollectionViewDataSource>

-(void) createDummyData {
    
    // Initialize recipe image array
    NSArray *mainDishImages = [NSArray arrayWithObjects:@"egg_benedict.jpg", @"full_breakfast.jpg", @"ham_and_cheese_panini.jpg", @"ham_and_egg_sandwich.jpg", @"hamburger.jpg", @"instant_noodle_with_egg.jpg", @"japanese_noodle_with_pork.jpg", @"mushroom_risotto.jpg", @"noodle_with_bbq_pork.jpg", @"thai_shrimp_cake.jpg", @"vegetable_curry.jpg", nil];
    NSArray *drinkDessertImages = [NSArray arrayWithObjects:@"angry_birds_cake.jpg", @"creme_brelee.jpg", @"green_tea.jpg", @"starbucks_coffee.jpg", @"white_chocolate_donut.jpg", nil];
    NSArray *blankArray = @[@"testing"];
    self.dummyData = [NSArray arrayWithObjects: blankArray, mainDishImages, drinkDessertImages, nil];
    
    _sectionTitles = [[NSArray alloc] init];
    _sectionTitles = @[@"EVENT", @"FRIENDS (n)", @"OTHER ATTENDEES (n)"];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 3;
//    return 2;
    return self.dummyData.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return [_friendsArray count];
            break;
        case 2:
            return [_otherPeopleArray count];
            break;
        default:
            return 0;
            break;
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

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(20, 20, 20, 20); //allows padding between cells to be changed
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
        return CGSizeMake(self.collectionView.bounds.size.width, 200);
    } else  {
        return CGSizeMake(60, 90); //Height for the images
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
    
    if (indexPath.section == 0)
    {
        [cell configureCellWithUser:[_friendsArray objectAtIndex:indexPath.row]];
    }
    else
    {
        [cell configureCellWithUser:[_otherPeopleArray objectAtIndex:indexPath.row]];

    }
  //  cell.profileImageView.image = [UIImage imageNamed:[self.dummyData[indexPath.section] objectAtIndex:indexPath.row]];
  //  cell.profileName.text = @"Isfandyar";
    
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
