//
//  DetailOrderController.h
//  Dian
//
//  Created by TaiND on 5/29/16.
//  Copyright © 2016 TaiND. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface DetailOrderController : BaseViewController<UIActionSheetDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) int orderId;
@property (weak, nonatomic) IBOutlet UILabel *lbMobileno;
@property (weak, nonatomic) IBOutlet UILabel *lbMoney;
@property (weak, nonatomic) IBOutlet UITableView *tableOrder;
@property (weak, nonatomic) IBOutlet UILabel *lbOrderName;

@end
