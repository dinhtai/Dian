//
//  APIBase.m
//  DoDate
//
//  Created by TaiND on 12/20/15.
//  Copyright © 2015 trojan_bk. All rights reserved.
//

#import "APIBase.h"
#import "AFNetworking.h"
#import "AppDelegate.h"
#import "Constants.h"
#import "Helper.h"
#import "Global.h"

@interface APIBase()
@property (nonatomic, assign) int retryCount;
@property (nonatomic, strong) NSMutableDictionary *requestDict;

@end


@implementation APIBase



- (instancetype)initWithContentType:(NSString*)contentType{
    self = [super init];
    if (IS_NOT_NULL(self)) {
        
        _requestDict = [[NSMutableDictionary alloc] initWithCapacity:0];
        _manager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:SERVER_URL]];
        
        [_manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        _manager.requestSerializer.timeoutInterval = K_NETWORK_TIMEOUT;
        [_manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        _manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
        _manager.securityPolicy.allowInvalidCertificates = YES;
        [_manager.securityPolicy setValidatesDomainName:NO];
        
        _manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringCacheData;
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
        
        _errorHandler = [[ErrorHandler alloc]init];
        _errorHandler.delegate = self;
        
    }
    return self;
}
#pragma mark - ErrorHandlerDelegate
// Request is kind of AFHTTPRequestOperation
//- (void)retry:(id)requestID {
//    NSLog(@"Retry API %@", requestID);
//    if (IS_NOT_NULL(requestID)) {
//        NSDictionary *dict = [self.requestDict objectForKey: requestID];
//        if (IS_NOT_NULL(dict)) {
//            NSString *url = [dict objectForKey: K_URL];
//            NSDictionary *params = [dict objectForKey: K_PARAMETERS];
//            // success block
//            void (^successBlock)(AFHTTPRequestOperation *operation, id responseObject) = [dict objectForKey: K_SUCCESS_BLOCK];
//            // Failure block
//            void (^failureBlock)(AFHTTPRequestOperation *operation, NSError *error) = [dict objectForKey: K_FAILURE_BLOCK];
//            // Send Post to server
////            [self.manager POST: url parameters: params success: successBlock failure: failureBlock];
//        }
//    }
//   
//}


- (void)finish:(id)requestID {
    NSLog(@"finish API %@", requestID);
    
    if (IS_NOT_NULL(requestID)) {
    }
}


/**
 *  Get URL Request
 *
 */
- (NSMutableURLRequest*)getRequestFromApi:(NSString*)api params:(NSString*)body withMethod:(NSString*)method{
    
    NSURL *requestURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_URL,api]];
    NSMutableURLRequest *url = [NSMutableURLRequest requestWithURL:requestURL];
    NSData *bodyData = [body dataUsingEncoding:NSUTF8StringEncoding];
    NSString *bodyLength = [NSString stringWithFormat:@"%lu", (unsigned long) [body length]];
    
    [url addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [url addValue:bodyLength forHTTPHeaderField:@"Content-Length"];
    [url setHTTPMethod:method];
    [url setHTTPBody:bodyData];
    
    return url;
}



/*--------------------   POST API ---------------*/
- (void)postAPI:(NSString*) api params: (NSString*)body withBlock:(DataBlock)block andErrorBlock:(VoidBlock)errorBlock  retry:(RetryMode)mode{
    
    [Helper showLoadingWithStatus:@""];

    NSMutableURLRequest *url = [self getRequestFromApi:api params:body withMethod:@"POST"];
    
    NSURLSessionDataTask *task = [_manager dataTaskWithRequest:url completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSLog(@"Error %@", error);
        // Hidden Loading
        [Helper hiddenLoading];
        if (IS_NOT_NULL(error)) {
//            [self processNetworkError:error forRequest:url retry:mode];
            if (errorBlock) {
                errorBlock();
            }
        }else{
            if (block) {
                block(responseObject);
            }
        }
    }];
    
    [task resume];
    
}

/*--------------------   GET API ---------------*/
- (void)getAPI:(NSString*) api params: (NSString*)body withBlock:(DataBlock)block andErrorBlock:(VoidBlock)errorBlock  retry:(RetryMode)mode{
    
    NSMutableURLRequest *url = [self getRequestFromApi:api params:body withMethod:@"GET"];
    
    [_manager dataTaskWithRequest:url completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        // Hidden Loading
        [Helper hiddenLoading];
        if (IS_NOT_NULL(error)) {
            //            [self processNetworkError:error forRequest:url retry:mode];
            if (errorBlock) {
                errorBlock();
            }
        }else{
            if (block) {
                block(responseObject);
            }
        }
    }];
}


/*--------------------   PUT API ---------------*/
- (void)putAPI:(NSString*) api params: (NSString*)body withBlock:(DataBlock)block andErrorBlock:(VoidBlock)errorBlock  retry:(RetryMode)mode{
    
    NSMutableURLRequest *url = [self getRequestFromApi:api params:body withMethod:@"PUT"];
    
    [_manager dataTaskWithRequest:url completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        // Hidden Loading
        [Helper hiddenLoading];
        if (IS_NOT_NULL(error)) {
            //            [self processNetworkError:error forRequest:url retry:mode];
            if (errorBlock) {
                errorBlock();
            }
        }else{
            if (block) {
                block(responseObject);
            }
        }
    }];
}

/*--------------------   DELETE API ---------------*/
- (void)deleteAPI:(NSString*) api params: (NSString*)body withBlock:(DataBlock)block andErrorBlock:(VoidBlock)errorBlock  retry:(RetryMode)mode{
    
    NSMutableURLRequest *url = [self getRequestFromApi:api params:body withMethod:@"DELETE"];
    
    [_manager dataTaskWithRequest:url completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        // Hidden Loading
        [Helper hiddenLoading];
        if (IS_NOT_NULL(error)) {
            //            [self processNetworkError:error forRequest:url retry:mode];
            if (errorBlock) {
                errorBlock();
            }
        }else{
            if (block) {
                block(responseObject);
            }
        }
    }];
}




//- (void)postAPI:(NSString *)api params:(NSMutableDictionary *)params withBlock:(DataBlock)block andErrorBlock:(VoidBlock)errorBlock  retry:(RetryMode)mode{
//    // init url
//    NSString *url = [NSString stringWithFormat:@"%@%@",SERVER_URL, api];
//    // Store request for retry
//    NSString *key = [NSString stringWithFormat:@"%@?%@", [url description], params];
//    [Helper showLoadingWithStatus:@""];
//
//    // success block
//    void (^successBlock)(AFHTTPRequestOperation *operation, id responseObject) = ^(AFHTTPRequestOperation *operation, id responseObject) {
//        [Helper hiddenLoading];
//        NSLog(@"Request API Success!!");
//        NSLog(@"Response of API (%@): %@" , api, responseObject);
//        if (block) {
//            block(responseObject);
//        }
////        if ([[responseObject class] isSubclassOfClass:[NSDictionary class]]) {
////            // responseObject is Dictionary
////            NSInteger  responseCode = -1;
////            if (IS_NOT_NULL([responseObject objectForKey:K_RESULT_CODE])) {
////                responseCode = [[responseObject objectForKey:K_RESULT_CODE] integerValue];
////            }
////            if (responseCode == K_SUCCESS_CODE) {
////                block(responseObject);
////            }else{
////                NSError *error = [NSError errorWithDomain:@"Response Invalid JSON Format" code:kNetworkError userInfo:nil];
////                [self processNetworkError:error forRequest:key retry:mode];
////                if (errorBlock) {
////                    errorBlock();
////                }
////            }
////            
////        }else{
////            NSError *error = [NSError errorWithDomain:@"Response Invalid JSON Format" code:kNetworkError userInfo:nil];
////            [self processNetworkError:error forRequest:key retry:mode];
////            if (errorBlock) {
////                errorBlock();
////            }
////        }
//    };
//    
//    // Failure block
//    void (^failureBlock)(AFHTTPRequestOperation *operation, NSError *error) = ^(AFHTTPRequestOperation *operation, NSError *error) {
//        [Helper hiddenLoading];
//        NSLog(@"Error Request %@", error.description);
//        [self processNetworkError:error forRequest:url retry:mode];
//        if (errorBlock) {
//            errorBlock();
//        }
//
//    };
//    
//    NSLog(@"Start call API: %@  : %@, Timeout: %f", api, params, [_manager.requestSerializer timeoutInterval]);
//    
//    NSDictionary *dict = @{K_URL: url,
//                           K_SUCCESS_BLOCK: [successBlock copy],
//                           K_FAILURE_BLOCK: [failureBlock copy],
//                           K_RESPONSE_BLOCK: [block copy]};
//    [self.requestDict setObject: dict forKey: url];
//
//    // Send Post to server
//    [_manager POST: url parameters: params success: successBlock failure: failureBlock];
//
//}


//- (void)getAPI:(NSString*) api params: (NSMutableDictionary*) params withBlock:(DataBlock)block andErrorBlock:(VoidBlock)errorBlock  retry:(RetryMode)mode{
//    // init url
//    NSString *url = [NSString stringWithFormat:@"%@%@",SERVER_URL, api];
//    [Helper showLoadingWithStatus:@""];
//
//    // success block
//    void (^successBlock)(AFHTTPRequestOperation *operation, id responseObject) = ^(AFHTTPRequestOperation *operation, id responseObject) {
//        [Helper hiddenLoading];
//        NSLog(@"Request API Success!!");
//        NSLog(@"Response of API (%@): %@" , api, responseObject);
//        if ([[responseObject class] isSubclassOfClass:[NSDictionary class]]) {
//            // responseObject is Dictionary
//            block(responseObject);
//        }
//    };
//    
//    // Failure block
//    void (^failureBlock)(AFHTTPRequestOperation *operation, NSError *error) = ^(AFHTTPRequestOperation *operation, NSError *error) {
//        [Helper hiddenLoading];
//        NSLog(@"Error Request %@", error.description);
//        [self processNetworkError:error forRequest:url retry:mode];
//        if (errorBlock) {
//            errorBlock();
//        }
//    };
//    
//    NSLog(@"Start call API: %@  : %@, Timeout: %f", api, params, [_manager.requestSerializer timeoutInterval]);
//    NSDictionary *dict = @{K_URL: url,
//                           K_SUCCESS_BLOCK: [successBlock copy],
//                           K_FAILURE_BLOCK: [failureBlock copy],
//                           K_RESPONSE_BLOCK: [block copy]};
//    [self.requestDict setObject: dict forKey: url];
//    // Send Post to server
//    [_manager GET: url parameters: params success: successBlock failure: failureBlock];
//}
//
//- (void)putAPI:(NSString*) api params: (NSMutableDictionary*) params withBlock:(DataBlock)block andErrorBlock:(VoidBlock)errorBlock  retry:(RetryMode)mode{
//    // init url
//    NSString *url = [NSString stringWithFormat:@"%@%@",SERVER_URL, api];
//    [Helper showLoadingWithStatus:@""];
//    
//    // success block
//    void (^successBlock)(AFHTTPRequestOperation *operation, id responseObject) = ^(AFHTTPRequestOperation *operation, id responseObject) {
//        [Helper hiddenLoading];
//        NSLog(@"Request API Success!!");
//        NSLog(@"Response of API (%@): %@" , api, responseObject);
//        if ([[responseObject class] isSubclassOfClass:[NSDictionary class]]) {
//            // responseObject is Dictionary
//            block(responseObject);
//        }
//    };
//    
//    // Failure block
//    void (^failureBlock)(AFHTTPRequestOperation *operation, NSError *error) = ^(AFHTTPRequestOperation *operation, NSError *error) {
//        [Helper hiddenLoading];
//        NSLog(@"Error Request %@", error.description);
//        [self processNetworkError:error forRequest:url retry:mode];
//        if (errorBlock) {
//            errorBlock();
//        }
//    };
//    
//    NSLog(@"Start call API: %@  : %@, Timeout: %f", api, params, [_manager.requestSerializer timeoutInterval]);
//    NSDictionary *dict = @{K_URL: url,
//                           K_SUCCESS_BLOCK: [successBlock copy],
//                           K_FAILURE_BLOCK: [failureBlock copy],
//                           K_RESPONSE_BLOCK: [block copy]};
//    [self.requestDict setObject: dict forKey: url];
//    // Send Post to server
//    [_manager PUT: url parameters: params success: successBlock failure: failureBlock];
//}
//
//
//- (void)deleteAPI:(NSString*) api params: (NSMutableDictionary*) params withBlock:(DataBlock)block andErrorBlock:(VoidBlock)errorBlock  retry:(RetryMode)mode{
//    // init url
//    NSString *url = [NSString stringWithFormat:@"%@%@",SERVER_URL, api];
//    
//    //    NSString *dataNative = [Helper encryptBase64:params];
//    //    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:dataNative, K_POST_DATA, nil];
//    
//    //    // Store request for retry
//    //    NSString *key = [NSString stringWithFormat:@"%@?%@", [url description], [Helper generateParams: parameters]];
//    [Helper showLoadingWithStatus:@""];
//    // success block
//    void (^successBlock)(AFHTTPRequestOperation *operation, id responseObject) = ^(AFHTTPRequestOperation *operation, id responseObject) {
//        [Helper hiddenLoading];
//        NSLog(@"Request API Success!!");
//        NSLog(@"Response of API (%@): %@" , api, responseObject);
//        if ([[responseObject class] isSubclassOfClass:[NSDictionary class]]) {
//            // responseObject is Dictionary
//            block(responseObject);
//        }
//    };
//    
//    // Failure block
//    void (^failureBlock)(AFHTTPRequestOperation *operation, NSError *error) = ^(AFHTTPRequestOperation *operation, NSError *error) {
//        [Helper hiddenLoading];
//        NSLog(@"Error Request %@", error.description);
//        [self processNetworkError:error forRequest:url retry:mode];
//        if (errorBlock) {
//            errorBlock();
//        }
//    };
//    
//    NSLog(@"Start call API: %@  : %@, Timeout: %f", api, params, [_manager.requestSerializer timeoutInterval]);
//    NSDictionary *dict = @{K_URL: url,
//                           K_SUCCESS_BLOCK: [successBlock copy],
//                           K_FAILURE_BLOCK: [failureBlock copy],
//                           K_RESPONSE_BLOCK: [block copy]};
//    [self.requestDict setObject: dict forKey: url];
//    // Send Post to server
//    [_manager DELETE: url parameters: params success: successBlock failure: failureBlock];
//}


- (void)processNetworkError:(NSError *)error forRequest:(NSString *)request retry:(RetryMode)mode {
    [Helper hiddenLoading];
    switch (mode) {
        case k_ModeNone: {
            if (IS_NOT_NULL(request)) {
                [self.requestDict removeObjectForKey: request];
            }
            break;
        }
            
        case k_ModeAlert: {
            [self.errorHandler handleErrorCallingWebservice: error forRequest: nil];
            if (IS_NOT_NULL(request)) {
                [self.requestDict removeObjectForKey: request];
            }
            break;
        }
            
        case k_ModeRetrySilent: {
            // retry 5 lần
            if (_retryCount < 5) {
                _retryCount++;
                [self retry: request];
            } else {
                _retryCount = 0;
                mode = k_ModeNone;
                if (IS_NOT_NULL(request)) {
                    [self.requestDict removeObjectForKey: request];
                }
            }
            break;
        }
            
        case k_ModeRetryAlert: {
            [self.errorHandler handleErrorCallingWebservice: error forRequest: request];
            break;
        }
    }//end switch
}

@end
