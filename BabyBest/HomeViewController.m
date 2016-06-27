//
//  HomeViewController.m
//  BabyBest
//
//  Created by TaiND on 3/24/16.
//  Copyright © 2016 TaiND. All rights reserved.
//

#import "HomeViewController.h"
#import "APIHandler.h"
#import "Constants.h"
#import "Utils.h"
#import "Global.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "AppDelegate.h"
#import "HomeViewCell.h"
#import "OrderDetailController.h"
#import "ListProductController.h"
#import "SettingViewController.h"
#import "ProductRankController.h"
#import "DueInComeController.h"
#import "GetMyOrderController.h"
#import "Order.h"
#import "User.h"
#import "AddOrderController.h"


@interface HomeViewController ()<UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UIView *contentView;


@end

@implementation HomeViewController{
    NSArray *arrayTab;
    NSArray *arrayViewControllers;
    APIHandler *_apiHandler;
    NSMutableArray *_arrayProductSearch;
    __block int pageNumber;
    NSArray *arrayMonths;
    NSArray *arrayYears;
    NSMutableArray *arrayOrder;
    NSString *monthSelected;
    NSString *yearSelected;
    User *currentUser;
    NSArray *arrayCurrentDate;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Home ViewContrller ");
    _apiHandler = [[APIHandler alloc]initWithContentType:ACCEPCONTENT_TYPE];
    arrayOrder = [[NSMutableArray alloc]init];
    self.viewCalendar.hidden = YES;
    arrayMonths = [[NSArray alloc]initWithObjects:self.btnMonth1,self.btnMonth2,self.btnMonth3,self.btnMonth4,self.btnMonth5,self.btnMonth6,self.btnMonth7,self.btnMonth8,self.btnMonth9,self.btnMonth10,self.btnMonth11,self.btnMonth12, nil];
    arrayYears = [[NSArray alloc]initWithObjects:self.btnYear13,self.btnYear14,self.btnYear15,self.btnYear16, nil];

    self.img_CurrentUser.layer.cornerRadius  = self.img_CurrentUser.frame.size.height /2;
    self.img_CurrentUser.layer.masksToBounds = YES;
    self.img_CurrentUser.layer.borderWidth = 2.0f;
    
    
    self.tableView.backgroundColor = [UIColor colorWithRed:246.0f/255.0f green:246.0f/255.0f blue:246.0f/255.0f alpha:1];
    
    [self setUpCalendar];
    
    _btnNewOrderRound.hidden = YES;

    
    [self.btnCalendar setBackgroundImage:[UIImage imageNamed:@"img_btn_calendar_down"] forState:UIControlStateNormal];


    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenCalendar:)];
    [self.viewCalendar addGestureRecognizer:singleTap];
    
    
    // Get Current User
    currentUser = [[Global shareGlobal] getCurrentUser];
    NSLog(@"Current User %@", currentUser);
    [self.img_CurrentUser sd_setImageWithURL:[NSURL URLWithString:currentUser.portrait] placeholderImage:[UIImage imageNamed:@"icon_home"]];
    
    
    arrayCurrentDate = [Utils dateRangeForYear:NULL Month:NULL];
    
    [self.btnCalendar setTitle:[NSString stringWithFormat:@"%@年%@月",arrayCurrentDate[2],arrayCurrentDate[3]] forState:UIControlStateNormal];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bannerURLClicked:) name:K_SEARCH_NOTOFI object:nil];

    
    // get List Order and Calendar
    [self getListOrder:arrayCurrentDate[0] lastDay:arrayCurrentDate[1] page:pageNumber];
    [self getCalender:arrayCurrentDate];
    
    
    pageNumber = 0;
    __weak HomeViewController *weakSelf = self;
    
//    // setup pull-to-refresh
//    [self.tableView addPullToRefreshWithActionHandler:^{
//        [weakSelf insertRowAtTop];
//    }];
    
    // setup infinite scrolling
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf insertRowAtBottom];
    }];


    // Do any additional setup after loading the view from its nib.
}



- (void)getListOrder:(NSDate*)firstDay lastDay:(NSDate*)lastDay page:(int)page{
    NSString *bodyRequest = [NSString stringWithFormat:@"<xml><getorders><mobileno>%@</mobileno><token>%@</token><dtfrom>%@</dtfrom><dtto>%@</dtto><paid>0</paid><page>%d</page></getorders></xml>",currentUser.mobileno,currentUser.token,firstDay,lastDay,page];
    
    [_apiHandler getOrder:bodyRequest withBlock:^(id data) {
        id response = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSLog(@"%s - Data %@",__func__, response);
        if ([[response class] isSubclassOfClass:[NSArray class]]) {
            NSString *status  = [response[0] objectForKey:@"status"];
            if ([status isEqualToString:@"success"]) {
                int orderProduct = [[response[0] objectForKey:@"orderproduct"] intValue] ;
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.lbOrder_id.text = [NSString stringWithFormat:@"订单 %d 张，共计",orderProduct];
                });
                
                NSArray *arrOrder  = [response[0] objectForKey:@"orderslist"];
                [arrayOrder removeAllObjects];
                for ( NSDictionary *orderDict in arrOrder) {
                    Order *order  = [Order getOrderFromDictionary:orderDict];
                    [arrayOrder addObject:order];
                }
                [self.tableView reloadData];
            }
        }
    } andErrorBlock:^{
        
    }];
}


- (void)getCalender:(NSArray*)currentDate{
    
    // get Calendar
    NSString *bodyRequest = [NSString stringWithFormat:@"<xml><selectdate><mobileno>%@</mobileno><token>%@</token><dtfrom>%@</dtfrom><dtto>%@</dtto></selectdate></xml>",currentUser.mobileno,currentUser.token, currentDate[0],currentDate[1]];
    
    [self.btnCalendar setTitle:[NSString stringWithFormat:@"%@年%@月",currentDate[2],currentDate[3]] forState:UIControlStateNormal];
    [self.btnCalendar setBackgroundImage:[UIImage imageNamed:@"img_btn_calendar_down"] forState:UIControlStateNormal];
    
    [_apiHandler selectDate:bodyRequest withBlock:^(id data) {
        id response = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSLog(@"%s - Data %@",__func__,response);
        if ([[response class] isSubclassOfClass:[NSArray class]]) {
            NSString *status  = [response[0] objectForKey:@"status"];
            if ([status isEqualToString:@"success"]) {
                float dueincome = [[response[0] objectForKey:@"dueincome"] floatValue];
                float amount = [[response[0] objectForKey:@"amount"] floatValue];
                float ranking = [[response[0] objectForKey:@"product"] floatValue];
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.lbNumberProduct.text = [NSString stringWithFormat:@"%.2f", amount];
                    self.lbranking.text = [NSString stringWithFormat:@"%.1f", ranking];
                    self.lbdue_incone.text = [NSString stringWithFormat:@"%.2f", dueincome];
                });
            }
        }
        self.viewCalendar.hidden = YES;
    } andErrorBlock:^{
        
    }];

}


- (void)setUpCalendar{
    for (UIButton *btnMonth in arrayMonths) {
        [btnMonth setBackgroundImage:[UIImage imageNamed:@"img_btn_month"] forState:UIControlStateNormal];
        [btnMonth setBackgroundImage:[UIImage imageNamed:@"img_btn_year_selected"] forState:UIControlStateSelected];

    }
    
    for (UIButton *btnYear in arrayYears) {
        [btnYear setBackgroundImage:[UIImage imageNamed:@"img_btn_year"] forState:UIControlStateNormal];
        [btnYear setBackgroundImage:[UIImage imageNamed:@"img_btn_year_selected"] forState:UIControlStateSelected];
    }
}

- (void)bannerURLClicked:(NSNotification*)notification{
    NSDictionary *userinfor = [notification userInfo];
    NSString * banner_href = [userinfor objectForKey:@"banner_href"];
    if (banner_href) {
        [self showSearchView];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}



- (void)loadViewController {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)btnMenuClicked:(id)sender {
    SettingViewController *settingViewController = [[SettingViewController alloc]initWithNibName:@"SettingViewController" bundle:nil];
    [self.navigationController pushViewController:settingViewController animated:YES];
}

- (IBAction)btnSearchClicked:(id)sender {
    [self showSearchView];
}

- (void)showSearchView{

}

- (IBAction)btnSettingcClicked:(id)sender {
    ListProductController *listProduct = [[ListProductController alloc]initWithNibName:@"ListProductController" bundle:nil];
    [self.navigationController pushViewController:listProduct animated:YES];
    
}

- (void)dismissSearch{
}

#pragma mark - UISearchBar Delegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    // return NO to not become first responder
    return YES;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (searchText.length >= 3) {
        [self callApiSearchWithKeyWord:searchText];
    }
}// called when text changes (including clear)


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    // called when keyboard search button pressed
}

- (void)insertRowAtTop {
    __weak HomeViewController *weakSelf = self;
    NSArray *calendar = [Utils dateRangeForYear:yearSelected Month:monthSelected];

    int64_t delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [weakSelf getListOrder:calendar[0] lastDay:calendar[1] page:pageNumber];
        [weakSelf.tableView.pullToRefreshView stopAnimating];
    });
}


- (void)insertRowAtBottom {
    __weak HomeViewController *weakSelf = self;
    NSArray *calendar = [Utils dateRangeForYear:yearSelected Month:monthSelected];
    int64_t delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//        pageNumber++;
        [weakSelf getListOrder:calendar[0] lastDay:calendar[1] page:pageNumber];
        [weakSelf.tableView.infiniteScrollingView stopAnimating];
    });
}

- (void)callApiSearchWithKeyWord:(NSString*)keyword{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
//    [params setValue:page forKey:@"page"];
    [params setValue:keyword forKey:@"keyword"];
    [_arrayProductSearch removeAllObjects];

}


#pragma mark - UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [arrayOrder count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indentifier = @"homeViewCell";
    HomeViewCell *cell = (HomeViewCell*)[tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HomeViewCell" owner:self options:nil] objectAtIndex:0];
    }
    
    Order *order  = [arrayOrder objectAtIndex:indexPath.row];
    cell.product_name.text = order.ctname;
    cell.order_id.text = [NSString stringWithFormat:@"%@",order.ctmobileno];
    cell.product_price.text = [NSString stringWithFormat:@"%d元",order.moneys];
    cell.product_date.text = order.dt;
    cell.backgroundColor = [UIColor colorWithRed:246.0f/255.0f green:246.0f/255.0f blue:246.0f/255.0f alpha:1];
    
    cell.img_bg_row.layer.cornerRadius = 2;
    cell.img_bg_row.layer.masksToBounds = YES;
    
    
    if (!order.delsta && order.sta && order.dsta) {
        // paid
        cell.product_new.hidden = YES;
        cell.lb_type.hidden = YES;
        cell.icon_type.image = [UIImage imageNamed:@"img_icon_paid"];
    }else if(!order.delsta && !order.sta && !order.dsta){
        // paid
        cell.product_new.hidden = NO;
        cell.lb_type.hidden = NO;
        cell.lb_type.text = @"未发货";
        cell.icon_type.image = [UIImage imageNamed:@"img_icon_deliver"];
    }else{
        // delete
        cell.product_new.hidden = YES;
        cell.icon_type.image = [UIImage imageNamed:@"img_icon_trash"];
        cell.lb_type.text = @"已作废";

    }
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 93.0f;
}


#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Order *order  = [arrayOrder objectAtIndex:indexPath.row];
    OrderDetailController *orderDetailController  = [[OrderDetailController alloc]initWithNibName:@"OrderDetailController" bundle:nil];
    orderDetailController.orderId = order.orderid;
 
    [self.navigationController pushViewController:orderDetailController animated:YES];
}


#pragma mark - UItableView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"Scroll ");
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.bounds;
    CGSize size = scrollView.contentSize;
    UIEdgeInsets inset = scrollView.contentInset;
    float y = offset.y + bounds.size.height - inset.bottom;
    float h = size.height;
    
    
    if(y > h/2) {
        NSLog(@"Scroll Up");
        _btnOrder.hidden = YES;
        _btnEditProduct.hidden = YES;
        _btnNewOrderRound.hidden = NO;
        
    }else {
        NSLog(@"Scroll Down");
        _btnOrder.hidden = NO;
        _btnEditProduct.hidden = NO;
        _btnNewOrderRound.hidden = YES;
        

    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnRankClicked:(id)sender {
    
    ProductRankController *productRankController  = [[ProductRankController alloc] initWithNibName:@"ProductRankController" bundle:nil];
    productRankController.arrayCalendar = arrayCurrentDate;
    [self.navigationController pushViewController:productRankController animated:YES];
    
}

- (IBAction)btnDueInClicked:(id)sender {
    
    DueInComeController *dueInComeController  = [[DueInComeController alloc] initWithNibName:@"DueInComeController" bundle:nil];
    dueInComeController.arrayCalendar = arrayCurrentDate;
    [self.navigationController pushViewController:dueInComeController animated:YES];
    
}

- (IBAction)btnGetOrderClicked:(id)sender {
    
    GetMyOrderController *getMyOrderController  = [[GetMyOrderController alloc] initWithNibName:@"GetMyOrderController" bundle:nil];
    [self.navigationController pushViewController:getMyOrderController animated:YES];
}



- (IBAction)btnCalendarClicked:(id)sender {
    self.viewCalendar.hidden = NO;
    [self.btnCalendar setBackgroundImage:[UIImage imageNamed:@"img_btn_calendar_up"] forState:UIControlStateNormal];


}

- (void)hiddenCalendar:(UITapGestureRecognizer*)recognizer{
        self.viewCalendar.hidden = YES;
    [self.btnCalendar setBackgroundImage:[UIImage imageNamed:@"img_btn_calendar_down"] forState:UIControlStateNormal];

}

- (IBAction)btnSaveClicked:(id)sender {
    // get last date of month
    NSArray *calendar = [Utils dateRangeForYear:yearSelected Month:monthSelected];
    NSLog(@" Calendar Get: %@", calendar);

    // get list Order
    [self getListOrder:calendar[0] lastDay:calendar[1] page:pageNumber];
    
    // get Calendar
    [self getCalender:calendar];
    

}


- (IBAction)btnMonthClicked:(UIButton*)sender {
    monthSelected = [NSString stringWithFormat:@"%ld",(long)sender.tag + 1];
    for (UIButton *btnMonth in arrayMonths) {
        btnMonth.selected = NO;
    }
    sender.selected = YES;
}


- (IBAction)btnYearClicked:(UIButton*)sender {
    yearSelected = [NSString stringWithFormat:@"%@",sender.titleLabel.text];
    for (UIButton *btnYear in arrayYears) {
        btnYear.selected = NO;
    }
    sender.selected = YES;
}

- (IBAction)addOrderClicked:(id)sender {
    AddOrderController *addOrderController = [[AddOrderController alloc] initWithNibName:@"AddOrderController" bundle:nil];
    [self.navigationController pushViewController:addOrderController animated:YES];
}



@end
