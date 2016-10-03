//
//  CreateCollectionViewController.m
//  Why Go Solo
//
//  Created by Izzy on 03/10/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "CreateCollectionViewController.h"

@interface CreateCollectionViewController ()
@property NSArray *dummyData;
@property NSArray *sectionTitles;

@property BOOL isPrivateEvent;


@end

@implementation CreateCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _isPrivateEvent = NO;
    [self createDummyData];
    [self setupObservers];
    
    //Register The Nib for the collection cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CreateCell" bundle:nil] forCellWithReuseIdentifier:@"CreateCell"];
    
    self.collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
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
    _sectionTitles = @[@"HELP", @"FRIENDS", @"EVERYONE"];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    } else  {
        return [[self.dummyData objectAtIndex:section] count];
    }
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.dummyData count]; //3
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return [self editCell:indexPath];
    } else  {
        return [self friendEveryoneCell:indexPath];
    }
}


#pragma mark - Custom Collection Cells

-(FriendCollectionViewCell *) friendEveryoneCell:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"Cell";
    
    FriendCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    if (_isPrivateEvent) {
        cell.contentView.hidden = YES;
    } else  {
        cell.contentView.hidden = NO;
    }
    cell.profileImageView.image = [UIImage imageNamed:[self.dummyData[indexPath.section] objectAtIndex:indexPath.row]];
    
    return cell;
}

-(CreateCollectionViewCell *) editCell:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"CreateCell";
    
    CreateCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    return cell;
}

#pragma mark - Collection View Delegates

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeZero;
    } else if (_isPrivateEvent) {
        return CGSizeZero;
    } else {
        return CGSizeMake(self.collectionView.bounds.size.width, 50); //Modify the 100 value to adjust the height of the HEader
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath    {
    if (indexPath.section == 0) {
        //        return self.view.frame.size;
        return CGSizeMake(self.collectionView.bounds.size.width, 300);
    } else if (_isPrivateEvent) {
        return CGSizeZero;
    } else  {
        return CGSizeMake(100, 100);
    }
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        HeaderCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderCell" forIndexPath:indexPath];
        
        if (_isPrivateEvent) {
            headerView.hidden = YES;
            
        } else {
            headerView.hidden = NO;
        }
        
        headerView.sectionHeader.text = [_sectionTitles objectAtIndex:indexPath.section];
        
        reusableview = headerView;
    }
    
    return reusableview;
}

#pragma mark - Observer MEthods

-(void)privacyMode:(NSNotification *) notification   {
    if ([[notification name] isEqualToString:@"Privacy Mode"]) {
        
        NSLog(@"Bool: %d ", [[NSUserDefaults standardUserDefaults] boolForKey:@"publicPrivate"]);
        _isPrivateEvent = [[NSUserDefaults standardUserDefaults] boolForKey:@"publicPrivate"];
        [self.collectionView reloadData];
    }
}

-(void) changeLocation:(NSNotification *) notification  {
    if ([[notification name] isEqualToString:@"changeLocation"]) {
        NSLog(@"Location changing");
        [self performSegueWithIdentifier:@"GoToEditMap" sender:self];
    }
}

-(void) setupObservers    {
    //When the profile button is pressed the observer knows it has been pressed and this actiavted the the action assiociated with it
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(privacyMode:)
                                                 name:@"Privacy Mode"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLocation:) name:@"changeLocation" object:nil];
}

@end
