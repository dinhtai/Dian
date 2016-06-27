//
//  SettingViewController.m
//  Dian
//
//  Created by TaiND on 5/29/16.
//  Copyright © 2016 TaiND. All rights reserved.
//

#import "SettingViewController.h"
#import "APIHandler.h"
#import "Constants.h"
#import "Global.h"
#import "User.h"
#import "Utils.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "LoginAppViewController.h"


@interface SettingViewController ()

@end

@implementation SettingViewController{
    APIHandler *_apiHandler;
    User *currentUser;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _apiHandler = [[APIHandler alloc]initWithContentType:ACCEPCONTENT_TYPE];
    currentUser = [[Global shareGlobal]getCurrentUser];
    self.btnSave.hidden = YES;
    self.imgUser.layer.cornerRadius = self.imgUser.frame.size.height/2;
    self.imgUser.layer.masksToBounds = YES;
    self.imgUser.layer.borderWidth = 1.0f;
    [self fillUserData];
    // Do any additional setup after loading the view from its nib.
}


- (void)fillUserData{
    
    [self.imgUser sd_setImageWithURL:[NSURL URLWithString:currentUser.portrait] placeholderImage:[UIImage imageNamed:@"img_product_holder"]];
    self.lbName.text = currentUser.cname;
    self.lbPhone.text = currentUser.mobileno;
    self.lbCompanyName.text = currentUser.company;
    self.lbAddress.text = currentUser.address;
    self.txtRevenue.text = currentUser.bank;
    self.txtChangePass.text = currentUser.password;
    
}

- (void)updateUserInfor{
    
    NSString *imgBase64 = [Utils encodeToBase64String:self.imgUser.image];
    NSString *bodyString  = [NSString stringWithFormat:@"<xml><update><mobileno>%@</mobileno><token>%@</token><passwd>%@</passwd><cname>%@</cname><company>%@</company><address>%@</address><portrait>%@</portrait><bank>%@</bank></update></xml>", currentUser.mobileno, currentUser.token,self.txtChangePass.text, self.lbName.text,self.lbCompanyName.text,self.lbAddress.text,imgBase64,self.txtRevenue.text];
    
    [_apiHandler updateAccount:bodyString withBlock:^(id data) {
        id response = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSLog(@"%s - Data %@",__func__, response);
        if ([[response class] isSubclassOfClass:[NSArray class]]) {            
            NSString *status = [response[0] objectForKey:@"status"];
            if ([status isEqualToString:@"success"]) {
                User *user = [User getUsersFromDictionary:response[0]];
                [[Global shareGlobal] setCurrentUser:user];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    } andErrorBlock:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)btnSaveClicked:(id)sender {
    if ([self.lbName.text  isEqualToString:@""] || [self.lbPhone.text isEqualToString:@""] || [self.lbAddress.text isEqualToString:@""] || [self.lbCompanyName.text isEqualToString:@""] || [self.txtChangePass.text isEqualToString:@""] || [self.txtRevenue.text isEqualToString:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Dian" message:@"完整信息!" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        [alertView show];
    }else{
        [self updateUserInfor];
    }
}

- (IBAction)btnChangeClicked:(id)sender {
    
}

- (IBAction)btnLogoutClicked:(id)sender {
    NSString *bodyString  = [NSString stringWithFormat:@"<xml><logout><mobileno>%@</mobileno><token>%@</token></logout></xml>",currentUser.mobileno, currentUser.token];
    [_apiHandler logoutAccount:bodyString withBlock:^(id data) {
        id response = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSLog(@"%s - Data %@",__func__, response);
        if ([[response class] isSubclassOfClass:[NSArray class]]) {
            NSString *status  = [response[0] objectForKey:@"status"];
            if ([status isEqualToString:@"success"]) {
                NSArray *arrayController  = self.navigationController.viewControllers;
                [self.navigationController popToViewController:arrayController[0]  animated:YES];
            }
        }
    } andErrorBlock:^{
        
    }];
    
}
- (IBAction)edtChange:(id)sender {
    self.btnSave.hidden = NO;
}
@end
