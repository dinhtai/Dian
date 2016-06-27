//
//  Order.h
//  Dian
//
//  Created by TaiND on 6/5/16.
//  Copyright © 2016 TaiND. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Order : NSObject
@property (nonatomic, strong) NSString *ctmobileno;
@property (nonatomic, strong) NSString *ctname;
@property (nonatomic) int delsta;
@property (nonatomic) int dsta;
@property (nonatomic, strong) NSString *dt;
@property (nonatomic) int moneys;
@property (nonatomic) int orderid;
@property (nonatomic) int sta;

+(id)getOrderFromDictionary:(NSDictionary*)dict;
@end
