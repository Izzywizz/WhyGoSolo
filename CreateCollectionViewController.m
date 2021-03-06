//
//  CreateCollectionViewController.m
//  Why Go Solo
//
//  Created by Izzy on 03/10/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "CreateCollectionViewController.h"
#import "Event.h"
#import "Data.h"
#import "WebService.h"
#import "User.h"



@interface CreateCollectionViewController ()
@property NSArray *dummyData;
@property NSArray *sectionTitles;

@property BOOL isPublicEvent;
@property BOOL isEmojiPresent;

@property NSMutableArray *friendsArray;
@end

@implementation CreateCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

#pragma mark - UI View Methods
- (void)viewDidLoad {
    [super viewDidLoad];

    _isEmojiPresent = [[NSUserDefaults standardUserDefaults] boolForKey:@"emoji"];
    NSLog(@"Intial Bool: %d", _isEmojiPresent);
    _isPublicEvent = YES;
    [self createDummyData];
    [self setupObservers];
    [self setNavigationButtonFontAndSize];
    
    
    //Register The Nib for the collection cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CreateCell" bundle:nil] forCellWithReuseIdentifier:@"CreateCell"];
    
    self.collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [Data sharedInstance].delegate = self;
    _friendsArray = [NSMutableArray new];
    if (![Data sharedInstance].createdEvent)
    {
        [Data sharedInstance].createdEvent = [Event new];
    }
    
    [[WebService sharedInstance]eventsApiRequest:USER_API_FRIENDS];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [Data sharedInstance].delegate = nil;

}
-(void)friendsParsedSuccessfully
{
    
    _friendsArray = [Data sharedInstance].friendsArray;
    
    
    NSLog(@"F ARRRR = %@", _friendsArray);
    [self performSelectorOnMainThread:@selector(handleUpdates) withObject:nil waitUntilDone:NO];
}

-(void)handleUpdates
{
    NSLog(@"AAEDWQREQWRWQR");
    [self.collectionView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helper Methods

-(void) setNavigationButtonFontAndSize  {
    
    NSDictionary *attributes = [ViewSetupHelper setNavigationButtonFontAndSize];
    
    [_nextButton setTitleTextAttributes:attributes forState:UIControlStateNormal];
}


#pragma mark <UICollectionViewDataSource>

-(void) createDummyData {
    
    // Initialize recipe image array
    NSArray *mainDishImages = [NSArray arrayWithObjects:@"egg_benedict.jpg", @"full_breakfast.jpg", @"ham_and_cheese_panini.jpg", @"ham_and_egg_sandwich.jpg", @"hamburger.jpg", @"instant_noodle_with_egg.jpg", @"japanese_noodle_with_pork.jpg", @"mushroom_risotto.jpg", @"noodle_with_bbq_pork.jpg", @"thai_shrimp_cake.jpg", @"vegetable_curry.jpg", nil];
    NSArray *drinkDessertImages = [NSArray arrayWithObjects:@"angry_birds_cake.jpg", @"creme_brelee.jpg", @"green_tea.jpg", @"starbucks_coffee.jpg", @"white_chocolate_donut.jpg", nil];
    NSArray *blankArray = @[@"testing"];
    self.dummyData = [NSArray arrayWithObjects: blankArray, mainDishImages, drinkDessertImages, nil];
    
    _sectionTitles = [[NSArray alloc] init];
    _sectionTitles = @[@"HELP", @"FRIENDS", @"EVERYONE(n)"];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    
    
    if (section == 0) {
        return 1;
    } else  {
        return [_friendsArray count];// [[self.dummyData objectAtIndex:section] count];
    }
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;//[self.dummyData count]; //3
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
    
    
    [cell configureCellWithUser:[_friendsArray objectAtIndex:indexPath.row]];
    
    cell.alpha = 0.5;

    
    return cell;
    if (_isPublicEvent) {
        cell.contentView.hidden = YES;
    } else  {
        cell.contentView.hidden = NO;
    }
    //  cell.profileImageView.image = [UIImage imageNamed:[self.dummyData[indexPath.section] objectAtIndex:indexPath.row]];
  //  cell.profileName.text = @"IsfandyarIsfandyar";
    
    return cell;
}

-(CreateCollectionViewCell *) editCell:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"CreateCell";
    
    CreateCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    if ([cell.describeEventTextView.text isEqualToString:@"Describe your event 140 chracters or less!"]) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setValue: @"YES" forKey: @"test"];
        [defaults synchronize];
    }
    
    
    return cell;
}

#pragma mark - Collection View Delegates

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeZero;
    } else if (_isPublicEvent) {
        return CGSizeZero;
    } else {
        return CGSizeMake(self.collectionView.bounds.size.width, 50); //Modify the 100 value to adjust the height of the HEader
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath    {
    if (indexPath.section == 0) {
        //        return self.view.frame.size;
        return CGSizeMake(self.collectionView.bounds.size.width, 280);
    } else if (_isPublicEvent) {
        return CGSizeZero;
    } else  {
        return CGSizeMake(60, 90);
    }
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    if (section == 1) {
        return UIEdgeInsetsMake(20, 20, 20, 20); //allows padding between cells to be changed but not the FRIENDS/ EVERYONE headerViews
    } else if (section == 2) {
        return UIEdgeInsetsMake(20, 20, 20, 20); //allows padding between cells to be changed but not the FRIENDS/ EVERYONE headerViews
    } else
        return UIEdgeInsetsMake(0, 0, 0, 0); //Just set the default values
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        HeaderCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderCell" forIndexPath:indexPath];
        
        if (_isPublicEvent) {
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
        
        NSLog(@"Is Public: %d ", [[NSUserDefaults standardUserDefaults] boolForKey:@"publicPrivate"]);
        _isPublicEvent = [[NSUserDefaults standardUserDefaults] boolForKey:@"publicPrivate"];
        [Data sharedInstance].createdEvent.isPrivate = _isPublicEvent;
        [self.collectionView reloadData];
    }
}

-(void) setupObservers    {
    //When the profile button is pressed the observer knows it has been pressed and this actiavted the the action assiociated with it
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(privacyMode:) name:@"Privacy Mode" object:nil];
}


#pragma mark - Action Methods

- (IBAction)backButtonPressed:(UIBarButtonItem *)sender {
    
    [Data sharedInstance].createdEvent = nil;
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)nextButton:(UIBarButtonItem *)sender {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    _isEmojiPresent = [defaults boolForKey:@"emoji"];
    NSLog(@"Emoji BOOL: %d", _isEmojiPresent);
    BOOL isTheDecriptionBlank = [defaults boolForKey:@"test"];
    
    if (isTheDecriptionBlank == YES && _isEmojiPresent == NO) {
        NSLog(@"WORKS");
        [self setupAlertViewWithTitle:@"No description text and Emoji"  andMessage:@"Please enter some text within the descripton and add an emoji"];
    } else if(isTheDecriptionBlank == NO && _isEmojiPresent == YES)  {
        [self performSegueWithIdentifier:@"GoToAddMap" sender:self];
        NSLog(@"DOES Not Work");
    } else if (isTheDecriptionBlank == YES && _isEmojiPresent == YES) {
        [self setupAlertViewWithTitle:@"No description text"  andMessage:@"Please enter some text within the descripton"];
    } else if (isTheDecriptionBlank == NO && _isEmojiPresent == NO) {
        [self setupAlertViewWithTitle:@"No Emoji Present"  andMessage:@"Please add a emoji"];
    }
}

#pragma mark - Prepare Segue
/** This method changes the default button of DONE for mapView to POST in order to fake the functionality of passing a post to the evne creation */

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"GoToAddMap"]) {
        NSLog(@"TEST segue");
        // Get reference to the destination view controller
        MapViewController *vc = [segue destinationViewController];
        vc.doneOrNextButton.title = @"POST";
        [vc.doneOrNextButton setTag:100];
    }
}

#pragma mark - Alert Methods

-(void) setupAlertViewWithTitle: (NSString *) title andMessage: (NSString *) message{
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *dismiss = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Dismiss");
    }];
    [alertVC addAction:dismiss];
    [self presentViewController:alertVC animated:YES completion:nil];
}



@end
