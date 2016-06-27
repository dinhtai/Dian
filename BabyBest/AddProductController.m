//
//  AddProductController.m
//  Dian
//
//  Created by TaiND on 5/28/16.
//  Copyright © 2016 TaiND. All rights reserved.
//

#import "AddProductController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Utils.h"
#import "Constants.h"
#import "APIHandler.h"
#import "Global.h"
#import "User.h"


#define USER_AVATAR_SIZE 2*72.0f
#define USERNAME_ACCEPTABLE_CHARACTERS @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_."
#define USERNAME_MAX_LENGTH 25

@interface AddProductController ()

@end

@implementation AddProductController{
    NSString *userProfilePhotoPath;
    APIHandler *_apiHandler;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _apiHandler = [[APIHandler alloc]initWithContentType:ACCEPCONTENT_TYPE];
    [self configView];
    // Do any additional setup after loading the view from its nib.
}

- (void)configView{
    self.imgProduct.layer.cornerRadius = self.imgProduct.frame.size.height/2;
    self.imgProduct.layer.borderWidth = 1.0f;
    self.imgProduct.layer.masksToBounds = YES;
    self.imgProduct.image = [UIImage imageNamed:@"img_placeholder"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnBackClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)btnAddProductClicked:(id)sender {
    [self addNewProduct];
}


- (void)addNewProduct{
    
    User *user  = [[Global shareGlobal] getCurrentUser];
    NSString *imageBase64 = [Utils encodeToBase64String:self.imgProduct.image];
    NSString *bodyString  = [NSString stringWithFormat:@"<xml><addpro><mobileno>%@</mobileno><token>%@</token><proname>%@</proname><model>%@</model><price>%@</price><propic>%@</propic><remarks>%@</remarks></addpro></xml>",user.mobileno,user.token,self.lbName.text,self.lbModel.text, self.lbPrice.text,imageBase64,self.edtRemark.text ];
    [_apiHandler addProduct:bodyString withBlock:^(id data) {
        id response = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSLog(@"%s - Data %@",__func__, response);
    } andErrorBlock:^{
        
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)btnSelectImageClicked:(id)sender {
    [self pickImageFromGallery];
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
