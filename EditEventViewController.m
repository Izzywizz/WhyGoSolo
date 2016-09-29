//
//  EditEventViewController.m
//  Why Go Solo
//
//  Created by Izzy on 29/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "EditEventViewController.h"

@interface EditEventViewController () <UITextViewDelegate, UITextFieldDelegate, ISEmojiViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *circularView;
@property (weak, nonatomic) IBOutlet UIImageView *addEmojiImage;
@property (weak, nonatomic) IBOutlet UITextView *emojiTextView;


@property NSString *placeholderEventText;

@end

@implementation EditEventViewController

#pragma mark - UI Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationButtonSetup];
    [self previousEventTextViewSetup];
    
    
    //This text is activated when the user hsa no text within their, so they bascially delete all their text.
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

#pragma mark - Helper Methods

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

- (IBAction)backButtonPressed:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender {
    NSLog(@"Save Button Pressed");
}

- (IBAction)helpButtonPressed:(UIButton *)sender {
    NSLog(@"Help Button Pressed");
}
- (IBAction)closeEventButtonPressed:(UIButton *)sender {
    NSLog(@"Close Event Pressed");
}
- (IBAction)cancelEventButtonPressed:(UIButton *)sender {
    NSLog(@"Cancel Event Pressed");
}

- (IBAction)changeLocationButton:(UIButton *)sender {
    NSLog(@"Changin Location button pressed");
}

- (IBAction)addEmojiImage:(UIButton *)sender {
    NSLog(@"Add Emoji Button");
    [self.emojiTextView becomeFirstResponder];
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


@end
