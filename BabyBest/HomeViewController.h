//
//  HomeViewController.h
//  BabyBest
//
//  Created by TaiND on 3/24/16.
//  Copyright © 2016 TaiND. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVPullToRefresh.h"
#import "BaseViewController.h"


@interface HomeViewController : BaseViewController<UICollectionViewDelegate,UITableViewDelegate, UITableViewDataSource, UISearchDisplayDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btnSetting;
@property (nonatomic) BOOL isUpdateProfile;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *viewCalendar;
@property (weak, nonatomic) IBOutlet UIButton *btnMonth1;
@property (weak, nonatomic) IBOutlet UIButton *btnMonth2;
@property (weak, nonatomic) IBOutlet UIButton *btnMonth3;
@property (weak, nonatomic) IBOutlet UIButton *btnMonth4;
@property (weak, nonatomic) IBOutlet UIButton *btnMonth5;
@property (weak, nonatomic) IBOutlet UIButton *btnMonth6;
@property (weak, nonatomic) IBOutlet UIButton *btnMonth7;
@property (weak, nonatomic) IBOutlet UIButton *btnMonth8;
@property (weak, nonatomic) IBOutlet UIButton *btnMonth9;
@property (weak, nonatomic) IBOutlet UIButton *btnMonth10;
@property (weak, nonatomic) IBOutlet UIButton *btnMonth11;
@property (weak, nonatomic) IBOutlet UIButton *btnMonth12;

@property (weak, nonatomic) IBOutlet UIButton *btnYear16;
@property (weak, nonatomic) IBOutlet UIButton *btnYear15;
@property (weak, nonatomic) IBOutlet UIButton *btnYear14;
@property (weak, nonatomic) IBOutlet UIButton *btnYear13;

@property (weak, nonatomic) IBOutlet UIButton *btnCalendar;
@property (weak, nonatomic) IBOutlet UILabel *lbOrder_id;
@property (weak, nonatomic) IBOutlet UILabel *lbNumberProduct;
@property (weak, nonatomic) IBOutlet UILabel *lbdue_incone;
@property (weak, nonatomic) IBOutlet UILabel *lbranking;
@property (weak, nonatomic) IBOutlet UIImageView *img_CurrentUser;
@property (weak, nonatomic) IBOutlet UIButton *btnNewOrderRound;

@property (weak, nonatomic) IBOutlet UIButton *btnOrder;
@property (weak, nonatomic) IBOutlet UIButton *btnEditProduct;

@end
