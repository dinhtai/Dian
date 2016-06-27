//
//  ErrorHandler.m
//  DoDate
//
//  Created by TaiND on 12/16/15.
//  Copyright © 2015 trojan_bk. All rights reserved.
//

#import "ErrorHandler.h"
#import "APIHandler.h"
#import "AFNetworking.h"
#import "Constants.h"

@implementation ErrorHandler

#pragma mark - Public methods
/*---------------------------------------------------------------------------
 * @desc: Handle errors when loading Webview getting error
 * @param: request's type is NSString or NSURLRequest
 * @return:
 * @author: TaiND
 *--------------------------------------------------------------------------*/
- (void)handleErrorLoadingWeb:(NSError *)error forRequest:(id)request {
    NSLog(@"handleErrorLoadingWeb with request %@", request);
    [self handleErrorNetworkOthers:error forRequest:request];
}

/*---------------------------------------------------------------------------
 * @desc: Handle errors with error code returned from Server when calling API
 * @param: request's type is NSString or NSURLRequest
 * @return:
 * @author: TaiND
 *--------------------------------------------------------------------------*/
- (void)handleErrorCallingWebservice:(NSError *)error forRequest:(id)request {
    NSLog(@"handleErrorCallingWebservice: %@ with request %@", error, request);
    
    
    NSInteger errorCode = error.code;
    switch (errorCode) {
        case kWebServiceFormatDataIncorrect:
            [self handleErrorWebServiceFormatDataIncorrect:error forRequest:request];
            break;
            
        default: // Other error
            [self proccessWebServiceError:error forRequest:request];
            break;
            
    }//end switch
}


/*---------------------------------------------------------------------------
 * @desc: Handle other common errors while running app
 * @param: error contains infomation to show
 * @return:
 * @author: TaiND
 *--------------------------------------------------------------------------*/
- (void)handleOtherError:(NSError *)error {
    NSLog(@"handleOtherError: %@", error);
    NSString *errormsg = [error localizedDescription];
    [self showErrorMessage: errormsg];
}


- (void)handleErrorNetworkOthers:(NSError *)error forRequest:(id)request {
    NSString *errorMsg = NSLocalizedString(@"Có lỗi mạng xảy ra, vui lòng thử lại!", nil);
    NSString *title = NSLocalizedString(K_APP_NAME, nil);
    if (!IS_NOT_NULL(request)) {
        [self showErrorMessage:errorMsg withTitle: title];
    } else {
        [self showRetryMessage:errorMsg withTitle: title forRequest: request];
    }
}

#pragma mark - Error calling webservice
- (void)handleErrorWebServiceFormatDataIncorrect:(NSError *)error forRequest:(id)request {
    NSLog(@"handleErrorWebServiceFormatDataIncorrect: %@ with request %@", error, request);
    
    // Trường hợp cần hiển thị mesage theo error code thì xử lý ở đây
    [self handleErrorNetworkOthers:error forRequest:request];
}

-(void)proccessWebServiceError:(NSError*) error forRequest:(id)request {
    NSLog(@"proccessWebServiceError: %@ with request %@", error, request);
    
    // Trường hợp cần hiển thị mesage theo error code thì xử lý ở đây
    [self handleErrorNetworkOthers:error forRequest:request];
}

// Request is kind of AFHTTPRequestOperation or NSURLRequest
- (void)retry:(id)request {
    if (IS_NOT_NULL(_delegate) && [_delegate respondsToSelector:@selector(retry:)]) {
        [_delegate retry:request];
    }
}

- (void)finish:(id)request {
    if (IS_NOT_NULL(_delegate) && [_delegate respondsToSelector:@selector(finish:)]) {
        [_delegate finish: request];
    }
}


#pragma mark - Common function

-(void) showErrorMessage:(NSString*) message withTitle:(NSString *)title {
    [AlertViewBlock showOkMessage: message withTitle: title  withBlock:^{
        
    }];
}

-(void) showErrorMessage:(NSString*) message{
    [AlertViewBlock showOkMessage: message withBlock:^{
        
    }];
}

-(void) showRetryMessage:(NSString *) message forRequest:(id)request {
    [AlertViewBlock showConfirmRetryMessage:message withTitle: @"" withBlock:^(BOOL status) {
        if (status) {
            [self retry: request];
        } else {
            [self finish: request];
        }
    }];
    
}

-(void) showRetryMessage:(NSString *) message withTitle:(NSString *)title forRequest:(id)request {
    [AlertViewBlock showConfirmGoMessage:message labelClose:@"Close" labelGo:@"Retry" withBlock:^(BOOL status) {
        if (status) {
            [self retry: request];
            
        } else {
            [self finish: request];
        }
        
    }];
}

@end
