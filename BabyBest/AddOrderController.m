//
//  AddOrderController.m
//  Dian
//
//  Created by TaiND on 6/6/16.
//  Copyright © 2016 TaiND. All rights reserved.
//

#import "AddOrderController.h"
#import "APIHandler.h"
#import "Constants.h"
#import "Global.h"
#import "User.h"
#import "Product.h"
#import "ProductViewCell.h"
#import "Utils.h"
#import <SDWebImage/UIImageView+WebCache.h>


#define USER_AVATAR_SIZE 2*72.0f
#define USERNAME_ACCEPTABLE_CHARACTERS @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_."
#define USERNAME_MAX_LENGTH 25

@interface AddOrderController ()

@end

@implementation AddOrderController{
    APIHandler *_apiHandler;
    NSMutableArray *arrayProduct;
    NSString *userProfilePhotoPath;
    int numberOrder;
    float totalPrice;
    
    int numberOrderSelect;
    NSInteger rowSelect;
    Product *productOrder;
    NSMutableArray *arrayRowSelected;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    arrayProduct = [[NSMutableArray alloc]init];

    arrayRowSelected = [[NSMutableArray alloc]init];
    _apiHandler = [[APIHandler alloc] initWithContentType:ACCEPCONTENT_TYPE];

    [self.collectionView registerNib:[UINib nibWithNibName:@"ProductViewCell" bundle:nil] forCellWithReuseIdentifier:@"ProductViewCell"];
    self.viewAddOrder.hidden = YES;
    self.collectionView.backgroundColor = [UIColor clearColor];
    // Do any additional setup after loading the view from its nib.
    [self getListProduct];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getListProduct{
    
    User *user = [[Global shareGlobal] getCurrentUser];
    
    NSString *bodyRequest = [NSString stringWithFormat:@"<xml><getpros><mobileno>%@</mobileno><token>%@</token><page>1</page></getpros></xml>",user.mobileno,user.token];
    
    [_apiHandler getProduct:bodyRequest withBlock:^(id data) {
        id response = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSLog(@"%s - Data %@",__func__, response);
        if ([[response class] isSubclassOfClass:[NSArray class]]) {
            NSString *status  = [response[0] objectForKey:@"status"];
            if ([status isEqualToString:@"success"]) {
                NSArray *arrProduct  = [response[0] objectForKey:@"prolist"];
                for ( NSDictionary *productDic in arrProduct) {
                    Product *product  = [Product getProductFromDictionary:productDic];
                    [arrayProduct addObject:product];
                }
                [self.collectionView reloadData];
            }
        }
    } andErrorBlock:^{
        
    }];

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  arrayProduct.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indentifier  = @"ProductViewCell";
    ProductViewCell *cell = (ProductViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:indentifier forIndexPath:indexPath];
    Product *product  = [arrayProduct objectAtIndex:indexPath.row];
  
    NSLog(@"Total %d", product.total);
    if (product.total != 0) {
        cell.lbProductId.hidden = NO;
        cell.lbPrice.hidden = NO;
        cell.lbTitle.hidden = YES;
        cell.img_bgCell.image = [UIImage imageNamed:@"img_cell_product_selected"];
        cell.lbProductId.text = product.model;
        cell.lbPrice.text = [NSString stringWithFormat:@"%d",product.total];
    }else{
        cell.lbProductId.hidden = YES;
        cell.lbPrice.hidden = YES;
        cell.img_bgCell.image = [UIImage imageNamed:@"img_btn_add_order"];
        cell.lbTitle.text = product.model;
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(84.0f, 30.0f);
}



#pragma mark - UICollectionView Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.viewAddOrder.hidden = NO;
    Product *product  = [arrayProduct objectAtIndex:indexPath.row];
    _txtPrice.text = [NSString stringWithFormat:@"%0.2f", product.price];
    _txtNumber.text = @"";
    _txtNotice.text = product.remarks ? product.remarks : @"";
    [_img_Product sd_setImageWithURL:[NSURL URLWithString:product.propic] placeholderImage:[UIImage imageNamed:@"img_product1_holder"]];
    rowSelect = indexPath.row;
    [arrayRowSelected addObject:[NSString stringWithFormat:@"%ld", (long)rowSelect]];
    productOrder = product;
}


#pragma mark - Select  Image

#pragma Pick User Profile Photo
- (void)pickImageFromGallery{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.navigationBar.tintColor = [UIColor whiteColor];
    //    if([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]){
    //        imagePickerController = [[UIImagePickerController alloc] init];
    //        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    //        imagePickerController.showsCameraControls = YES;
    //    }
    
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    image = [UIImage imageWithData:UIImageJPEGRepresentation(image, 0.9)];
    [self cropImage:image];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ===Crop Image
- (void)cropImage:(UIImage *)image{
    RSKImageCropViewController *cropImageVC = [[RSKImageCropViewController  alloc] initWithImage:image cropMode:RSKImageCropModeCustom];
    cropImageVC.delegate = self;
    cropImageVC.dataSource = self;
    [self.navigationController pushViewController:cropImageVC animated:YES];
}

- (void)imageCropViewControllerDidCancelCrop:(RSKImageCropViewController *)controller{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)imageCropViewController:(RSKImageCropViewController *)controller didCropImage:(UIImage *)croppedImage usingCropRect:(CGRect)cropRect rotationAngle:(CGFloat)rotationAngle{
    [self.navigationController popViewControllerAnimated:YES];
    CGFloat scale = USER_AVATAR_SIZE / croppedImage.size.width;
    croppedImage = [Utils imageWithImage:croppedImage scaleRatio:scale];
    
    userProfilePhotoPath = [Utils saveImageToCache:croppedImage name:@"user-profile-photo.jpg"];
    self.img_Product.image = croppedImage;
}

- (CGRect)imageCropViewControllerCustomMaskRect:(RSKImageCropViewController *)controller{
    CGSize maskSize;
    maskSize = CGSizeMake(self.view.frame.size.width / 2, self.view.frame.size.width / 2);
    
    CGFloat viewWidth = CGRectGetWidth(controller.view.frame);
    CGFloat viewHeight = CGRectGetHeight(controller.view.frame);
    
    CGRect maskRect = CGRectMake((viewWidth - maskSize.width) * 0.5f,
                                 (viewHeight - maskSize.height) * 0.5f,
                                 maskSize.width,
                                 maskSize.height);
    
    return maskRect;
}


// Returns a custom rect in which the image can be moved.
- (CGRect)imageCropViewControllerCustomMovementRect:(RSKImageCropViewController *)controller
{
    // If the image is not rotated, then the movement rect coincides with the mask rect.
    return controller.maskRect;
}

// Returns a custom path for the mask.
- (UIBezierPath *)imageCropViewControllerCustomMaskPath:(RSKImageCropViewController *)controller
{
    CGRect rect = controller.maskRect;
    CGPoint point1 = CGPointMake(CGRectGetMinX(rect), CGRectGetMaxY(rect));
    CGPoint point2 = CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGPoint point3 = CGPointMake(CGRectGetMaxX(rect), CGRectGetMinY(rect));
    CGPoint point4 = CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    
    UIBezierPath *rectange = [UIBezierPath bezierPath];
    [rectange moveToPoint:point1];
    [rectange addLineToPoint:point2];
    [rectange addLineToPoint:point3];
    [rectange addLineToPoint:point4];
    [rectange closePath];
    
    return rectange;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)btnBackClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnContinuteClicked:(id)sender {

    User *currentUser = [[Global shareGlobal] getCurrentUser];
    NSString *bodyString;
   bodyString = [NSString stringWithFormat:@"<xml><addorder><mobileno>%@</mobileno><token>%@</token><ctmobileno>%@</ctmobileno><ctname>%@</ctname><prolist>",currentUser.mobileno,currentUser.token, currentUser.mobileno, currentUser.company];
    for (Product *product  in arrayProduct) {
        if (product.total != 0) {
            NSString *productOrder = [NSString stringWithFormat:@"<model>%@</model><price>%f</price><procount>%d</procount><remarks>%@</remarks>",product.model, product.price, product.total, product.remarks];
            bodyString  = [NSString stringWithFormat:@"%@%@",bodyString, productOrder];
        }
    }
    
    bodyString = [NSString stringWithFormat:@"%@</prolist></addorder></xml>", bodyString];
    
    [_apiHandler addOrder:bodyString withBlock:^(id data) {
        id response = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSLog(@"%s - Data %@",__func__, response);
        NSString *status = [response valueForKey:@"status"];
        if ([status isEqualToString:@"success"]) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } andErrorBlock:^{
        
    }];
}






- (IBAction)btnAddClicked:(id)sender {
    numberOrderSelect = [self.txtNumber.text intValue];
    productOrder.total = [self.txtNumber.text intValue];
    productOrder.remarks = self.txtNotice.text;
    
    [arrayProduct removeObjectAtIndex:rowSelect];
    [arrayProduct insertObject:productOrder atIndex:rowSelect];
    numberOrder = numberOrder + numberOrderSelect;
    totalPrice = totalPrice + numberOrderSelect * productOrder.price;
    
    
    _lbMount.text = [NSString stringWithFormat:@"%0.2f", totalPrice];
    _lbNumberProduct.text = [NSString stringWithFormat:@"您已选择 %d 个产品", numberOrder];
    
    self.viewAddOrder.hidden = YES;
    [self.collectionView reloadData];
}
- (IBAction)btnChooseImageClicked:(id)sender {
    [self pickImageFromGallery];

    
}
@end
