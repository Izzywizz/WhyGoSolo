//
//  CommentsTableViewCell.m
//  Why Go Solo
//
//  Created by Izzy on 07/10/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "CommentsTableViewCell.h"
#import "Comment.h"
#import "User.h"
#import "RRDownloadImage.h"
#import "Data.h"
#import "Event.h"

@implementation CommentsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    /*Setup logic to fake whether its a user own comment or something they can delete*/
    if (_reportButton.tag == 0) {
        NSLog(@"Report Button");
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)reportButtonPressed:(UIButton *)sender {
    NSLog(@"Reported");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reportUserComment" object:self];
}

- (IBAction)deleteButtonPressed:(UIButton *)sender {
    NSLog(@"DELETED");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"deleteUserComment" object:self];
}


-(CommentsTableViewCell*)configureCellWithCommentForTableView:(UITableView*)tableView atIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.row % 2) {
        [self setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        [self.profileImage setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        self.reportButton.tag = 0;
        
    } else  {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self.profileImage setBackgroundColor:[UIColor whiteColor]];
        
        //Example logic of user own profile to create the delete comment functionality for the user, so this shows the deete button for the white background comment
        self.reportButton.alpha = 0;
        self.deleteButton.alpha = 1;
    }
    
    self.comment = [[Data sharedInstance].selectedEvent.commentsArray objectAtIndex:indexPath.row];

    self.userInputext.text = self.comment.commentText;
    self.profileName.text = self.comment.commentUser.userName;
    self.timeLabel.text = [NSString stringWithFormat:@"%i",self.comment.epochCreated];
    self.profileImage.image = [[RRDownloadImage sharedInstance]avatarImageForUserID:self.comment.userID];
    
    return self;
}

/*

@property (weak, nonatomic) IBOutlet UILabel *profileName;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *userInputext;
@property (weak, nonatomic) IBOutlet UIButton *reportButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
 */
@end
