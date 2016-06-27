//
//  DetailOrderController.m
//  Dian
//
//  Created by TaiND on 5/29/16.
//  Copyright © 2016 TaiND. All rights reserved.
//

#import "OrderDetailController.h"
#import "APIHandler.h"
#import "Constants.h"
#import "Global.h"
#import "User.h"
#import "Order.h"
#import "DetailOrderCell.h"
#import "ModelObject.h"

@interface OrderDetailController ()

@end

@implementation OrderDetailController{
    APIHandler *_apiHandler;
    NSMutableArray *arrayOrder;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _apiHandler = [[APIHandler alloc]initWithContentType:ACCEPCONTENT_TYPE];
    arrayOrder = [[NSMutableArray alloc]init];
    // Do any additional setup after loading the view from its nib.
    [self getDetailOrder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getDetailOrder{
    User *user = [[Global shareGlobal] getCurrentUser];
    
    NSString *bodyString = [NSString stringWithFormat:@"<xml><getorderdetail><mobileno>%@</mobileno><token>%@</token><orderid>%d</orderid></getorderdetail></xml>",user.mobileno, user.token,_orderId];
    [_apiHandler getOrderDetail:bodyString withBlock:^(id data) {
        id response = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSLog(@"%s - Data %@",__func__, response);
        if ([[response class] isSubclassOfClass:[NSArray class]]) {
            NSString *status  = [response[0] objectForKey:@"status"];
            if ([status isEqualToString:@"success"]) {
                self.lbMobileno.text = [NSString stringWithFormat:@"%.2f",[[response[0] objectForKey:@"ctmobileno"] floatValue]];
                self.lbMoney.text = [NSString stringWithFormat:@"%.2f",[[response[0] objectForKey:@"moneys"] floatValue]];
                self.lbOrderName.text = [response[0] objectForKey:@"ctname"];
                [arrayOrder removeAllObjects];
                NSArray *arrModel  = [response[0] objectForKey:@"orderlist"];
                for ( NSDictionary *modelDict in arrModel) {
                    ModelObject *model = [ModelObject getModelFromDictionary:modelDict];
                    [arrayOrder addObject:model];
                }
                [self.tableOrder reloadData];
            }else{
                
            }
        }
    } andErrorBlock:^{
        
    }];
    
}


#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [arrayOrder count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier  = @"DetailOrderCell";
    DetailOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DetailOrderCell" owner:self options:nil] objectAtIndex:0];
    }
    
    ModelObject *model  = [arrayOrder objectAtIndex:indexPath.row];
    cell.lbModel.text = model.model;
    cell.lbPrice.text = [NSString stringWithFormat:@"%.2f", model.price];
    cell.lbTotal.text = [NSString stringWithFormat:@"%.2f元", model.total];
    cell.lbNote.text = model.remarks;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.0f;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


- (IBAction)btnMenuClicked:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"作废订单",@"呼叫客户", nil];
    
    
    [actionSheet showInView:self.view];
}

- (IBAction)btnBackClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];

}
@end
