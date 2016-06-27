//
//  DueInComeCell.h
//  Dian
//
//  Created by TaiND on 5/29/16.
//  Copyright © 2016 TaiND. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DueInComeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbOder_Name;
@property (weak, nonatomic) IBOutlet UILabel *lbOrderModel;
@property (weak, nonatomic) IBOutlet UILabel *lbDate;
@property (weak, nonatomic) IBOutlet UIImageView *imageNew;
@property (weak, nonatomic) IBOutlet UILabel *labMoney;

@end
