//
//  SimplePickerView.h
//  ASIAInspection
//
//  Created by Dang Nguyen on 10/2/14.
//
//

#import <UIKit/UIKit.h>
#import "FrameActionSheet.h"
@class SimplePickerView;

@protocol SimplePickerDelegate <NSObject>

- (void) pickerView:(SimplePickerView *) pickerView doneWithSelectedRow:(NSInteger )row;
@end

@interface SimplePickerView : UIView <UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btnSelect;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, assign) id<SimplePickerDelegate> delegate;

+ (SimplePickerView *)createInstance;
- (void)showWithArray:(NSArray *) array inView:(UIView *)aView delegate:(id)delegate;
- (void)showWithArray:(NSArray *) array selection:(NSInteger) index inView:(UIView *)aView delegate:(id)delegate;
- (void)showInView:(UIView *)aView;

@end

