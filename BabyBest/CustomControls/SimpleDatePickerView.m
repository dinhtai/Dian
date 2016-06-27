//
//  DatePickerView.m
//  ASIAInspection
//
//  Created by Dang Nguyen on 10/2/14.
//
//

#import "SimpleDatePickerView.h"
#import "FrameActionSheet.h"

@implementation SimpleDatePickerView{
    FrameActionSheet *frameActionSheet;
}

+ (SimpleDatePickerView *)createInstance{
    SimpleDatePickerView *instance = [[[NSBundle mainBundle] loadNibNamed:@"SimpleDatePickerView" owner:self options:nil] objectAtIndex:0];
    instance.datePicker.datePickerMode = UIDatePickerModeDate;
    
    return instance;
}

- (void)showInView:(UIView *)containerView delegate:(id)delegate{
    self.delegate = delegate;
    self.frame = CGRectMake(0, 0, containerView.frame.size.width, 270);
    
    frameActionSheet = [[FrameActionSheet alloc] initWithContentView:self];
    [frameActionSheet showFrom:containerView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)btnCancelClick:(id)sender {
    [frameActionSheet cancelActionSheet];
}

- (IBAction)btnSelectClick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(simpleDatePicker:didSelectDate:)]) {
        [self.delegate simpleDatePicker:self didSelectDate:self.datePicker.date];
    }
    [frameActionSheet cancelActionSheet];
}

@end
