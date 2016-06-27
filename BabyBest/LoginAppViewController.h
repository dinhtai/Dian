//
//  LoginAppViewController.h
//  DoDate
//
//  Created by TaiND on 12/16/15.
//  Copyright © 2015 trojan_bk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ErrorHandler.h"
#import <CoreData/CoreData.h>

@interface LoginAppViewController : UIViewController<ErrorHandlerDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UIView *viewLogin;

@property (nonatomic, strong) ErrorHandler *errorHandler;
@property (strong) NSManagedObject *customer;


@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
- (IBAction)btn_Login_Clicked:(id)sender;
- (IBAction)btn_forgot_account_clicked:(id)sender;
@end
