//
//  EditCellCollectionViewCell.m
//  Why Go Solo
//
//  Created by Izzy on 30/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "EditCellCollectionViewCell.h"

@implementation EditCellCollectionViewCell

-(void)awakeFromNib {
    [self previousEventTextViewSetup];
    
    self.describeEventTextView.delegate = self;
    
    //create circular emoji view
    _circularView.layer.cornerRadius = _circularView.bounds.size.width/2;
    _circularView.layer.masksToBounds = YES;
    
    [self createEmojiView];
    _cancelEvent.layer.cornerRadius = 3;
    _closeEvent.layer.cornerRadius = 3;
}

#pragma mark - Action Methods (Target)
- (IBAction)helpButtonPressed:(UIButton *)sender {
    NSLog(@"Help Button Pressed");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"helpOverlayView" object:self];
}

- (IBAction)closeEventButtonPressed:(UIButton *)sender {
    NSLog(@"Close");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"closeOverlayView" object:self];
}
- (IBAction)cancelEventButtonPressed:(UIButton *)sender {
    NSLog(@"Cancel");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"cancelOverlayView" object:self];

}
- (IBAction)changeLocationButtonPressed:(UIButton *)sender {
    NSLog(@"Change Location (Locally)");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeLocation" object:self];
}
- (IBAction)addEmojiButtonPressed:(UIButton *)sender {
    [self.emojiTextView becomeFirstResponder];
}
- (IBAction)eventSwitch:(UISwitch *)sender {
    if (sender.on) {
        NSLog(@"Activate Privacy: %d", sender.on);
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"publicPrivate"]; //YES
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Privacy Mode" object:self];
        self.publicPrivateLabel.text = @"PRIVATE EVENT - VISABLE BY n(x)";

    } else  {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"publicPrivate"]; //NO
        NSLog(@"Public Mode, Hide TableView: %d", sender.on);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Privacy Mode" object:self];
        self.publicPrivateLabel.text = @"PUBLIC EVENT";
    }
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
-(void) previousEventTextViewSetup    {
    self.describeEventTextView.delegate = self;
    self.describeEventTextView.text = @"This is the event description from the previous event";
}

/**This method is called when the user touches the background and resigns the keybaord*/
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan:withEvent:");
    [self endEditing:YES];
    [super touchesBegan:touches withEvent:event];
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
