//
//  EditViewController.h
//  Dian
//
//  Created by TaiND on 5/28/16.
//  Copyright © 2016 TaiND. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "Product.h"
#import <RSKImageCropViewController.h>



@interface EditViewController : BaseViewController<UIActionSheetDelegate, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate,UINavigationControllerDelegate, RSKImageCropViewControllerDataSource, RSKImageCropViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imgProduct;
@property (weak, nonatomic) IBOutlet UIButton *img_icon_block;
@property (weak, nonatomic) IBOutlet UITextField *lbModel;

@property (weak, nonatomic) IBOutlet UITextField *lbName;
@property (weak, nonatomic) IBOutlet UITextField *lbPrice;
@property (weak, nonatomic) IBOutlet UITextField *lbStock;
@property (weak, nonatomic) IBOutlet UITextField *editType;
@property (weak, nonatomic) IBOutlet UITableView *tableStock;
@property (weak, nonatomic) IBOutlet UIButton *btnUpdate;

@property(nonatomic, strong) Product *product;
@end
