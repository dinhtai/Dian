//
//  Constants.h
//  DoDate
//
//  Created by TaiND on 12/20/15.
//  Copyright © 2015 trojan_bk. All rights reserved.
//

#import <Foundation/Foundation.h>


#define K_NETWORK_TIMEOUT              30


#define AFHTTP_REQUEST_CONTENT_TYPE     @"application/json"
#define GET_ACCESS_TOKEN_CONTENT_TYPE   @"application/x-www-form-urlencoded"
#define ACCEPCONTENT_TYPE               @"text/html"

#define SERVER_URL                      @"http://182.92.70.230/kd"
#define AUTH_USERNAME                   @"Authorization"
#define AUTH_PASSWORD                   @"%access_token"

#define ENCRYPT_KEY                     @"43zRUsFoW6XWp50PsyZ5HKHRYV15n5ah9IJsuU2F"
#define CLIENT_ID                       @"AIzaSyA4UpuxJsvbRIlW7_bvJgpigBtA4fgBDKg"
#define CLIENT_SECRET    @"NoyLu2k3wQH3C7VgmSLoUzsS4AJzWpbyF0SyaqE2iQl6XoIysWVdLXs9RpL2DbS4kR1kquNAZiVn2CZG9fFvn0qd5OGkF5pEyU16fjkH9wDcBykrT5DDEwPdMfisHZCk"

#define GOOGLE_CLIENT_ID                @"891918662440-rnmis2g95q5s00beisah0q79f8bav048.apps.googleusercontent.com"

#define K_URL                           @"request_URL"
#define K_PARAMETERS                    @"parameters"
#define K_SUCCESS_BLOCK                 @"successBlock"
#define K_FAILURE_BLOCK                 @"failureBlock"
#define K_RESPONSE_BLOCK                @"responseBlock"


#define K_OPEN_DETAIL_PRODUCT           @"/p"
#define K_OPEN_SEARCH_PRODUCT           @"t="
#define K_OPEN_DETAIL_NEWS              @"-cn"
#define K_SEARCH_NOTOFI                 @"searchnotification"

#define K_APP_NAME ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"])

#define kWEBSOCKET_TIMEOUT                                 5


#define HASHTOKEN_TEST                  @"15C037785CE2FA7C14DBEAEF23E0718D"



/******************* api *************************/
//#define BABYBEST_API_REGISTER_NEW_ACCOUNT          @"/api/user/register"
#define DIAN_API_LOGIN                             @"/login.asp"
#define DIAN_API_UPDATE                            @"/update.asp"
#define DIAN_API_LOGOUT                            @"/logout.asp"
#define DIAN_API_FORGOT_PASSWORD                   @"/forgotpass.asp"
#define DIAN_API_VERIFY_MODEL                      @"/verimodel.asp"
#define DIAN_API_ADD_PRODUCT                       @"/addpro.asp"
#define DIAN_API_EDIT_PRODUCT                      @"/editpro.asp"
#define DIAN_API_DELETE_PRODUCT                    @"/delpro.asp"
#define DIAN_API_GET_PRODUCT                       @"/getpros.asp"
#define DIAN_API_GET_ORDER                         @"/getorders.asp"
#define DIAN_API_GET_DETAIL_ORDER                  @"/getorderdetail.asp"
#define DIAN_API_ADD_ORDER                         @"/addorder.asp"
#define DIAN_API_PAY_MENT                          @"/payset.asp"
#define DIAN_API_GET_MY_ORDER                      @"/getmyorders.asp"
#define DIAN_API_GET_MY_ORDER_DETAIL               @"/getmyorderdetail.asp"
#define DIAN_API_CHECK_STATUS                      @"/getmyorderdetail.asp"
#define DIAN_API_SALES_LIST                        @"/getsales.asp"
#define DIAN_API_SELECT_DATE                       @"/selectdate.asp"
#define DIAN_API_GET_ABOUT                         @"/getabout.asp"





/******************** code Error *****************/
#define k_UserNotFound     1011 //  Username not found, username must be 30 character or fewer
#define k_UserExist        1012 //  Username existed
#define k_PasswordNotFound 1013 //  Password not found
#define k_RegisterUserFail 1014 //  Register user fail

#define k_CanvasDomainNotFound      1020   // Canvas domain not found
#define k_CanvasDomainExisted       1021   // Canvas domain existed
#define k_IntegrateTokenNotFound    1022   // Integrate token not found
#define k_CanvasDomainInvalid       1023   // Canvas domain and Integrate token invalid
#define k_AddCanvasDomainFailed     1024   // Add Canvas domain and Integrate token failed


#define K_RESULT_CODE                       @"status"
#define K_SUCCESS_CODE                      200

#define SHIP_PRICE                          20.000

#define K_SelectTab                         @"selectTabAtIndex"
#define K_Price_Default                     @"đang cập nhật"


#define URL_ONEPAY                          @"https://mtf.onepay.vn/onecomm-pay/vpc.op"
#define SECURE_SECRET                       @"A3EFDFABA8653DF2342E8DAC29B51AF0"


@interface Constants : NSObject

@end
