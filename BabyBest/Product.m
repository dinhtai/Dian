//
//  Product.m
//  BabyBest
//
//  Created by TaiND on 3/27/16.
//  Copyright © 2016 TaiND. All rights reserved.
//

#import "Product.h"

@implementation Product
+(id)getProductFromDictionary:(NSDictionary*)dict{
    Product *product = [[Product alloc]init];
    
    product.delsta = [[dict valueForKey:@"delsta"] intValue];
    product.product_id = [[dict valueForKey:@"id"] intValue];
    product.model = [dict valueForKey:@"model"];
    product.price = [[dict valueForKey:@"price"] floatValue];
    product.proname = [dict valueForKey:@"proname"];
    product.propic = [dict valueForKey:@"propic"];
    product.remarks = [dict valueForKey:@"remarks"];
    product.stock = [[dict valueForKey:@"stock"] floatValue];
    product.stocklist = [dict valueForKey:@"stocklist"];
    return product;
}
@end
