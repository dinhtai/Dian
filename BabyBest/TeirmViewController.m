//
//  TeirmViewController.m
//  Dian
//
//  Created by TaiND on 6/22/16.
//  Copyright © 2016 TaiND. All rights reserved.
//

#import "TeirmViewController.h"
#import "APIHandler.h"
#import "Constants.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface TeirmViewController ()

@end

@implementation TeirmViewController{
    APIHandler *_apiHandler;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    _apiHandler = [[APIHandler alloc] initWithContentType:ACCEPCONTENT_TYPE];

    [self getAboutInfor];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getAboutInfor{
    [_apiHandler getAbout:nil withBlock:^(id data) {
        id response = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSLog(@"%s - Data %@",__func__, response);
        if ([[response class] isSubclassOfClass:[NSArray class]]) {
            NSString *aboutus = [response[0] objectForKey:@"aboutus"];
            NSString *pictUrl = [response[0] objectForKey:@"compic"];
            [_imgAbout sd_setImageWithURL:[NSURL URLWithString:pictUrl] placeholderImage:[UIImage imageNamed:@""]];
            _txtAbout.text = aboutus;
        }

    } andErrorBlock:^{
        
    }];
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
