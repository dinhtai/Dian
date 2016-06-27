//
//  Order.m
//  Dian
//
//  Created by TaiND on 6/5/16.
//  Copyright © 2016 TaiND. All rights reserved.
//

#import "Order.h"

@implementation Order
+(id)getOrderFromDictionary:(NSDictionary*)dict{
    Order *order = [[Order alloc]init];
    order.ctmobileno = [dict valueForKey:@"ctmobileno"];
    order.ctname = [dict valueForKey:@"ctname"];
    order.delsta = [[dict valueForKey:@"delsta"] intValue];
    order.dsta = [[dict valueForKey:@"dsta"] intValue];
    order.dt = [dict valueForKey:@"dt"];
    order.moneys = [[dict valueForKey:@"moneys"] intValue];
    order.orderid = [[dict valueForKey:@"orderid"] intValue];
    order.sta = [[dict valueForKey:@"orderid"] intValue];

    return order;
}
@end
