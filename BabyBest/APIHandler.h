//
//  APIHandler.h
//  DoDate
//
//  Created by TaiND on 12/20/15.
//  Copyright © 2015 trojan_bk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIBase.h"

@interface APIHandler : APIBase

-(void)cancelRequest;

-(void)loginAccount:(NSString*)params withBlock:(DataBlock) block andErrorBlock:(VoidBlock) errorBlock;

-(void)updateAccount:(NSString*)params withBlock:(DataBlock)block andErrorBlock:(VoidBlock) errorBlock;

-(void)logoutAccount:(NSString*)params withBlock:(DataBlock)block andErrorBlock:(VoidBlock) errorBlock;

-(void)forgotPassword:(NSString*)params withBlock:(DataBlock)block andErrorBlock:(VoidBlock) errorBlock;

-(void)verifyModel:(NSString*)params withBlock:(DataBlock)block andErrorBlock:(VoidBlock) errorBlock;

-(void)addProduct:(NSString*)params withBlock:(DataBlock)block andErrorBlock:(VoidBlock) errorBlock;

-(void)editProduct:(NSString*)params withBlock:(DataBlock)block andErrorBlock:(VoidBlock) errorBlock;

-(void)delProduct:(NSString*)params withBlock:(DataBlock)block andErrorBlock:(VoidBlock) errorBlock;

-(void)getProduct:(NSString*)params withBlock:(DataBlock)block andErrorBlock:(VoidBlock) errorBlock;

-(void)getOrder:(NSString*)params withBlock:(DataBlock)block andErrorBlock:(VoidBlock) errorBlock;

-(void)getOrderDetail:(NSString*)params withBlock:(DataBlock)block andErrorBlock:(VoidBlock) errorBlock;

-(void)addOrder:(NSString*)params withBlock:(DataBlock)block andErrorBlock:(VoidBlock) errorBlock;

-(void)paymentStatus:(NSString*)params withBlock:(DataBlock)block andErrorBlock:(VoidBlock) errorBlock;

-(void)getMyOrder:(NSString*)params withBlock:(DataBlock)block andErrorBlock:(VoidBlock) errorBlock;

-(void)getMyOrderDetail:(NSString*)params withBlock:(DataBlock)block andErrorBlock:(VoidBlock) errorBlock;

-(void)checkStatus:(NSString*)params withBlock:(DataBlock)block andErrorBlock:(VoidBlock) errorBlock;

-(void)getSalesList:(NSString*)params withBlock:(DataBlock)block andErrorBlock:(VoidBlock) errorBlock;

-(void)selectDate:(NSString*)params withBlock:(DataBlock)block andErrorBlock:(VoidBlock) errorBlock;

-(void)getAbout:(NSString*)params withBlock:(DataBlock)block andErrorBlock:(VoidBlock) errorBlock;

@end
