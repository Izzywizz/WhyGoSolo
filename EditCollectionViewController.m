//
//  EditCollectionViewController.m
//  Why Go Solo
//
//  Created by Izzy on 30/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "EditCollectionViewController.h"
#import "Data.h"
#import "Event.h"
#import "WebService.h"
#import "RREmojiParser.h"
@interface EditCollectionViewController () <DataDelegate>
@property NSArray *dummyData;
@property NSArray *sectionTitles;
@property (nonatomic) UIView *overlayView;

@property BOOL isPublicEvent;

@end

@implementation EditCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    _isPublicEvent = YES; //intailly set the switch to off in the storyboard!

    [self createDummyData];
    _sectionTitles = [[NSArray alloc] init];
    _sectionTitles = @[@"HELP", @"FRIENDS (n/n)", @"EVERYONE (n)"];
    [self setupObservers];
    [self setNavigationButtonFontAndSize];
    
    //Register The Nib for the collection cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"EditCell" bundle:nil] forCellWithReuseIdentifier:@"EditCell"];
    
    self.collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [Data sharedInstance].delegate = self;
    if ([Data sharedInstance].createdEvent  == nil)
    {
        [Data sharedInstance].createdEvent = [Data sharedInstance].selectedEvent;
        
 /*       NSString *emojiUTF8 = [NSString stringWithUTF8String:[[Data sharedInstance].selectedEvent.emoji UTF8String]];
        NSData *emojiData = [emojiUTF8 dataUsingEncoding:NSNonLossyASCIIStringEncoding];
        NSString *emojiString = [[NSString alloc] initWithData:emojiData encoding:NSUTF8StringEncoding];
        
        
        [Data sharedInstance].createdEvent.emoji = emojiString; */
    }
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [Data sharedInstance].delegate = nil;

}


-(void)eventsDownloadedSuccessfully
{
 //   _myEventsDataArray = [Data sharedInstance].myEventsArray;
   // _dataArray = [Data sharedInstance].eventsArray;
  //  [self.tableView reloadData];
    
    [self performSelectorOnMainThread:@selector(handleUpdates) withObject:nil waitUntilDone:YES];
}

-(void)eventEdited
{
    NSLog(@"SDDASDSADASDAD");
    [self performSelectorOnMainThread:@selector(handleUpdates) withObject:nil waitUntilDone:NO];//
}

-(void)handleUpdates
{
    NSLog(@"SDDASDSADASDAD-----");
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
    _sectionTitles = @[@"HELP", @"FRIENDS (n/n)", @"EVERYONE (n)"];
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
    
    if (_isPublicEvent) {
        cell.contentView.hidden = YES;
    } else  {
        cell.contentView.hidden = NO;
    }
 //   cell.profileImageView.image = [UIImage imageNamed:[self.dummyData[indexPath.section] objectAtIndex:indexPath.row]];
    cell.profileName.text = @"Isfandyar";

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
    } else if (_isPublicEvent) {
        return CGSizeZero;
    } else {
        return CGSizeMake(self.collectionView.bounds.size.width, 50); //Modify the 100 value to adjust the height of the HEader
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath    {
    if (indexPath.section == 0) {
        //        return self.view.frame.size;
        return CGSizeMake(self.collectionView.bounds.size.width, 450); //Height for the collectionCell
    } else if (_isPublicEvent) {
        return CGSizeZero;
    } else  {
        return CGSizeMake(60, 90); //This is sizes for round image icons.
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

#pragma mark - Action Methods
- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender {
    [Data sharedInstance].createdEvent  = nil;
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender {
    NSLog(@"Please save this");
  /*
    NSString *emojiUTF8 = [NSString stringWithUTF8String:[[Data sharedInstance].createdEvent.emoji UTF8String]];
    NSData *emojiData = [emojiUTF8 dataUsingEncoding:NSNonLossyASCIIStringEncoding];
    NSString *emojiString = [[NSString alloc] initWithData:emojiData encoding:NSUTF8StringEncoding];
    
    
    [Data sharedInstance].createdEvent.emoji = emojiString;*/
    NSString *emojiUTF8 = [NSString stringWithUTF8String:[[Data sharedInstance].selectedEvent.emoji UTF8String]];
    NSData *emojiData = [emojiUTF8 dataUsingEncoding:NSNonLossyASCIIStringEncoding];
    NSString *emojiString = [[NSString alloc] initWithData:emojiData encoding:NSUTF8StringEncoding];
    
    
    

    [Data sharedInstance].createdEvent.emoji = emojiString;

    NSString *emojiUTF82 = [NSString stringWithUTF8String:[[Data sharedInstance].selectedEvent.eventDescription UTF8String]];
    NSData *emojiData2 = [emojiUTF82 dataUsingEncoding:NSNonLossyASCIIStringEncoding];
    NSString *emojiString2 = [[NSString alloc] initWithData:emojiData2 encoding:NSUTF8StringEncoding];
    
    [Data sharedInstance].createdEvent.eventDescription = emojiString2;//[[RREmojiParser sharedInstance]parseStringontainingEmojis:[Data sharedInstance].createdEvent.eventDescription];
    
    [[WebService sharedInstance]eventsApiRequest:EVENT_API_EDIT];
}


#pragma mark - Observer MEthods

-(void)privacyMode:(NSNotification *) notification   {
    if ([[notification name] isEqualToString:@"Privacy Mode"]) {
        
        NSLog(@"isPublic: %d ", [[NSUserDefaults standardUserDefaults] boolForKey:@"publicPrivate"]);
        _isPublicEvent = [[NSUserDefaults standardUserDefaults] boolForKey:@"publicPrivate"];
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
    if ([[notifcation name] isEqualToString:@"removeOverlay"]) {
        [self deleteOverlayAlpha:0 animationDuration:0.2f];
    }
}

-(void) showHelpView:(NSNotification *) notification    {
    if ([[notification name] isEqualToString:@"helpOverlayView"]) {
        OverlayView *overlayVC = [OverlayView overlayView];
        overlayVC.internalHelpView.alpha = 1;
        self.view.bounds = overlayVC.bounds;
        [self.view addSubview:overlayVC];
        [self stretchToSuperView:self.view];
        self.overlayView = overlayVC;
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showHelpView:) name:@"helpOverlayView" object:nil];

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeOverlay:) name:@"removeOverlay" object:nil];

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

/*ensures that the view added streches properly to the screen*/
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
    overlayVC.eventTitle.text = [Data sharedInstance].createdEvent.eventDescription; //eventTitle;
    overlayVC.eventText.text = [Data sharedInstance].createdEvent.eventDescription; //textBody;
    [overlayVC.internalView setTag:tag];
    self.view.bounds = overlayVC.bounds;
    [self.view addSubview:overlayVC];
    [self stretchToSuperView:self.view];
    self.overlayView = overlayVC;
}

-(void) setNavigationButtonFontAndSize  {
    
    NSDictionary *attributes = [ViewSetupHelper setNavigationButtonFontAndSize];
    
    [_saveButton setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    [_cancelButton setTitleTextAttributes:attributes forState:UIControlStateNormal];
}

@end
