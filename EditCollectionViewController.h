//
//  EditCollectionViewController.h
//  Why Go Solo
//
//  Created by Izzy on 30/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendCollectionViewCell.h"
#import "HeaderCollectionReusableView.h"
#import "EditCellCollectionViewCell.h"
#import "MapViewController.h"
#import "FontSetup.h"



@interface EditCollectionViewController : UICollectionViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@end
