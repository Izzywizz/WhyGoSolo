//
//  EditEventViewController.h
//  Why Go Solo
//
//  Created by Izzy on 29/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewSetupHelper.h"
#import "ISEmojiView.h"
#import "FriendCollectionViewCell.h"
#import "HeaderCollectionReusableView.h"
#import "MapViewController.h"



@interface EditEventViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UITextView *eventDescriptionInput;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *publicPrivateLabel;
@property (weak, nonatomic) IBOutlet UIView *overlayView;
@property (weak, nonatomic) IBOutlet UIView *helpView;

@end
