//
//  ProductViewCell.h
//  Dian
//
//  Created by TaiND on 6/25/16.
//  Copyright © 2016 TaiND. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img_bgCell;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbProductId;
@property (weak, nonatomic) IBOutlet UILabel *lbPrice;

@end
