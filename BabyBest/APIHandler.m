//
//  APIHandler.m
//  DoDate
//
//  Created by TaiND on 12/20/15.
//  Copyright © 2015 trojan_bk. All rights reserved.
//

#import "APIHandler.h"
#import "Constants.h"
#import "AFNetworking.h"


@implementation APIHandler


-(void)cancelRequest{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    for (NSOperation *operation in manager.operationQueue.operations) {
        [operation cancel];
    }
    
    [manager.operationQueue cancelAllOperations];
}

-(void)loginAccount:(NSString*)params withBlock:(DataBlock) block andErrorBlock:(VoidBlock) errorBlock{
    [self postAPI:DIAN_API_LOGIN params:params withBlock:^(id data) {
        if (block) {
            block(data);
        }
    } andErrorBlock:^{
        
    } retry:k_ModeRetryAlert];
}

-(void)updateAccount:(NSString*)params withBlock:(DataBlock)block andErrorBlock:(VoidBlock) errorBlock{
    [self postAPI:DIAN_API_UPDATE params:params withBlock:^(id data) {
        if (block) {
            block(data);
        }
    } andErrorBlock:^{
        
    } retry:k_ModeRetryAlert];
}

-(void)logoutAccount:(NSString*)params withBlock:(DataBlock)block andErrorBlock:(VoidBlock) errorBlock{
    [self postAPI:DIAN_API_LOGOUT params:params withBlock:^(id data) {
        if (block) {
            block(data);
        }
    } andErrorBlock:^{
        
    } retry:k_ModeRetryAlert];
}

-(void)forgotPassword:(NSString*)params withBlock:(DataBlock)block andErrorBlock:(VoidBlock) errorBlock{
    
    [self postAPI:DIAN_API_FORGOT_PASSWORD params:params withBlock:^(id data) {
        if (block) {
            block(data);
        }
    } andErrorBlock:^{
        
    } retry:k_ModeRetryAlert];
}

-(void)verifyModel:(NSString*)params withBlock:(DataBlock)block andErrorBlock:(VoidBlock) errorBlock{
    [self postAPI:DIAN_API_VERIFY_MODEL params:params withBlock:^(id data) {
        if (block) {
            block(data);
        }
    } andErrorBlock:^{
        
    } retry:k_ModeRetryAlert];
}

-(void)addProduct:(NSString*)params withBlock:(DataBlock)block andErrorBlock:(VoidBlock) errorBlock{
    [self postAPI:DIAN_API_ADD_PRODUCT params:params withBlock:^(id data) {
        if (block) {
            block(data);
        }
    } andErrorBlock:^{
        
    } retry:k_ModeRetryAlert];
}

-(void)editProduct:(NSString*)params withBlock:(DataBlock)block andErrorBlock:(VoidBlock) errorBlock{
    [self postAPI:DIAN_API_EDIT_PRODUCT params:params withBlock:^(id data) {
        if (block) {
            block(data);
        }
    } andErrorBlock:^{
        
    } retry:k_ModeRetryAlert];
    
}

-(void)delProduct:(NSString*)params withBlock:(DataBlock)block andErrorBlock:(VoidBlock) errorBlock{
    [self postAPI:DIAN_API_DELETE_PRODUCT params:params withBlock:^(id data) {
        if (block) {
            block(data);
        }
    } andErrorBlock:^{
        
    } retry:k_ModeRetryAlert];
    
}

-(void)getProduct:(NSString*)params withBlock:(DataBlock)block andErrorBlock:(VoidBlock) errorBlock{
    [self postAPI:DIAN_API_GET_PRODUCT params:params withBlock:^(id data) {
        if (block) {
            block(data);
        }
    } andErrorBlock:^{
        
    } retry:k_ModeRetryAlert];
}

-(void)getOrder:(NSString*)params withBlock:(DataBlock)block andErrorBlock:(VoidBlock) errorBlock{
    [self postAPI:DIAN_API_GET_ORDER params:params withBlock:^(id data) {
        if (block) {
            block(data);
        }
    } andErrorBlock:^{
        
    } retry:k_ModeRetryAlert];
    
}

-(void)getOrderDetail:(NSString*)params withBlock:(DataBlock)block andErrorBlock:(VoidBlock) errorBlock{
    [self postAPI:DIAN_API_GET_DETAIL_ORDER params:params withBlock:^(id data) {
        if (block) {
            block(data);
        }
    } andErrorBlock:^{
        
    } retry:k_ModeRetryAlert];
    
}

-(void)addOrder:(NSString*)params withBlock:(DataBlock)block andErrorBlock:(VoidBlock) errorBlock{
    
    [self postAPI:DIAN_API_ADD_ORDER params:params withBlock:^(id data) {
        if (block) {
            block(data);
        }
    } andErrorBlock:^{
        
    } retry:k_ModeRetryAlert];
    
}

-(void)paymentStatus:(NSString*)params withBlock:(DataBlock)block andErrorBlock:(VoidBlock) errorBlock{
    [self postAPI:DIAN_API_PAY_MENT params:params withBlock:^(id data) {
        if (block) {
            block(data);
        }
    } andErrorBlock:^{
        
    } retry:k_ModeRetryAlert];
    
}

-(void)getMyOrder:(NSString*)params withBlock:(DataBlock)block andErrorBlock:(VoidBlock) errorBlock{
    
    [self postAPI:DIAN_API_GET_MY_ORDER params:params withBlock:^(id data) {
        if (block) {
            block(data);
        }
    } andErrorBlock:^{
        
    } retry:k_ModeRetryAlert];
    
}

-(void)getMyOrderDetail:(NSString*)params withBlock:(DataBlock)block andErrorBlock:(VoidBlock) errorBlock{
    [self postAPI:DIAN_API_GET_MY_ORDER_DETAIL params:params withBlock:^(id data) {
        if (block) {
            block(data);
        }
    } andErrorBlock:^{
        
    } retry:k_ModeRetryAlert];
    
}

-(void)checkStatus:(NSString*)params withBlock:(DataBlock)block andErrorBlock:(VoidBlock) errorBlock{
    [self postAPI:DIAN_API_CHECK_STATUS params:params withBlock:^(id data) {
        if (block) {
            block(data);
        }
    } andErrorBlock:^{
        
    } retry:k_ModeRetryAlert];
    
}

-(void)getSalesList:(NSString*)params withBlock:(DataBlock)block andErrorBlock:(VoidBlock) errorBlock{
    [self postAPI:DIAN_API_SALES_LIST params:params withBlock:^(id data) {
        if (block) {
            block(data);
        }
    } andErrorBlock:^{
        
    } retry:k_ModeRetryAlert];
}

-(void)selectDate:(NSString*)params withBlock:(DataBlock)block andErrorBlock:(VoidBlock) errorBlock{
    [self postAPI:DIAN_API_SELECT_DATE params:params withBlock:^(id data) {
        if (block) {
            block(data);
        }
    } andErrorBlock:^{
        
    } retry:k_ModeRetryAlert];
}

-(void)getAbout:(NSString*)params withBlock:(DataBlock)block andErrorBlock:(VoidBlock) errorBlock{
    [self getAPI:DIAN_API_GET_ABOUT params:params withBlock:^(id data) {
        if (block) {
            block(data);
        }
    } andErrorBlock:^{
        
    } retry:k_ModeRetryAlert];
}

@end
