//
//  Utils.h
//  Hey Friend
//
//  Created by Dang Nguyen on 12/13/14.
//  Copyright (c) 2014 Dang Nguyen. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "UIImage+ImageWithColor.h"
//#import "MBProgressHUD.h"
#import "NSDate+Utilities.h"
#import "NSDictionary+Json.h"
#import "UIAlertView+Blocks.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define IS_IPAD   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_5 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0)
#define IS_IPHONE_6PLUS (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 736.0)
#define IS_IPHONE_6 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0)

#define DEVICE_ID  [[UIDevice currentDevice].identifierForVendor UUIDString]
#define IS_IOS8_OR_ABOVE ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)
@interface NSString (Utilities)
- (BOOL) isEmail;
- (NSString*)trim;
- (NSString*)trimExtra;
- (NSString *)md5;
- (BOOL) containsSubString:(NSString *)subString;
@end

@interface Utils : NSObject
+ (NSString *)uuidString;
+ (UIAlertView *)showAlertWithTitle:(NSString *)title andMsg:(NSString *)msg;
+ (void)registerPushNotification;
+ (NSString *)deviceTokenStringFromData:(NSData *)tokenData;
+ (BOOL)textIsNumber:(NSString *)str;
+ (NSString *)saveImageToCache:(UIImage *)image;
+ (NSString *)saveImageToCache:(UIImage *)image name:(NSString *)fileName;

+ (BOOL) networkConnected;
+ (id) loadJsonFromFile:(NSString *)fileName;
+ (void) callWithNumber:(NSString *)phoneNo;
+ (void) gotoWebsiteWithUrl:(NSString *)url;
+ (BOOL) networkConnectedByWifi;
+ (BOOL)networkConnectedBy3G;
+ (CGSize)sizeOfText:(NSString *)text width:(NSInteger ) width font:(UIFont *)font;
+ (NSString *)getStringIgnoreNull:(id) str;
+ (id)getObjectIgnoreNull:(id)obj;
+ (NSString *)readStringFromHtmlFile:(NSString *)filename extension:(NSString *)ext;
+ (void)setMaskTo:(UIView*)view byRoundingCorners:(UIRectCorner)corners withRadius:(CGFloat) radius;
+ (BOOL)stringIsValid:(id)str;
+ (UIAlertView *)showAlertWithTitle:(NSString *)title andMsg:(NSString *)msg delegate:(id)delegate;
+ (UIImage *)imageWithImage:(UIImage *)image scaleRatio:(CGFloat )scaleRatio;
+ (UIAlertView *)showAlertLocationServiceDeniedWithDelegate:(id)delegate;
+ (UIAlertView *)showAlertServerError;
+ (void)addShadowToView:(UIView *)view withPath:(UIBezierPath *)bezierPath;
+ (NSDictionary *)urlQueryParams:(NSURL *)url;
+ (NSString *)encodeStringIncludeEmoji:(NSString *)inputString;
+ (NSString *)decodeStringIncludeEmoji:(NSString *)inputString;
+ (BOOL)checkStringisPhoneNumber:(NSString*)inputString;
+ (NSString*)generateSecurehash:(NSArray*)data;
+ (NSString*)md5:(NSString*)input;
+ (NSString*)encodeURL:(NSString*)input;
+ (NSString*)getIPAddress;
+ (NSString *) hashString :(NSString *) data withSalt: (NSString *) salt;
+ (void)showToastMesseger:(NSString*)msg withView:(UIView*)view;
+ (NSArray*)dateRangeForYear:(NSString*)year Month:(NSString*)month;
+ (NSString *)encodeToBase64String:(UIImage *)image;
@end
