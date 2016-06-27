//
//  RDActionSheet.h
//  RDActionSheet v1.1.0
//
//  Created by Red Davis on 12/01/2012.
//  Copyright (c) 2012 Riot. All rights reserved.
//

#import <UIKit/UIKit.h>


@class FrameActionSheet;
@protocol RDActionSheetDelegate;

@interface FrameActionSheet : UIView

@property (strong, nonatomic) UIView *contentView;
@property (weak, nonatomic) id <RDActionSheetDelegate> delegate;

- (id)initWithContentView:(UIView *)contentView;

- (void)showFrom:(UIView *)view;
- (void)cancelActionSheet;

@end


@protocol RDActionSheetDelegate <NSObject>
@optional
- (void)willPresentActionSheet:(FrameActionSheet *)actionSheet;  // before animation and showing view
- (void)didPresentActionSheet:(FrameActionSheet *)actionSheet;  // after animation)
- (void)didDismissActionSheet:(FrameActionSheet *)actionSheet;
- (void)willDismissActionSheet:(FrameActionSheet *)actionSheet;
@end
