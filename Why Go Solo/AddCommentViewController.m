//
//  AddCommentViewController.m
//  Why Go Solo
//
//  Created by Izzy on 07/10/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "AddCommentViewController.h"

@interface AddCommentViewController ()<UITextViewDelegate>

@end

@implementation AddCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self placeholderTextView];

    _activityIndicator.hidden = YES;
}

-(void)viewWillAppear:(BOOL)animated    {
    //Keybaord appear straight away
    //    [_commentsTextView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backButtonPressed:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - TextView Delegate Methods

/** Adds the 140 Chracter limit */
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text    {
    return textView.text.length + (text.length - range.length) <= 140; //Character limit
}

- (void)textViewDidEndEditing:(UITextView *)textView    {
    [self.commentsTextView resignFirstResponder]; // get rid of the keybaord
}

- (void)textViewDidChange:(UITextView *)textView    {
    _charCount.text =  [NSString stringWithFormat:@"%lu", (unsigned long)textView.text.length];
    if (textView.text.length != 140) {
        _charCount.textColor = [UIColor blueColor];
    } else {
        _charCount.textColor = [UIColor redColor];
    }
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if (_commentsTextView.text.length == 0) {
        [self placeholderTextView];
    } else  {
        _commentsTextView.text = @"";
        _commentsTextView.textColor = [UIColor blackColor];
        return YES;
    }
    
    return YES;
}

/** creates the placeholder effect*/
-(void) placeholderTextView    {
    self.commentsTextView.delegate = self;
    self.commentsTextView.text = @"Please enter a comment...";
    _commentsTextView.textColor = [UIColor lightGrayColor];
    
}

#pragma mark - Action Methods
- (IBAction)sendButtonPressed:(UIButton *)sender {
    NSLog(@"SEnding");
    _sendButton.alpha = 0;
    _activityIndicator.hidden = NO;
    [self.activityIndicator startAnimating];
    if ([_activityIndicator isAnimating]) {
        [_activityIndicator performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:3.0];
        [self performSelector:@selector(goBack) withObject:nil afterDelay:3.0];
    }
}


-(void) goBack  {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
