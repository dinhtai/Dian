//
//  AddOrderController.h
//  Dian
//
//  Created by TaiND on 6/6/16.
//  Copyright © 2016 TaiND. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import <RSKImageCropViewController.h>


@interface AddOrderController : BaseViewController<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, RSKImageCropViewControllerDataSource, RSKImageCropViewControllerDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lbMount;
@property (weak, nonatomic) IBOutlet UILabel *lbNumberProduct;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *viewAddOrder;
- (IBAction)btnAddClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *img_Product;
- (IBAction)btnChooseImageClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtNumber;
@property (weak, nonatomic) IBOutlet UITextField *txtPrice;
@property (weak, nonatomic) IBOutlet UITextField *txtNotice;

@end
