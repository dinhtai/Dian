//
//  SimplePickerView.m
//  ASIAInspection
//
//  Created by Dang Nguyen on 10/2/14.
//
//

#import "SimplePickerView.h"

@implementation SimplePickerView{
    FrameActionSheet *frameActionSheet;
    NSInteger selectedRow;
}

+ (SimplePickerView *)createInstance{
    SimplePickerView *view = [[[NSBundle mainBundle] loadNibNamed:@"SimplePickerView" owner:self options:nil] objectAtIndex:0];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    return view;
}

- (void)showWithArray:(NSArray *) array inView:(UIView *)aView delegate:(id)delegate{
    [self showWithArray:array selection:0 inView:aView delegate:delegate];
}

- (void)showWithArray:(NSArray *)array selection:(NSInteger)index inView:(UIView *)aView delegate:(id)delegate{
    self.delegate = delegate;
    self.data = array;
    [_pickerView reloadAllComponents];
    
    selectedRow = index;
    [_pickerView selectRow:selectedRow inComponent:0 animated:YES];
    
    self.frame = CGRectMake(0, 0, aView.frame.size.width, 228);
    frameActionSheet = [[FrameActionSheet alloc] initWithContentView:self];
    [frameActionSheet showFrom:aView];
}

- (void)showInView:(UIView *)aView{
    self.frame = CGRectMake(0, 0, aView.frame.size.width, 228);
    frameActionSheet = [[FrameActionSheet alloc] initWithContentView:self];
    [frameActionSheet showFrom:aView];
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.data.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 33;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return  [self.data objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    selectedRow = row;
}

- (IBAction)btnCancel:(id)sender {
    if (frameActionSheet) {
        [frameActionSheet cancelActionSheet];
    }
}
- (IBAction)btnDone:(id)sender {
    if (frameActionSheet) {
        [frameActionSheet cancelActionSheet];
    }
    
    if (selectedRow != -1) {
        if (_delegate && [_delegate respondsToSelector:@selector(pickerView:doneWithSelectedRow:)]) {
            [_delegate pickerView:self doneWithSelectedRow:selectedRow];
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
