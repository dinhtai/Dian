//
//  DetailOrderCell.h
//  Dian
//
//  Created by TaiND on 6/8/16.
//  Copyright © 2016 TaiND. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailOrderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbModel;
@property (weak, nonatomic) IBOutlet UILabel *lbPrice;
@property (weak, nonatomic) IBOutlet UILabel *lbTotal;
@property (weak, nonatomic) IBOutlet UILabel *lbNote;

@end
