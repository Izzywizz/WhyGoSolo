//
//  RRCircularImageView.m
//  Why Go Solo
//
//  Created by Andy Chamberlain on 30/10/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "RRCircularImageView.h"

@implementation RRCircularImageView


- (void)awakeFromNib {
    [super awakeFromNib];
    [self loadPhoto];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self customizationImageView];
}

- (void)customizationImageView {
    self.layer.borderWidth = 2.0f;
    self.layer.cornerRadius = self.frame.size.width / 2;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.backgroundColor = [UIColor clearColor];
    self.layer.masksToBounds = YES;
    self.clipsToBounds = YES;
    //NSLog(@"xx");
}

- (void)loadPhoto {
    //    NSData *lImageData = nil;//GET_VALUE(PROFILE_PHOTO);
    UIImage *lImage = [UIImage imageNamed:@"white-logo-125-125"];//[UIImage imageWithData:lImageData];
    
    NSMutableData *iDat = [[NSMutableData alloc] initWithData:UIImagePNGRepresentation(lImage)];
    
    self.image = [UIImage imageWithCGImage:[UIImage imageWithData:iDat].CGImage
                                     scale:lImage.scale
                               orientation:0];
}
@end
