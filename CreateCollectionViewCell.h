//
//  CreateCollectionViewCell.h
//  Why Go Solo
//
//  Created by Izzy on 03/10/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UITextView *describeEventTextView;
@property (weak, nonatomic) IBOutlet UIView *circularView;
@property (weak, nonatomic) IBOutlet UIButton *addEmojiImage;
@property (weak, nonatomic) IBOutlet UITextView *emojiTextView;
@property (weak, nonatomic) IBOutlet UIImageView *publicPrivateLabel;

@end
