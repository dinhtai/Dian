//
//  ProductRankCell.h
//  Dian
//
//  Created by TaiND on 5/29/16.
//  Copyright © 2016 TaiND. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductRankCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img_Product;
@property (weak, nonatomic) IBOutlet UILabel *lbModel;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbproCount;

@end
