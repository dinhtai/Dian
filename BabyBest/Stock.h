//
//  Stock.h
//  Dian
//
//  Created by TaiND on 6/6/16.
//  Copyright © 2016 TaiND. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stock : NSObject
@property (nonatomic, strong) NSString *Dt;
@property (nonatomic, strong) NSString *title;

+(id)getStockFromDictionary:(NSDictionary*)dict;
@end
