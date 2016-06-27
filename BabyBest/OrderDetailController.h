//
//  OrderDetailController.h
//  Dian
//
//  Created by TaiND on 6/27/16.
//  Copyright © 2016 TaiND. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface OrderDetailController : BaseViewController<UIActionSheetDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) int orderId;
@property (weak, nonatomic) IBOutlet UILabel *lbMobileno;
@property (weak, nonatomic) IBOutlet UILabel *lbMoney;
@property (weak, nonatomic) IBOutlet UITableView *tableOrder;
@property (weak, nonatomic) IBOutlet UILabel *lbOrderName;

- (IBAction)btnMenuClicked:(id)sender;
- (IBAction)btnBackClicked:(id)sender;

@end
