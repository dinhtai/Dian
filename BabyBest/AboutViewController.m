//
//  AboutViewController.m
//  BabyBest
//
//  Created by TaiND on 4/1/16.
//  Copyright © 2016 TaiND. All rights reserved.
//

#import "AboutViewController.h"
#import "APIHandler.h"
#import "Constants.h"

@interface AboutViewController ()

@end

@implementation AboutViewController{
    APIHandler *_apiHandler;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _apiHandler = [[APIHandler alloc]initWithContentType:ACCEPCONTENT_TYPE];
    [self getAboutApp];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getAboutApp{
   NSString *bodyString  = @"";
    [_apiHandler getAbout:bodyString withBlock:^(id data) {
        id response = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSLog(@"%s - Data %@",__func__, response);
    } andErrorBlock:^{
        
    }];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (IBAction)btnBackClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
