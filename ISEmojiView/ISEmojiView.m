//
//  ISEmojiView.m
//  ISEmojiViewSample
//
//  Created by isaced on 14/12/25.
//  Copyright (c) 2014 Year isaced. All rights reserved.
//

#import "ISEmojiView.h"

static const CGFloat EmojiWidth = 53;
static const CGFloat EmojiHeight = 50;
static const CGFloat EmojiFontSize = 32;

@interface ISEmojiView()<UIScrollViewDelegate>

/**
 *  All emoji characters
 */
@property (nonatomic, strong) NSArray *emojis;

@end

@implementation ISEmojiView

- (CGRect)defaultFrame {
    return CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 216);
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUIWithFrame:frame];
    }
    return self;
}

-(instancetype)initWithTextField:(UIView *)textField delegate:(id<ISEmojiViewDelegate>)delegate {
    self = [super init];
    if (self) {        
        self.delegate = delegate;
        self.textField = textField;
    }
    return self;
}

- (void)initUIWithFrame:(CGRect)frame {
    if (CGRectEqualToRect(frame, CGRectZero)) {
        frame = [self defaultFrame];
    }
    
    self.frame = frame;
    
    // init emojis
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"ISEmojiList" ofType:@"plist"];
    self.emojis = [NSArray arrayWithContentsOfFile:plistPath];
    
    //
    NSInteger rowNum = (CGRectGetHeight(frame) / EmojiHeight);
    NSInteger colNum = (CGRectGetWidth(frame) / EmojiWidth);
    NSInteger numOfPage = ceil((float)[self.emojis count] / (float)(rowNum * colNum));
    
    if (rowNum == 0 && colNum == 0) {
        return;
    }
    
    // init scrollview
    self.scrollView = [[UIScrollView alloc] initWithFrame:frame];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(frame) * numOfPage,
                                             CGRectGetHeight(frame));
    [self addSubview:self.scrollView];
    
    // add emojis
    
    NSInteger row = 0;
    NSInteger column = 0;
    NSInteger page = 0;
    
    NSInteger emojiPointer = 0;
    for (int i = 0; i < [self.emojis count] + numOfPage - 1; i++) {
        
        // Pagination
        if (i % (rowNum * colNum) == 0) {
            page ++;    // Increase the number of pages
            row = 0;    // the number of lines is 0
            column = 0; // the number of columns is 0
        }else if (i % colNum == 0) {
            // NewLine
            row += 1;   // Increase the number of lines
            column = 0; // The number of columns is 0
        }
        
        //Change this page value
        CGRect currentRect = CGRectMake(((page - 1) * frame.size.width) + (column * EmojiWidth),
                                        row * EmojiHeight,
                                        EmojiWidth,
                                        EmojiHeight);
        
        if (row == (rowNum - 1) && column == (colNum - 1)) {
            // last position of page, add delete button
            
            ISDeleteButton *deleteButton = [ISDeleteButton buttonWithType:UIButtonTypeCustom];
            [deleteButton addTarget:self action:@selector(deleteButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            deleteButton.frame = currentRect;
            deleteButton.tintColor = [UIColor blackColor];
            [self.scrollView addSubview:deleteButton];
            
        }else{
            NSString *emoji = self.emojis[emojiPointer++];
            
            // init Emoji Button
            UIButton *emojiButton = [UIButton buttonWithType:UIButtonTypeCustom];
            emojiButton.titleLabel.font = [UIFont fontWithName:@"Apple color emoji" size:EmojiFontSize];
            [emojiButton setTitle:emoji forState:UIControlStateNormal];
            [emojiButton addTarget:self action:@selector(emojiButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            
            emojiButton.frame = currentRect;
            [self.scrollView addSubview:emojiButton];
        }
        
        column++;
    }
    
    // add PageControl
    self.pageControl = [[UIPageControl alloc] init];
    self.pageControl.hidesForSinglePage = YES;
    self.pageControl.currentPage = 0;
    self.pageControl.backgroundColor = [UIColor clearColor];
    self.pageControl.numberOfPages = numOfPage;
    CGSize pageControlSize = [self.pageControl sizeForNumberOfPages:numOfPage];
    self.pageControl.frame = CGRectMake(CGRectGetMidX(frame) - (pageControlSize.width / 2),
                                        CGRectGetHeight(frame) - pageControlSize.height + 5,
                                        pageControlSize.width,
                                        pageControlSize.height);
    [self.pageControl addTarget:self action:@selector(pageControlTouched:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.pageControl];
    
    // default allow animation
    self.popAnimationEnable = YES;
    
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
}

#pragma mark Action

- (void)pageControlTouched:(UIPageControl *)sender {
    CGRect bounds = self.scrollView.bounds;
    bounds.origin.x = CGRectGetWidth(bounds) * sender.currentPage;
    [self.scrollView scrollRectToVisible:bounds animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth = CGRectGetWidth(scrollView.frame);
    NSInteger newPageNumber = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    if (self.pageControl.currentPage == newPageNumber) {
        return;
    }
    self.pageControl.currentPage = newPageNumber;
}

- (void)emojiButtonPressed:(UIButton *)button {
    
    // Add a simple scale animation
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.byValue = @0.3;
    animation.duration = 0.1;
    animation.autoreverses = YES;
    [button.layer addAnimation:animation forKey:nil];

    if (self.popAnimationEnable) {
        // Animation emojibutton
        UIButton *animationEmojiButton = [UIButton buttonWithType:UIButtonTypeCustom];;
        [animationEmojiButton setTitle: [button titleForState:UIControlStateNormal] forState:UIControlStateNormal];
        animationEmojiButton.titleLabel.font = [UIFont fontWithName:@"Apple color emoji" size:EmojiFontSize];
        
        // Conver frame from scrollview to self and add to self
        animationEmojiButton.frame = [button.superview convertRect:button.frame toView:self];
        [self addSubview:animationEmojiButton];
        
        // get animation traget position from textField view
        CGPoint newPoint = [self.textField convertPoint:self.textField.center toView:self];
        [UIView animateWithDuration:0.3 animations:^{
            animationEmojiButton.center = newPoint;
            animationEmojiButton.alpha = 0;
        } completion:^(BOOL finished) {
            if (finished) {
                // Callback
                if ([self.delegate respondsToSelector:@selector(emojiView:didSelectEmoji:)]) {
                    [self.delegate emojiView:self didSelectEmoji:button.titleLabel.text];
                }
                [animationEmojiButton removeFromSuperview];
            }
        }];
    }else{
        // Callback
        if ([self.delegate respondsToSelector:@selector(emojiView:didSelectEmoji:)]) {
            [self.delegate emojiView:self didSelectEmoji:button.titleLabel.text];
        }
    }
}

- (void)deleteButtonPressed:(UIButton *)button{
    // Add a simple scale animation
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.toValue = @0.9;
    animation.duration = 0.1;
    animation.autoreverses = YES;
    [button.layer addAnimation:animation forKey:nil];
    
    // Callback
    if ([self.delegate respondsToSelector:@selector(emojiView:didPressDeleteButton:)]) {
        [self.delegate emojiView:self didPressDeleteButton:button];
    }
}

@end

@implementation ISDeleteButton

/**
 *  Draw the delete key
 *
 *  @param rect Context Rect
 */
-(void)drawRect:(CGRect)rect{

    // Rectangle Drawing
    UIBezierPath* rectanglePath = UIBezierPath.bezierPath;
    [rectanglePath moveToPoint: CGPointMake(5, 25.05)];
    [rectanglePath addLineToPoint: CGPointMake(20.16, 36)];
    [rectanglePath addLineToPoint: CGPointMake(45.5, 36)];
    [rectanglePath addLineToPoint: CGPointMake(45.5, 13.5)];
    [rectanglePath addLineToPoint: CGPointMake(20.16, 13.5)];
    [rectanglePath addLineToPoint: CGPointMake(5, 25.05)];
    [rectanglePath closePath];
    [self.tintColor setStroke];
    rectanglePath.lineWidth = 1;
    [rectanglePath stroke];
    
    
    // Bezier Drawing
    UIBezierPath* bezierPath = UIBezierPath.bezierPath;
    [bezierPath moveToPoint: CGPointMake(26.5, 20)];
    [bezierPath addLineToPoint: CGPointMake(36.5, 29.5)];
    [bezierPath moveToPoint: CGPointMake(36.5, 20)];
    [bezierPath addLineToPoint: CGPointMake(26.5, 29.5)];
    [self.tintColor setStroke];
    bezierPath.lineWidth = 1;
    [bezierPath stroke];
}

@end
