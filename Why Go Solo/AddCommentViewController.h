//
//  AddCommentViewController.h
//  Why Go Solo
//
//  Created by Izzy on 07/10/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddCommentViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *commentsTextView;
@property (nonatomic) NSString *userComments;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UILabel *charCount;

@end
