//
//  User.m
//  Dian
//
//  Created by TaiND on 6/5/16.
//  Copyright © 2016 TaiND. All rights reserved.
//

#import "User.h"

@implementation User
+(id)getUsersFromDictionary:(NSDictionary*)dict{
    User *user = [[User alloc]init];
    user.mobileno = [dict valueForKey:@"mobileno"];
    user.token = [dict valueForKey:@"token"];
    user.cname = [dict valueForKey:@"cname"];
    user.company = [dict valueForKey:@"company"];
    user.address = [dict valueForKey:@"address"];
    user.portrait = [dict valueForKey:@"portrait"];
    user.bank = [dict valueForKey:@"bank"];
    user.password = [dict valueForKey:@"password"];
    
    return user;
}
@end
