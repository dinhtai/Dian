//
//  GetMyOrderController.h
//  Dian
//
//  Created by TaiND on 5/29/16.
//  Copyright © 2016 TaiND. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface GetMyOrderController : BaseViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end