//
//  User.h
//  Dian
//
//  Created by TaiND on 6/5/16.
//  Copyright © 2016 TaiND. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property (nonatomic, strong) NSString *mobileno;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *cname;
@property (nonatomic, strong) NSString *company;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *portrait;
@property (nonatomic, strong) NSString *bank;
@property (nonatomic, strong) NSString *password;

+(id)getUsersFromDictionary:(NSDictionary*)dict;

@end
