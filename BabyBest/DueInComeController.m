//
//  DueInComeController.m
//  Dian
//
//  Created by TaiND on 5/29/16.
//  Copyright © 2016 TaiND. All rights reserved.
//

#import "DueInComeController.h"
#import "DueInComeCell.h"
#import "DetailOrderController.h"
#import "APIHandler.h"
#import "Constants.h"
#import "Global.h"
#import "User.h"
#import "Order.h"

@interface DueInComeController ()

@end

@implementation DueInComeController{
    APIHandler *_apiHandler;
    NSMutableArray *arrayOrders;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    arrayOrders = [[NSMutableArray alloc]init];
    _apiHandler = [[APIHandler alloc]initWithContentType:ACCEPCONTENT_TYPE];

    [self getListOrders];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)getListOrders{
    User *user = [[Global shareGlobal] getCurrentUser];
    
    NSString *bodyString = [NSString stringWithFormat:@"<xml><getorders><mobileno>%@</mobileno><token>%@</token><dtfrom>%@</dtfrom><dtto>%@</dtto><paid>0</paid><page>1</page></getorders></xml>",user.mobileno,user.token,_arrayCalendar[0], _arrayCalendar[1] ];
    [_apiHandler getOrder:bodyString withBlock:^(id data) {
        id response = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSLog(@"%s - Data %@",__func__, response);
        if ([[response class] isSubclassOfClass:[NSArray class]]) {
            NSString *status  = [response[0] objectForKey:@"status"];
            if ([status isEqualToString:@"success"]) {
                self.lbAmount.text = [NSString stringWithFormat:@"%.2f",[[response[0] objectForKey:@"amount"]floatValue]];
                self.lbOrderCount.text = [NSString stringWithFormat:@"共计 %@ 订单 ，销量 %@",[response[0] objectForKey:@"ordercount"],[response[0] objectForKey:@"orderproduct"]];
                self.lbDate.text = [NSString stringWithFormat:@"%@年%@月%@日->%@年%@月%@日",_arrayCalendar[2],_arrayCalendar[3],[_arrayCalendar[0] componentsSeparatedByString:@"-"][2],_arrayCalendar[2],_arrayCalendar[3],[_arrayCalendar[1] componentsSeparatedByString:@"-"][2]];
                NSArray *arrOrder  = [response[0] objectForKey:@"orderslist"];
                [arrayOrders removeAllObjects];
                for ( NSDictionary *orderDict in arrOrder) {
                    Order *order  = [Order getOrderFromDictionary:orderDict];
                    [arrayOrders addObject:order];
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
    return [arrayOrders count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indentifier = @"DueInComeCell";
    DueInComeCell *cell = (DueInComeCell*)[tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DueInComeCell" owner:self options:nil] objectAtIndex:0];
    }
    
    Order *order = [arrayOrders objectAtIndex:indexPath.row];
    cell.lbOder_Name.text = order.ctname;
    cell.lbOrderModel.text = order.ctmobileno;
    cell.lbDate.text = order.dt;
    cell.labMoney.text = [NSString stringWithFormat:@"%d元",order.moneys];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 88.0f;
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Order *order  = [arrayOrders objectAtIndex:indexPath.row];
    DetailOrderController *detailOrderController  = [[DetailOrderController alloc]initWithNibName:@"DetailOrderController" bundle:nil];
    detailOrderController.orderId = order.orderid;
    [self.navigationController pushViewController:detailOrderController animated:YES];
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

@end
