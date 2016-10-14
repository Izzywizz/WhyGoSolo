//
//  EditCellCollectionViewCell.h
//  Why Go Solo
//
//  Created by Izzy on 30/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISEmojiView.h"
#import "MapViewController.h"
#import "OverlayView.h"



@interface EditCellCollectionViewCell : UICollectionViewCell <UITextViewDelegate, UITextFieldDelegate, ISEmojiViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *charCount;
@property (weak, nonatomic) IBOutlet UIButton *helpButton;
@property (weak, nonatomic) IBOutlet UIButton *closeEvent;
@property (weak, nonatomic) IBOutlet UIButton *cancelEvent;
@property (weak, nonatomic) IBOutlet UIButton *changeLocation;
@property (weak, nonatomic) IBOutlet UITextView *describeEventTextView;
@property (weak, nonatomic) IBOutlet UIView *circularView;
@property (weak, nonatomic) IBOutlet UIImageView *addEmojiImage;
@property (weak, nonatomic) IBOutlet UITextView *emojiTextView;
@property (weak, nonatomic) IBOutlet UILabel *publicPrivateLabel;

@end
