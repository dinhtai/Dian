//
//  ModelObject.h
//  Dian
//
//  Created by TaiND on 6/8/16.
//  Copyright © 2016 TaiND. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelObject : NSObject
@property (nonatomic, strong) NSString *model;
@property (nonatomic, strong) NSString *proname;
@property (nonatomic, strong) NSString *procount;
@property (nonatomic) float price;
@property (nonatomic) float total;
@property (nonatomic) float stock;
@property (nonatomic, strong) NSString *propic;
@property (nonatomic, strong) NSString *remarks;

+(id)getModelFromDictionary:(NSDictionary*)dict;

@end
