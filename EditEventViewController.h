//
//  EditEventViewController.h
//  Why Go Solo
//
//  Created by Izzy on 29/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FontSetup.h"
#import "ISEmojiView.h"
#import "CustomerCollectionViewCell.h"
#import "HeaderCollectionReusableView.h"


@interface EditEventViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UITextView *eventDescriptionInput;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *publicPrivateLabel;

@end
