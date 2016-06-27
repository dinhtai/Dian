//
//  DatePickerView.h
//  ASIAInspection
//
//  Created by Dang Nguyen on 10/2/14.
//
//
#import <UIKit/UIKit.h>

@class SimpleDatePickerView;

@protocol SimpleDatePickerViewDelegate <NSObject>

- (void)simpleDatePicker:(SimpleDatePickerView *) datePickerView didSelectDate:(NSDate *)date;

@end



@interface SimpleDatePickerView : UIView
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, assign) id<SimpleDatePickerViewDelegate> delegate;

+ (SimpleDatePickerView *)createInstance;
- (void) showInView:(UIView *)containerView delegate:(id)delegate;
@end
