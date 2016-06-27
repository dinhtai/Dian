//
//  ListProductController.m
//  Dian
//
//  Created by TaiND on 5/28/16.
//  Copyright © 2016 TaiND. All rights reserved.
//

#import "ListProductController.h"
#import "ListProductCell.h"
#import "AddProductController.h"
#import "EditViewController.h"
#import "APIHandler.h"
#import "Constants.h"
#import "Product.h"
#import "User.h"
#import "Global.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ListProductController ()

@end

@implementation ListProductController{
    APIHandler *_apiHandler;
    NSMutableArray *arrayProduct;


}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    arrayProduct = [[NSMutableArray alloc]init];
    _apiHandler = [[APIHandler alloc]initWithContentType:ACCEPCONTENT_TYPE];

    [self getListProduct];

    // Do any additional setup after loading the view from its nib.
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
                [self.tableView reloadData];
            }
        }
    } andErrorBlock:^{
        
    }];
}

#pragma mark - UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [arrayProduct count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indentifier = @"ListProductCell";
    ListProductCell *cell = (ListProductCell*)[tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ListProductCell" owner:self options:nil] objectAtIndex:0];
    }
    
    
    Product *product  = [arrayProduct objectAtIndex:indexPath.row];
    cell.lbProductName.text = product.proname;
    cell.lbType.text = product.model;
    cell.lbPrice.text = [NSString stringWithFormat:@"价格：%.2f", product.price];
    cell.lbstock.text = [NSString stringWithFormat:@"库存：%.2f", product.stock];
    cell.imgProduct.layer.cornerRadius = 2.0f;
    cell.imgProduct.layer.borderWidth = 1.0f;
    cell.imgProduct.layer.masksToBounds = YES;
    [cell.imgProduct sd_setImageWithURL:[NSURL URLWithString:product.propic] placeholderImage:[UIImage imageNamed:@"img_product_holder"]];
    if (product.delsta) {
        cell.img_lock.hidden = NO;
    }else{
        cell.img_lock.hidden = YES;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 88.0f;
}


#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    EditViewController *editViewController = [[EditViewController alloc]initWithNibName:@"EditViewController" bundle:nil];
    editViewController.product = [arrayProduct objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:editViewController animated:YES];
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


- (IBAction)btnAddClicked:(id)sender {
    AddProductController *addProduct = [[AddProductController alloc]initWithNibName:@"AddProductController" bundle:nil];
    [self.navigationController pushViewController:addProduct animated:YES];
    
}

@end
