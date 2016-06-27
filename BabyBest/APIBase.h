//
//  APIBase.h
//  DoDate
//
//  Created by TaiND on 12/20/15.
//  Copyright © 2015 trojan_bk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ErrorHandler.h"

@class AFHTTPSessionManager;


@interface APIBase : NSObject<ErrorHandlerDelegate>

@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) ErrorHandler *errorHandler;

- (void)postAPI:(NSString*) api params: (NSString*)body withBlock:(DataBlock)block andErrorBlock:(VoidBlock)errorBlock  retry:(RetryMode)mode;

- (void)getAPI:(NSString*) api params: (NSString*)body withBlock:(DataBlock)block andErrorBlock:(VoidBlock)errorBlock  retry:(RetryMode)mode;

- (void)putAPI:(NSString*) api params: (NSString*)body withBlock:(DataBlock)block andErrorBlock:(VoidBlock)errorBlock  retry:(RetryMode)mode;

- (void)deleteAPI:(NSString*) api params: (NSString*)body withBlock:(DataBlock)block andErrorBlock:(VoidBlock)errorBlock  retry:(RetryMode)mode;

- (instancetype)initWithContentType:(NSString*)contentType;

@end
