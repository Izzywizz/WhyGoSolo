//
//  SetupProfileTableViewController.m
//  Why Go Solo
//
//  Created by Izzy on 15/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "SetupProfileTableViewController.h"

@interface SetupProfileTableViewController ()<UIImagePickerControllerDelegate>

@end

@implementation SetupProfileTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _roundImageUploadView.layer.cornerRadius = _roundImageUploadView.bounds.size.width/2; //create circular profile view
    _roundImageUploadView.layer.masksToBounds = YES;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero]; // Prevents the tableView from drawing any more empty unused cells
    [self setNavigationButtonFontAndSize];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Helper Functions
/** Ensures that the selection seperators are setup before the main views are shown*/
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void) setNavigationButtonFontAndSize  {
    
    NSDictionary *attributes = [FontSetup setNavigationButtonFontAndSize];

    [_nextButton setTitleTextAttributes:attributes forState:UIControlStateNormal];
}

- (void)selectPhoto {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.profileImageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

#pragma mark - Table view data source


/** Allows the cell selection seperators (the grey line across the tableView Cell) to extend across the entire table view */
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


#pragma mark - Action Methods

- (IBAction)uploadPhotoButton:(UIButton *)sender {
    NSLog(@"Upload Photo");
    [self selectPhoto];
}

- (IBAction)backButtonPressed:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)nextButtonPressed:(UIBarButtonItem *)sender {
    NSLog(@"Next Button Pressed");
}

@end
