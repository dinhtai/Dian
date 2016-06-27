//
//  MyOrder.h
//  Dian
//
//  Created by TaiND on 6/13/16.
//  Copyright © 2016 TaiND. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyOrder : NSObject
@property (nonatomic) float checksta;
@property (nonatomic, strong) NSString *cname;
@property (nonatomic) float dsta;
@property (nonatomic) int mobileno;
@property (nonatomic) float moneys;
@property (nonatomic) float orderid;
@property (nonatomic, strong) NSString *dt;

+(id)getMyOrdelFromDictionary:(NSDictionary*)dict;
@end
