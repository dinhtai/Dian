//
//  Stock.m
//  Dian
//
//  Created by TaiND on 6/6/16.
//  Copyright © 2016 TaiND. All rights reserved.
//

#import "Stock.h"

@implementation Stock
+(id)getStockFromDictionary:(NSDictionary*)dict{
    Stock *stock = [[Stock alloc]init];
    stock.Dt = [dict valueForKey:@"Dt"];
    stock.title = [dict valueForKey:@"title"];
    
    return stock;
}
@end
