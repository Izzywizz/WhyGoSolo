//
//  CreateEventViewController.m
//  Why Go Solo
//
//  Created by Izzy on 21/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "CreateEventViewController.h"

@interface CreateEventViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *eventDescriptionInput;
@property (weak, nonatomic) IBOutlet UIImageView *addEmojiImage;
@property (weak, nonatomic) IBOutlet UIView *circularView;

@end

@implementation CreateEventViewController

#pragma mark - UI Vierw Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self placeholderTextViewSetup];
    _circularView.layer.cornerRadius = _circularView.bounds.size.width/2; //create circular profile view
    _circularView.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helper Functions

/** creates the placeholder effect*/
-(void) placeholderTextViewSetup    {
    _eventDescriptionInput.delegate = self;
    _eventDescriptionInput.text = @"Describe your event in less than 140 characters, don’t forget to include the time....";
    _eventDescriptionInput.textColor = [UIColor lightGrayColor];
}

#pragma mark - Text View Delegates
/** Removes placeholder text and clears the user to write their own text*/
-(BOOL) textViewShouldBeginEditing:(UITextView *)textView   {
    _eventDescriptionInput.text = @"";
    _eventDescriptionInput.textColor = [UIColor blackColor];
    return YES;
}

/** Adds the 140 Chracter limit */
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text    {
    return textView.text.length + (text.length - range.length) <= 140;
}

#pragma mark - Actions Methods
- (IBAction)eventSwitch:(UISwitch *)sender {
    NSLog(@"isPublicEvent: %d", sender.on);
}

- (IBAction)emojiButtonPressed:(UIButton *)sender {
    NSLog(@"Insert emoji");
}

@end
