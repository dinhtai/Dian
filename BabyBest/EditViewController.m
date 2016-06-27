//
//  EditViewController.m
//  Dian
//
//  Created by TaiND on 5/28/16.
//  Copyright © 2016 TaiND. All rights reserved.
//

#import "EditViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Stock.h"
#import "Utils.h"
#import "User.h"
#import "Global.h"
#import "Constants.h"
#import "APIHandler.h"


#define USER_AVATAR_SIZE 2*72.0f
#define USERNAME_ACCEPTABLE_CHARACTERS @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_."
#define USERNAME_MAX_LENGTH 25

@interface EditViewController ()

@end

@implementation EditViewController{
    NSMutableArray *arrayStocks;
    NSString *userProfilePhotoPath;
    APIHandler *_apiHandler;


}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.btnUpdate.hidden = YES;
    _apiHandler = [[APIHandler alloc]initWithContentType:ACCEPCONTENT_TYPE];
    arrayStocks = [[NSMutableArray alloc]init];
    [self fillProduct];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)fillProduct{
    
    self.imgProduct.layer.cornerRadius = self.imgProduct.frame.size.height /2;
    self.imgProduct.layer.masksToBounds = YES;
    self.imgProduct.layer.borderWidth = 1.0f;
    self.img_icon_block.hidden = YES;
    [self.imgProduct sd_setImageWithURL:[NSURL URLWithString:self.product.propic] placeholderImage:[UIImage imageNamed:@"img_product_holder"]];
    self.lbModel.text = self.product.model;
    self.lbModel.userInteractionEnabled = NO;
    self.lbName.text = self.product.proname;
    self.lbPrice.text = [NSString stringWithFormat:@"%0.2f",self.product.price];
    self.lbStock.text = [NSString stringWithFormat:@"%0.2f",self.product.stock];
    self.editType.text = self.product.remarks;
    
    NSArray *listStock = self.product.stocklist;
    for (NSDictionary *stockDict in listStock) {
        Stock *stock = [Stock getStockFromDictionary:stockDict];
        [arrayStocks addObject:stock];
    }
    
    if (self.product.delsta) {
        self.img_icon_block.hidden = NO;
    }
    
    [self.tableStock reloadData];
    
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


- (IBAction)showActionSheet:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"停止销售", nil];
    
    
    [actionSheet showInView:self.view];
}



#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arrayStocks.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier  = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    Stock *stock = [arrayStocks objectAtIndex:indexPath.row];
    cell.textLabel.text = stock.title;
    cell.textLabel.font = [UIFont systemFontOfSize:9.0f];
    cell.detailTextLabel.text = stock.Dt;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:9.0f];

    
    return cell;
}
- (IBAction)txtChanged:(id)sender {
    self.btnUpdate.hidden = NO;
}

- (IBAction)btnChangeImageClicked:(id)sender {
    [self pickImageFromGallery];
}
- (IBAction)btnUpdateClicked:(id)sender {
    
    User *user = [[Global shareGlobal] getCurrentUser];
    NSString *imageBase64 = [Utils encodeToBase64String:self.imgProduct.image];
    
    NSString *bodyRequest = [NSString stringWithFormat:@"<xml><editpro><mobileno>%@</mobileno><token>%@</token><id>%d</id><proname>%@</proname><model>%@</model><price>%@</price><propic>%@</propic><remarks>%@</remarks></editpro></xml>",user.mobileno,user.token, _product.product_id, self.lbName.text, self.lbModel.text, self.lbPrice.text,imageBase64,self.editType.text];
    
    [_apiHandler editProduct:bodyRequest withBlock:^(id data) {
        id response = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSLog(@"%s - Data %@",__func__, response);
        if ([[response class] isSubclassOfClass:[NSDictionary class]]) {
            NSString *status  = [response objectForKey:@"status"];
            if ([status isEqualToString:@"success"]) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }

    } andErrorBlock:^{
        
    }];

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
    self.imgProduct.image = croppedImage;
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



@end
