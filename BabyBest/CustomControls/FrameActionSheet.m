//
//  RDActionSheet.m
//  RDActionSheet v1.1.0
//
//  Created by Red Davis on 12/01/2012.
//  Copyright (c) 2012 Riot. All rights reserved.
//

#import "FrameActionSheet.h"
#import <QuartzCore/QuartzCore.h>


@interface FrameActionSheet ()

@property (nonatomic, strong) UIView *blackOutView;
- (UIView *)buildBlackOutViewWithFrame:(CGRect)frame;

@end

const CGFloat kActionSheetAnimationTime = 0.2;
const CGFloat kBlackoutViewFadeInOpacity = 0.6;


@implementation FrameActionSheet

@synthesize delegate;
@synthesize blackOutView;

#pragma mark - Initialization
- (id)init { 
    self = [super init];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        self.opaque = YES;
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

- (id)initWithContentView:(UIView *)contentView{
    self = [self init];
    self.contentView = contentView;
    
    return self;
}

#pragma mark - View setup
- (void)layoutSubviews {
    [self addSubview:self.contentView];
}

#pragma mark - Blackout view builder
- (UIView *)buildBlackOutViewWithFrame:(CGRect)frame {
    
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    view.backgroundColor = [UIColor blackColor];
    view.opaque = YES;
    view.alpha = 0;
    
    return view;
}

-(void)cancelActionSheet {
    if ([self.delegate respondsToSelector:@selector(willDismissActionSheet:)]) {
        [self.delegate willDismissActionSheet:self];
    }
    
    [UIView animateWithDuration:kActionSheetAnimationTime animations:^{
        CGFloat endPosition = self.frame.origin.y + self.frame.size.height;
        self.frame = CGRectMake(self.frame.origin.x, endPosition, self.frame.size.width, self.frame.size.height);
        self.blackOutView.alpha = 0;
    } completion:^(BOOL finished) {
        if ([self.delegate respondsToSelector:@selector(didDismissActionSheet:)]) {
            [self.delegate didDismissActionSheet:self];
        }
        [self removeFromSuperview];
    }];
}

#pragma mark - Present action sheet

- (void)showFrom:(UIView *)view {
        
    CGFloat startPosition = view.bounds.origin.y + view.bounds.size.height;
    
    self.frame = CGRectMake(0, startPosition, view.bounds.size.width, self.contentView.frame.size.height);
    [view addSubview:self];
        
    self.blackOutView = [self buildBlackOutViewWithFrame:view.bounds];
    [view insertSubview:self.blackOutView belowSubview:self];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(willPresentActionSheet:)]) {
        [self.delegate willPresentActionSheet:self];
    }
    
    [UIView animateWithDuration:kActionSheetAnimationTime
                     animations:^{
                         CGFloat endPosition = startPosition - self.frame.size.height;
                         self.frame = CGRectMake(self.frame.origin.x, endPosition, self.frame.size.width, self.frame.size.height);
                         self.blackOutView.alpha = kBlackoutViewFadeInOpacity;
                     }
                     completion:^(BOOL finished) {
                         if (self.delegate && [self.delegate respondsToSelector:@selector(didPresentActionSheet:)]) {
                             [self.delegate didPresentActionSheet:self];
                         }
                     }];
}
@end
