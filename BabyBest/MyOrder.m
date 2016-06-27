//
//  MyOrder.m
//  Dian
//
//  Created by TaiND on 6/13/16.
//  Copyright © 2016 TaiND. All rights reserved.
//

#import "MyOrder.h"

@implementation MyOrder
+(id)getMyOrdelFromDictionary:(NSDictionary*)dict{
    
    MyOrder *myModel = [[MyOrder alloc]init];
    myModel.checksta = [[dict valueForKey:@"checksta"] floatValue];
    myModel.cname = [dict valueForKey:@"cname"];
    myModel.dsta = [[dict valueForKey:@"dsta"] floatValue];
    myModel.dt = [dict valueForKey:@"dt"];
    myModel.mobileno = [[dict valueForKey:@"mobileno"] intValue];
    myModel.moneys = [[dict valueForKey:@"moneys"] floatValue];
    myModel.orderid = [[dict valueForKey:@"orderid"] floatValue];
    return myModel;
}
@end
