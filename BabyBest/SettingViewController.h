//
//  SettingViewController.h
//  Dian
//
//  Created by TaiND on 5/29/16.
//  Copyright © 2016 TaiND. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface SettingViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIImageView *imgUser;
@property (weak, nonatomic) IBOutlet UITextField *lbName;
@property (weak, nonatomic) IBOutlet UITextField *lbPhone;
@property (weak, nonatomic) IBOutlet UITextField *lbCompanyName;
@property (weak, nonatomic) IBOutlet UITextField *lbAddress;
@property (weak, nonatomic) IBOutlet UITextView *txtRevenue;
@property (weak, nonatomic) IBOutlet UITextField *txtChangePass;
- (IBAction)btnSaveClicked:(id)sender;
- (IBAction)btnChangeClicked:(id)sender;
- (IBAction)btnLogoutClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;

@end
