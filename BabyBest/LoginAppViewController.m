//
//  LoginAppViewController.m
//  DoDate
//
//  Created by TaiND on 12/16/15.
//  Copyright © 2015 trojan_bk. All rights reserved.
//

#import "LoginAppViewController.h"
#import "APIHandler.h"
#import "Constants.h"
#import "Global.h"
#import "Helper.h"
#import "SVProgressHUD.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "SVProgressHUD.h"
#import "Utils.h"
#import "HomeViewController.h"
#import "User.h"
#import "TeirmViewController.h"




@interface LoginAppViewController ()


@end

@implementation LoginAppViewController
{
    APIHandler *apiHandler;
}

@synthesize customer;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (IS_IPHONE_6){
        [self.viewLogin updateConstraints];
        [self.viewLogin updateConstraintsIfNeeded];
    }
    
    apiHandler = [[APIHandler alloc]initWithContentType:ACCEPCONTENT_TYPE];

    // Do any additional setup after loading the view from its nib.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboardTouch)
    ];
    [self.view addGestureRecognizer:tap];
    
    _errorHandler = [[ErrorHandler alloc]init];
    _errorHandler.delegate = self;
    
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dismissKeyboardTouch{
    [self.txtEmail resignFirstResponder];
    [self.txtPassword resignFirstResponder];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (IBAction)btn_Login_Clicked:(id)sender {
    if ([self.txtEmail.text isEqualToString:@""] || [self.txtPassword.text isEqualToString:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Bạn cần nhập đầy đủ thông tin! " delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
        [SVProgressHUD dismiss];
    }else{
        NSString *bodyRequest = [NSString stringWithFormat:@"<xml><login><mobileno>%@</mobileno><passwd>%@</passwd></login></xml>",self.txtEmail.text, self.txtPassword.text];
        

        [apiHandler loginAccount:bodyRequest withBlock:^(id data) {            
            id response = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSLog(@"%s - Data %@",__func__, response);
            if ([[response class] isSubclassOfClass:[NSArray class]]) {
                NSString *status  = [response[0] objectForKey:@"status"];
                if ([status isEqualToString:@"success"]) {
                    NSMutableDictionary *userDict  = [[NSMutableDictionary alloc]initWithDictionary:response[0]];
                    [userDict setValue:self.txtPassword.text forKey:@"password"];
                    User *user = [User getUsersFromDictionary:userDict];
                    [[Global shareGlobal]setCurrentUser:user];
                    HomeViewController *homeViewController = [[HomeViewController  alloc]initWithNibName:@"HomeViewController" bundle:nil];
                    [self.navigationController pushViewController:homeViewController animated:YES];
                }
            }
           
        } andErrorBlock:^{
            
        }];
    }
}


- (IBAction)btn_forgot_account_clicked:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Dian" message:@"Do you want to reset password?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView show];
    
}



#pragma mark - Check exit email 
- (void)checkExitEmail:(NSString*)email{
    NSLog(@"Email Facebook %@", email);
    NSMutableDictionary *params  = [[NSMutableDictionary alloc] init];
    [params setValue:email forKey:@"username"];
    
    NSMutableArray *arrayToken = [NSMutableArray arrayWithArray:params.allKeys];
    NSLog(@"Array Token %@", arrayToken);
    NSArray *sortedArray = [arrayToken sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    NSMutableArray *arrayValue = [[NSMutableArray alloc]init];
    for (NSString *key in sortedArray) {
        NSString *value  = [params objectForKey:key];
        [arrayValue addObject:value];
    }
    NSLog(@"Array Token Sorted %@",arrayValue);
    
    NSString* secureHash = [Utils generateSecurehash:arrayValue];
    [params setValue:secureHash forKey:@"securehash"];
    
}

- (IBAction)btnCancelClicked:(id)sender {
    HomeViewController *homeViewController = [[HomeViewController  alloc]initWithNibName:@"HomeViewController" bundle:nil];
    [self.navigationController pushViewController:homeViewController animated:YES];
}


- (IBAction)btnTermClicked:(id)sender {
    TeirmViewController  *teirmViewController  = [[TeirmViewController alloc]initWithNibName:@"TeirmViewController" bundle:nil];
    [self.navigationController pushViewController:teirmViewController animated:YES];
}


#pragma mark - UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        // resert password
        NSString *bodyString  = [NSString stringWithFormat:@"<xml><forgotpass><mobileno>%@</mobileno></forgotpass></xml>", [alertView textFieldAtIndex:0].text];
        [apiHandler forgotPassword:bodyString withBlock:^(id data) {
            id response = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSLog(@"%s : %@", __func__, response);
        } andErrorBlock:^{
            
        }];
        
    }
}

@end
