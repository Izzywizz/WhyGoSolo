//
//  CreateCollectionViewCell.h
//  Why Go Solo
//
//  Created by Izzy on 03/10/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISEmojiView.h"


@interface CreateCollectionViewCell : UICollectionViewCell <UITextViewDelegate, UITextFieldDelegate, ISEmojiViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *describeEventTextView;
@property (weak, nonatomic) IBOutlet UIView *circularView;
@property (weak, nonatomic) IBOutlet UIImageView *addEmojiImage;
@property (weak, nonatomic) IBOutlet UITextView *emojiTextView;
@property (weak, nonatomic) IBOutlet UILabel *publicPrivateLabel;
@property (weak, nonatomic) IBOutlet UILabel *charCount;

@end
