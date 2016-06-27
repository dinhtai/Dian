//
//  HomeViewCell.h
//  Dian
//
//  Created by TaiND on 5/28/16.
//  Copyright © 2016 TaiND. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img_bg_row;
@property (weak, nonatomic) IBOutlet UILabel *product_name;
@property (weak, nonatomic) IBOutlet UILabel *product_price;
@property (weak, nonatomic) IBOutlet UILabel *product_date;
@property (weak, nonatomic) IBOutlet UIImageView *product_new;
@property (weak, nonatomic) IBOutlet UILabel *order_id;
@property (weak, nonatomic) IBOutlet UIImageView *icon_type;
@property (weak, nonatomic) IBOutlet UILabel *lb_type;

@end
