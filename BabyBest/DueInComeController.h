//
//  DueInComeController.h
//  Dian
//
//  Created by TaiND on 5/29/16.
//  Copyright © 2016 TaiND. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface DueInComeController : BaseViewController<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) NSArray *arrayCalendar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *lbAmount;
@property (weak, nonatomic) IBOutlet UILabel *lbOrderCount;
@property (weak, nonatomic) IBOutlet UILabel *lbDate;

@end
