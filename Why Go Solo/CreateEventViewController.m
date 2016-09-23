//
//  CreateEventViewController.m
//  Why Go Solo
//
//  Created by Izzy on 21/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "CreateEventViewController.h"
#import "ISEmojiView.h"
#import "CustomerCollectionViewCell.h"
#import "HeaderCollectionReusableView.h"
#import "MapViewController.h"

@interface CreateEventViewController () <UITextViewDelegate, UITextFieldDelegate, ISEmojiViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *eventDescriptionInput;
@property (weak, nonatomic) IBOutlet UIImageView *addEmojiImage;
@property (weak, nonatomic) IBOutlet UIView *circularView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextButton;
@property (weak, nonatomic) IBOutlet UITextView *emojiTextView;
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;

@property BOOL isPrivateEvent;
@property NSString *placeholderEventText;
@property NSString *privateText;
@property NSString *publicText;

@property NSArray *dummyData;
@property NSArray *sectionTitles;

@end

@implementation CreateEventViewController

#pragma mark - UI Vierw Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createDummyData];
    
    //Register The Nib for the collection cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    //Add padding betweeen the section headers
    UICollectionViewFlowLayout *collectionViewLayout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    collectionViewLayout.sectionInset = UIEdgeInsetsMake(20, 0, 20, 0);
    
    [self placeholderTextViewSetup];
    [self NavigationButtonSetup];
    
    _placeholderEventText = @"Describe your event in less than 140 characters, don’t forget to include the time....";
    _privateText = @"PRIVATE EVENT";
    _publicText = @"PUBLIC EVENT";
    
    //Intially private mode is off thus the tableView has been hidden
    self.collectionView.hidden = YES;

    //create circular profile view
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

#pragma mark - Helper Functions

-(void) NavigationButtonSetup   {
    
    NSDictionary *attributes = [NSDictionary new];
    attributes = [FontSetup setNavigationButtonFontAndSize];
    
    [_nextButton setTitleTextAttributes:attributes forState:UIControlStateNormal];
}

/** creates the placeholder effect*/
-(void) placeholderTextViewSetup    {
    _eventDescriptionInput.delegate = self;
    _eventDescriptionInput.text = @"Describe your event in less than 140 characters, don’t forget to include the time....";
    _eventDescriptionInput.textColor = [UIColor lightGrayColor];
}

#pragma mark - Text View Delegates
/** Removes placeholder text and clears the user to write their own text*/
-(BOOL) textViewShouldBeginEditing:(UITextView *)textView   {
    
    if ([_eventDescriptionInput.text isEqualToString:_placeholderEventText]) {
        _eventDescriptionInput.text = @"";
        _eventDescriptionInput.textColor = [UIColor blackColor];
    }
    
    return YES;
}


/** Adds the 140 Chracter limit */
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text    {
    return textView.text.length + (text.length - range.length) <= 140;
}

- (void)textViewDidEndEditing:(UITextView *)textView    {
    
    [_eventDescriptionInput resignFirstResponder];
}

-(void) textViewDidChange:(UITextView *)textView
{
    
    if(_eventDescriptionInput.text.length == 0){
        _eventDescriptionInput.textColor = [UIColor lightGrayColor];
        _eventDescriptionInput.text = _placeholderEventText; //@"COMMENTS"
        [_eventDescriptionInput resignFirstResponder];
    }
}

#pragma mark - Actions Methods
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

- (IBAction)emojiButtonPressed:(UIButton *)sender {
    NSLog(@"Insert emoji");
    [self.emojiTextView becomeFirstResponder];
}
- (IBAction)backButtonPressed:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)nextButtonPressed:(UIBarButtonItem *)sender {
    NSLog(@"NEXT Button PRessed");
    //TODO: Need to implement the MAP feature.
    [self performSegueWithIdentifier:@"GoToAddMap" sender:self];

}


#pragma mark - Prepare Segue
/** This method */

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"GoToAddMap"]) {
        NSLog(@"TEST segue
              ");
        // Get reference to the destination view controller
        MapViewController *vc = [segue destinationViewController];
        vc.doneOrNextButton.title = @"POST";
        [vc.doneOrNextButton setTag:100];
    }
}

@end
