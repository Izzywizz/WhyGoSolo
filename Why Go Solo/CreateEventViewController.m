//
//  CreateEventViewController.m
//  Why Go Solo
//
//  Created by Izzy on 21/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "CreateEventViewController.h"
#import "ISEmojiView.h"


@interface CreateEventViewController () <UITextViewDelegate, UITextFieldDelegate, ISEmojiViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *eventDescriptionInput;
@property (weak, nonatomic) IBOutlet UIImageView *addEmojiImage;
@property (weak, nonatomic) IBOutlet UIView *circularView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextButton;
@property (weak, nonatomic) IBOutlet UITextView *emojiTextView;

@property BOOL isPrivateEvent;
@property NSString *placeholderEventText;

@end

@implementation CreateEventViewController

#pragma mark - UI Vierw Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self placeholderTextViewSetup];
    [self NavigationButtonSetup];
    
    _placeholderEventText = @"Describe your event in less than 140 characters, don’t forget to include the time....";
    
    //Intially private mode is off thus the tableView has been hidden
    self.tableView.alpha = 0;
    
    _circularView.layer.cornerRadius = _circularView.bounds.size.width/2; //create circular profile view
    _circularView.layer.masksToBounds = YES;
    
    //Removes the carret I animation
    self.emojiTextView.tintColor = [UIColor clearColor];
    // init ISEmojiView
    ISEmojiView *emojiView = [[ISEmojiView alloc] initWithTextField:self.emojiTextView delegate:self];
    self.emojiTextView.inputView = emojiView;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Emoji Methods

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
    
//    [[self.emojiTextView valueForKey:@"textInputTraits"] setValue:[UIColor clearColor] forKey:@"insertionPointColor"];
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
        _eventDescriptionInput.text = @"Comment";
        [_eventDescriptionInput resignFirstResponder];
    }
}

#pragma mark - Actions Methods
- (IBAction)eventSwitch:(UISwitch *)sender {
    if (sender.on) {
        NSLog(@"Activate Privacy");
        self.tableView.alpha = 1;
        _isPrivateEvent = YES;
    } else  {
        NSLog(@"Public Mode, Hide TableView");
        self.tableView.alpha = 0;
        _isPrivateEvent = NO;
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
}

@end
