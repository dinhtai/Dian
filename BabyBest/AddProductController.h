//
//  AddProductController.h
//  Dian
//
//  Created by TaiND on 5/28/16.
//  Copyright © 2016 TaiND. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import <RSKImageCropViewController.h>


@interface AddProductController : BaseViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate, RSKImageCropViewControllerDataSource, RSKImageCropViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imgProduct;
@property (weak, nonatomic) IBOutlet UITextField *lbName;

@property (weak, nonatomic) IBOutlet UITextField *lbModel;
@property (weak, nonatomic) IBOutlet UITextField *lbPrice;

@property (weak, nonatomic) IBOutlet UITextField *lbStock;
@property (weak, nonatomic) IBOutlet UITextField *edtRemark;

@end
