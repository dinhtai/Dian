//
//  ErrorHandler.h
//  DoDate
//
//  Created by TaiND on 12/16/15.
//  Copyright © 2015 trojan_bk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AlertViewBlock.h"
@class AFHTTPRequestOperation;

@protocol ErrorHandlerDelegate <NSObject>

@optional
// Request is kind of NSString or NSURLRequest
- (void)retry:(id)request;
- (void)finish:(id)request;

@end


typedef enum {
    k_ModeNone = 0, // không retry, không show alert
    k_ModeAlert, // không retry. Only show alert
    k_ModeRetrySilent, // retry ngầm
    k_ModeRetryAlert // Hỏi user có muốn Retry không
} RetryMode;


// Define all error codes that app can handle
typedef enum {
    // Error loading Web view
    //401 Unauthorized
    kNetworkUnauthorized = 401,
    // 408 Request Timeout
    kNetworkRequestTimeout = 408,
    //500 Internal Server Error
    kNetworkInternalServerError = 500,
    //-1011 Network Not Found
    kNetworkNotFound404 = -1011,
    
    // Error calling webservice
    kWebServiceError = 1001,
    kWebServiceErrorRetry = 0,
    kWebServiceFormatDataIncorrect = 2000,
    kNetworkError = 9111
    
    // Other Errors
    
} ErrorCode;


@interface ErrorHandler : NSObject

@property (nonatomic, assign) id<ErrorHandlerDelegate> delegate;//Used to retry the operation


/*---------------------------------------------------------------------------
 * @desc: Handle errors when loading Webview getting error
 * @param: request's type is NSString or NSURLRequest
 * @return:
 * @author: TaiND
 *--------------------------------------------------------------------------*/
- (void)handleErrorLoadingWeb:(NSError *)error forRequest:(id)request;


/*---------------------------------------------------------------------------
 * @desc: Handle errors with error code returned from Server when calling API
 * @param: request's type is NSString or NSURLRequest
 * @return:
 * @author: TaiND
 *--------------------------------------------------------------------------*/
- (void)handleErrorCallingWebservice:(NSError *)error forRequest:(id)request;


/*---------------------------------------------------------------------------
 * @desc: Handle other common errors while running app
 * @param: error contains infomation to show
 * @return:
 * @author: TaiND
 *--------------------------------------------------------------------------*/
- (void)handleOtherError:(NSError *)error;


-(void) showErrorMessage:(NSString*) message withTitle:(NSString *)title;

@end
