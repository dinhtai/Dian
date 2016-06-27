//
//  ProductRankController.m
//  Dian
//
//  Created by TaiND on 5/29/16.
//  Copyright © 2016 TaiND. All rights reserved.
//

#import "ProductRankController.h"
#import "ProductRankCell.h"
#import "APIHandler.h"
#import "Constants.h"
#import "Global.h"
#import "Product.h"
#import <SDWebImage/UIImageView+WebCache.h>



@interface ProductRankController ()

@end

@implementation ProductRankController{
    APIHandler *_apiHandler;
    NSMutableArray *arrayProducts;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _apiHandler = [[APIHandler alloc]initWithContentType:ACCEPCONTENT_TYPE];
    arrayProducts = [[NSMutableArray alloc]init];
    
    [self getListProduct];
    // Do any additional setup after loading the view from its nib.
}


- (void)getListProduct{
    User *user = [[Global shareGlobal] getCurrentUser];
    
    NSString *bodyString = [NSString stringWithFormat:@"<xml><getsales><mobileno>%@</mobileno><token>%@</token><dtfrom>%@</dtfrom><dtto>%@</dtto><page>1</page></getsales></xml>",user.mobileno,user.token,_arrayCalendar[0], _arrayCalendar[1] ];
    [_apiHandler getSalesList:bodyString withBlock:^(id data) {
        id response = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSLog(@"%s - Data %@",__func__, response);
        if ([[response class] isSubclassOfClass:[NSArray class]]) {
            NSString *status  = [response[0] objectForKey:@"status"];
            if ([status isEqualToString:@"success"]) {
                
                NSArray *arrProduct  = [response[0] objectForKey:@"orderslist"];
                [arrayProducts removeAllObjects];
                for ( NSDictionary *productDict in arrProduct) {
                     Product *product = [Product getProductFromDictionary:productDict];
                     [arrayProducts addObject:product];
                  }
                [self.tableView reloadData];
            }
        }

    } andErrorBlock:^{
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnBackClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [arrayProducts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indentifier = @"ProductRankCell";
    ProductRankCell *cell = (ProductRankCell*)[tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ProductRankCell" owner:self options:nil] objectAtIndex:0];
    }
    Product *product  = [arrayProducts objectAtIndex:indexPath.row];
    cell.lbModel.text = product.model;
    cell.lbName.text = product.proname;
    [cell.img_Product sd_setImageWithURL:[NSURL URLWithString:product.propic] placeholderImage:[UIImage imageNamed:@"img_product_holder"]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 88.0f;
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
