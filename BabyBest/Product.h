//
//  Product.h
//  BabyBest
//
//  Created by TaiND on 3/27/16.
//  Copyright © 2016 TaiND. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface Product : NSObject
@property (nonatomic) int delsta;
@property (nonatomic) int product_id;
@property (nonatomic, strong) NSString *model;
@property (nonatomic) float price;
@property (nonatomic, strong) NSString *proname;
@property (nonatomic, strong) NSString *propic;
@property (nonatomic, strong) NSString *remarks;
@property (nonatomic) float stock;
@property (nonatomic, strong) NSArray *stocklist;
@property (nonatomic) int total;

+(id)getProductFromDictionary:(NSDictionary*)dict;
@end
