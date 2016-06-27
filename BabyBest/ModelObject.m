//
//  ModelObject.m
//  Dian
//
//  Created by TaiND on 6/8/16.
//  Copyright © 2016 TaiND. All rights reserved.
//

#import "ModelObject.h"

@implementation ModelObject
+(id)getModelFromDictionary:(NSDictionary*)dict{
    
    ModelObject *model = [[ModelObject alloc]init];
    model.model = [dict valueForKey:@"model"];
    model.proname = [dict valueForKey:@"proname"];
    model.procount = [dict valueForKey:@"procount"];
    model.price = [[dict valueForKey:@"price"] floatValue];
    model.total = [[dict valueForKey:@"total"] floatValue];
    model.propic = [dict valueForKey:@"propic"];
    model.remarks = [dict valueForKey:@"remarks"];
    model.stock = [[dict valueForKey:@"stock"] floatValue];
    
    return model;
}
@end
