//
//  EditCollectionViewController.m
//  Why Go Solo
//
//  Created by Izzy on 30/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "EditCollectionViewController.h"

@interface EditCollectionViewController ()
@property NSArray *dummyData;
@property NSArray *sectionTitles;
@property (nonatomic) UIView *overlayView;

@property BOOL isPrivateEvent;

@end

@implementation EditCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    _isPrivateEvent = NO;
    
    [self createDummyData];
    [self setupObservers];
    
    //Register The Nib for the collection cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"EditCell" bundle:nil] forCellWithReuseIdentifier:@"EditCell"];
    
    self.collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CollectionView Methods

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

-(EditCellCollectionViewCell *) editCell:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"EditCell";
    
    EditCellCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
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
        return CGSizeMake(self.collectionView.bounds.size.width, 400);
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

#pragma mark - Action Methods
- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
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


/**This method streches the subview ie the overlay to cover the entire screen and create that dimed affect */
-(void) createOverlay:(NSNotification *) notification {
    if ([[notification name] isEqualToString:@"closeOverlayView"]) {
        [self setupCloseOrCancelView:@"Close Event" andTextBody:@"Are you sure you want to close your event" andTag:0];
        
    } else if ([[notification name] isEqualToString:@"cancelOverlayView"])  {
        [self setupCloseOrCancelView:@"Cancel Event" andTextBody:@"Are you sure you want to cancel your event" andTag:1];
    }
}

/** Method that is called via an observer because of the abstraction of the overlayView nib, so when the No button is pressed on the overlayView xib it causes this method to activate, ie remove the view*/
-(void) removeOverlay: (NSNotification *) notifcation   {
    if ([[notifcation name] isEqualToString:@"No"]) {
        [self deleteOverlayAlpha:0 animationDuration:0.2f];
    }
}
-(void) setupObservers    {
    //When the profile button is pressed the observer knows it has been pressed and this actiavted the the action assiociated with it
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(privacyMode:)
                                                 name:@"Privacy Mode"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLocation:) name:@"changeLocation" object:nil];
    
    //This observer is important as it will recreate the illusion of having overlayed screen
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(createOverlay:) name:@"closeOverlayView" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(createOverlay:) name:@"cancelOverlayView" object:nil];

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeOverlay:) name:@"No" object:nil];

}



#pragma mark - Prepare Segue / Map Kit preperation
/** This method changes the default button of DONE for mapView to POST in order to fake the functionality of passing a post to the evne creation */

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"GoToEditMap"]) {
        NSLog(@"TEST segue");
        // Get reference to the destination view controller
        MapViewController *vc = [segue destinationViewController];
        // TAG and Title are set to 0, so they bypass the functionality and just pop back to the edit view
        vc.doneOrNextButton.title = @"NEXT";
        [vc.doneOrNextButton setTag:0];
    }
}

#pragma mark - Helper Functions
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

/*ensures that the view added streches properpy to the screen*/
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

-(void) setupCloseOrCancelView:(NSString *)eventTitle andTextBody:(NSString *)textBody andTag:(NSInteger) tag    {
    OverlayView *overlayVC = [OverlayView overlayView];
    overlayVC.eventTitle.text = eventTitle;
    overlayVC.eventText.text = textBody;
    [overlayVC.internalView setTag:tag];
    self.view.bounds = overlayVC.bounds;
    [self.view addSubview:overlayVC];
    [self stretchToSuperView:self.view];
    self.overlayView = overlayVC;
}


@end
