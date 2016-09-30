//
//  EditEventViewController.m
//  Why Go Solo
//
//  Created by Izzy on 29/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "EditViewController.h"

@interface EditEventViewController () <UITextViewDelegate, UITextFieldDelegate, ISEmojiViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *circularView;
@property (weak, nonatomic) IBOutlet UIImageView *addEmojiImage;
@property (weak, nonatomic) IBOutlet UITextView *emojiTextView;

@property (weak, nonatomic) IBOutlet UILabel *overlayTitle;
@property (weak, nonatomic) IBOutlet UILabel *overlayDescription;

@property (weak, nonatomic) IBOutlet UIButton *yesButton;

@property NSString *placeholderEventText;
@property BOOL isPrivateEvent;

@property NSString *privateText;
@property NSString *publicText;
@property NSArray *dummyData;
@property NSArray *sectionTitles;
@end

@implementation EditEventViewController

#pragma mark - UI Methods

-(void)viewWillAppear:(BOOL)animated    {
    [self closeCancelOverlayAlpha:0 animationDuration:0.0f];//Hide the overlay
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createDummyData];
    [self navigationButtonSetup];
    [self previousEventTextViewSetup];
    
    
    //Register The Nib for the collection cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    //Add padding betweeen the section headers
    UICollectionViewFlowLayout *collectionViewLayout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    collectionViewLayout.sectionInset = UIEdgeInsetsMake(20, 0, 20, 0);
    
    //Setting up the labels within the collection view
    _privateText = @"PRIVATE EVENT";
    _publicText = @"PUBLIC EVENT";
    
    //Intially private mode is off thus the tableView has been hidden
    self.collectionView.hidden = YES;
    
    //create circular profile view
    _circularView.layer.cornerRadius = _circularView.bounds.size.width/2;
    _circularView.layer.masksToBounds = YES;
    
    //This text is activated when the user has no text within their event, so they bascially delete all their text.
    _placeholderEventText = @"Describe your event in less than 140 characters, don’t forget to include the time....";
    
    //create circular emoji view
    _circularView.layer.cornerRadius = _circularView.bounds.size.width/2;
    _circularView.layer.masksToBounds = YES;
    
    [self createEmojiView];
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
    self.dummyData = [NSArray arrayWithObjects:mainDishImages, drinkDessertImages, nil];
    
    _sectionTitles = [[NSArray alloc] init];
    _sectionTitles = @[@"FRIENDS", @"EVERYONE"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[self.dummyData objectAtIndex:section] count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.dummyData count]; //2
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"Cell";
    
    CustomerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.profileImageView.image = [UIImage imageNamed:[self.dummyData[indexPath.section] objectAtIndex:indexPath.row]];
    
    return cell;
    
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


#pragma mark - Helper Methods

-(void)closeCancelOverlayAlpha:(int)a animationDuration:(float)duration
{
    [UIView animateWithDuration:duration delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        for (id x in _overlayView.subviews)
        {
            if ([x class] == [UIView class])
            {
                [(UIView*)x setAlpha:a];
            }
        }
        _overlayView.alpha = a;
    } completion:nil];
}

-(void) navigationButtonSetup   {
    
    NSDictionary *attributes = [NSDictionary new];
    attributes = [FontSetup setNavigationButtonFontAndSize];
    
    [_saveButton setTitleTextAttributes:attributes forState:UIControlStateNormal];
}

/** creates the placeholder effect*/
-(void) previousEventTextViewSetup    {
    _eventDescriptionInput.delegate = self;
    _eventDescriptionInput.text = @"This is the event description from the presvious event";
    //    _eventDescriptionInput.textColor = [UIColor lightGrayColor];
}

#pragma mark - ACtion Methods

- (IBAction)eventSwitch:(UISwitch *)sender {
    if (sender.on) {
        NSLog(@"Activate Privacy");
        self.collectionView.hidden = NO;
        _isPrivateEvent = YES;
        self.publicPrivateLabel.text = self.privateText;
    } else  {
        NSLog(@"Public Mode, Hide TableView");
        self.collectionView.hidden = YES;
        _isPrivateEvent = NO;
        self.publicPrivateLabel.text = self.publicText;
        
    }
}

- (IBAction)okHelpButtonPressed:(UIButton *)sender {
    [self closeCancelOverlayAlpha:0 animationDuration:0.2f];
    _helpView.alpha = 0;
}


- (IBAction)backButtonPressed:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender {
    NSLog(@"Save Button Pressed");
}

- (IBAction)helpButtonPressed:(UIButton *)sender {
    NSLog(@"Help Button Pressed");
    [self closeCancelOverlayAlpha:1 animationDuration:0.2f];
    _helpView.alpha = 1;
}

- (IBAction)closeEventButtonPressed:(UIButton *)sender {
    NSLog(@"Close Event Pressed");
    self.yesButton.tag = 0;
    [self closeCancelOverlayAlpha:1 animationDuration:0.2f];
    _helpView.alpha = 0;
}

- (IBAction)cancelEventButtonPressed:(UIButton *)sender {
    NSLog(@"Cancel Event Pressed");
    self.overlayTitle.text = @"Cancel Event";
    self.overlayDescription.text = @"Are you sure you want to cancel your event?";
    self.yesButton.tag = 1; //Change the tag to create different functionality based on it.
    [self closeCancelOverlayAlpha:1 animationDuration:0.2f];
    _helpView.alpha = 0;
}

- (IBAction)changeLocationButton:(UIButton *)sender {
    NSLog(@"Changin Location button pressed");
}

- (IBAction)addEmojiImage:(UIButton *)sender {
    NSLog(@"Add Emoji Button");
    [self.emojiTextView becomeFirstResponder];
}
- (IBAction)yesButton:(UIButton *)sender {
    if (sender.tag == 1) {
        NSLog(@"Cancel Button Overlay activated");
    } else  {
        NSLog(@"Close Button Overlay activated");
    }
}
- (IBAction)noButton:(UIButton *)sender {
    [self closeCancelOverlayAlpha:0 animationDuration:0.0f];//Hide the overlay
}

#pragma mark - Text View Delegates

/** Adds the 140 Chracter limit */
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text    {
    return textView.text.length + (text.length - range.length) <= 140;
}

- (void)textViewDidEndEditing:(UITextView *)textView    {
    [_eventDescriptionInput resignFirstResponder]; // get rid of the keybaord
}

-(void) textViewDidChange:(UITextView *)textView
{
    
    if(_eventDescriptionInput.text.length == 0){
//        _eventDescriptionInput.textColor = [UIColor lightGrayColor];
        _eventDescriptionInput.text = _placeholderEventText; //load up previous description if empty
        [_eventDescriptionInput resignFirstResponder];
    }
}

#pragma mark - Emoji Methods

-(void) createEmojiView {
    //Removes the carret I animation
    self.emojiTextView.tintColor = [UIColor clearColor];
    // init ISEmojiView
    ISEmojiView *emojiView = [[ISEmojiView alloc] initWithTextField:self.emojiTextView delegate:self];
    self.emojiTextView.inputView = emojiView;
}

-(void)emojiView:(ISEmojiView *)emojiView didSelectEmoji:(NSString *)emoji{
    if (self.emojiTextView.text == nil) {
        self.emojiTextView.text = [self.emojiTextView.text stringByAppendingString:emoji];
    } else  {
        self.emojiTextView.text = @"";
        self.emojiTextView.text = [self.emojiTextView.text stringByAppendingString:emoji];
    }
    // As soon as the user selects an emoji it hides the keyboard
    [self.emojiTextView resignFirstResponder];
    self.emojiTextView.font = [UIFont systemFontOfSize:52.0];
    self.addEmojiImage.hidden = YES;
    
}


-(void)emojiView:(ISEmojiView *)emojiView didPressDeleteButton:(UIButton *)deletebutton{
    if (self.emojiTextView.text.length > 0) {
        NSRange lastRange = [self.emojiTextView.text rangeOfComposedCharacterSequenceAtIndex:self.emojiTextView.text.length-1];
        self.emojiTextView.text = [self.emojiTextView.text substringToIndex:lastRange.location];
    }
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


@end
