//
//  CreateCollectionViewCell.m
//  Why Go Solo
//
//  Created by Izzy on 03/10/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "CreateCollectionViewCell.h"

@implementation CreateCollectionViewCell

-(void)awakeFromNib {
    [self placeholderEventTextView];
    
    self.describeEventTextView.delegate = self;
    
    //create circular emoji view
    _circularView.layer.cornerRadius = _circularView.bounds.size.width/2;
    _circularView.layer.masksToBounds = YES;
    
    [self createEmojiView];
}

#pragma mark - Text View Delegates

/** Adds the 140 Chracter limit */
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text    {
    return textView.text.length + (text.length - range.length) <= 140;
}

- (void)textViewDidEndEditing:(UITextView *)textView    {
    [self.describeEventTextView resignFirstResponder]; // get rid of the keybaord
}

-(void) textViewDidChange:(UITextView *)textView
{
    
    if(self.describeEventTextView.text.length == 0){
        self.describeEventTextView.text = @"Placeholder!"; //load up previous description if empty
        [self.describeEventTextView resignFirstResponder];
    }
}

/** creates the placeholder effect*/
-(void) placeholderEventTextView    {
    self.describeEventTextView.delegate = self;
    self.describeEventTextView.text = @"This is the event description from the previous event";
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if (_describeEventTextView.text.length == 0) {
        [self placeholderEventTextView];
    } else  {
        _describeEventTextView.text = @"";
        _describeEventTextView.textColor = [UIColor blackColor];
        return YES;
    }
    
    return YES;
}

#pragma mark - Action Method

- (IBAction)addEmojiButtonPressed:(UIButton *)sender {
    [self.emojiTextView becomeFirstResponder];    
}

- (IBAction)eventSwitch:(UISwitch *)sender {
    if (sender.on) {
        NSLog(@"Activate Privacy: %d", sender.on);
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"publicPrivate"]; //YES
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Privacy Mode" object:self];
        self.publicPrivateLabel.text = @"Private Event";
        
    } else  {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"publicPrivate"]; //NO
        NSLog(@"Public Mode, Hide TableView: %d", sender.on);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Privacy Mode" object:self];
        self.publicPrivateLabel.text = @"Public";
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
    
    NSString *emojiUTF8 = [NSString stringWithUTF8String:[self.emojiTextView.text UTF8String]];
    NSData *emojiData = [emojiUTF8 dataUsingEncoding:NSNonLossyASCIIStringEncoding];
    NSString *emojiString = [[NSString alloc] initWithData:emojiData encoding:NSUTF8StringEncoding];
    
    NSLog(@"EMOJI TEXT = %@", emojiString);
}


-(void)emojiView:(ISEmojiView *)emojiView didPressDeleteButton:(UIButton *)deletebutton{
    if (self.emojiTextView.text.length > 0) {
        NSRange lastRange = [self.emojiTextView.text rangeOfComposedCharacterSequenceAtIndex:self.emojiTextView.text.length-1];
        self.emojiTextView.text = [self.emojiTextView.text substringToIndex:lastRange.location];
    }
}

@end
