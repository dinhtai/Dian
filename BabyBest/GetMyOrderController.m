//
//  GetMyOrderController.m
//  Dian
//
//  Created by TaiND on 5/29/16.
//  Copyright © 2016 TaiND. All rights reserved.
//

#import "GetMyOrderController.h"
#import "GetMyOrderCell.h"
#import "DetailOrderController.h"
#import "User.h"
#import "Global.h"
#import "Constants.h"
#import "APIHandler.h"
#import "MyOrder.h"

@interface GetMyOrderController ()

@end

@implementation GetMyOrderController{
    APIHandler *_apiHandler;
    NSMutableArray *arrayMyOrder;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    arrayMyOrder = [[NSMutableArray alloc]init];
    _apiHandler = [[APIHandler alloc] initWithContentType:ACCEPCONTENT_TYPE];
    // Do any additional setup after loading the view from its nib.
    [self getListMyOrder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getListMyOrder{
    User *currentUser = [[Global shareGlobal] getCurrentUser];
    NSString *bodyString  = [NSString stringWithFormat:@"<xml><getorders><mobileno>%@</mobileno><token>%@</token><page>1</page></getorders></xml>",currentUser.mobileno, currentUser.token];
    [_apiHandler getMyOrder:bodyString withBlock:^(id data) {
        id response = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSLog(@"%s - Data %@",__func__, response);
        if ([[response class] isSubclassOfClass:[NSArray class]]) {
            NSString *status  = [response[0] objectForKey:@"status"];
            [arrayMyOrder removeAllObjects];
            if ([status isEqualToString:@"success"]) {
                NSArray *morderArr = [response[0] objectForKey:@"orderslist"];
                for (NSDictionary *morderDict in morderArr) {
                    MyOrder *morder = [MyOrder getMyOrdelFromDictionary:morderDict];
                    [arrayMyOrder  addObject:morder];
                }
            }
            [self.tableView reloadData];
        }
    } andErrorBlock:^{
        
    }];
}


#pragma mark - UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [arrayMyOrder count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *indentifier = @"DueInComeCell";
    GetMyOrderCell *cell = (GetMyOrderCell*)[tableView dequeueReusableCellWithIdentifier:indentifier];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GetMyOrderCell" owner:self options:nil] objectAtIndex:0];
    }
    
    MyOrder *myOrder = [arrayMyOrder objectAtIndex:indexPath.row];
    cell.lbName.text = myOrder.cname;
    cell.lbModel.text = [NSString stringWithFormat:@"%d",myOrder.mobileno];
    cell.lbDate.text = myOrder.dt;
    cell.lbPrice.text = [NSString stringWithFormat:@"%.2f",myOrder.moneys];
    if (myOrder.checksta == 1) {
        cell.imgNew.hidden = NO;
    }else{
        cell.imgNew.hidden = YES;
    }
    
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 88.0f;
}


#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailOrderController *detailOrderController  = [[DetailOrderController  alloc]initWithNibName:@"DetailOrderController" bundle:nil];
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
