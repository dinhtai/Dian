//
//  Utils.m
//  Hey Friend
//
//  Created by Dang Nguyen on 12/13/14.
//  Copyright (c) 2014 Dang Nguyen. All rights reserved.
//

#import "Utils.h"
#import <CommonCrypto/CommonDigest.h>
#import "Base64.h"
#include <ifaddrs.h>
#include <arpa/inet.h>
#import <CommonCrypto/CommonHMAC.h>
#import "NBPhoneNumberUtil.h"
#import "NBPhoneNumber.h"
#import "MBProgressHUD.h"



@implementation NSString (Utilities)
- (BOOL) isEmail {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [regExPredicate evaluateWithObject:self];
}
- (NSString*)trim {
    return [self stringByTrimmingCharactersInSet:
            [NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)trimExtra{
    NSString *str = [self trim];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"  +" options:NSRegularExpressionCaseInsensitive error:nil];
    return [regex stringByReplacingMatchesInString:str options:0 range:NSMakeRange(0, [str length]) withTemplate:@" "];
}

- (BOOL) containsSubString:(NSString *)subString{
    if (!subString || ![subString isKindOfClass:[NSString class]]) {
        NSLog(@"subString is nill or null.");
        return NO;
    }
    
    BOOL contains;
    
    if ([self rangeOfString:subString options:NSCaseInsensitiveSearch].location == NSNotFound) {
        contains = NO;
    } else {
        contains = YES;
    }
    
    return contains;
}

- (NSString *)md5{
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (int)strlen(cStr), result ); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

@end

@implementation Utils
+ (void)addShadowToView:(UIView *)view withPath:(UIBezierPath *)bezierPath{
    [view.layer setShadowColor:[UIColor lightGrayColor].CGColor];
    [view.layer setShadowPath:bezierPath.CGPath];
}

+ (UIAlertView *)showAlertWithTitle:(NSString *)title andMsg:(NSString *)msg{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alertView show];
    return alertView;
}

+ (UIAlertView *)showAlertWithTitle:(NSString *)title andMsg:(NSString *)msg delegate:(id)delegate{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:delegate cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alertView show];
    
    return alertView;
}

+ (UIAlertView *)showAlertServerError{
    return [Utils showAlertWithTitle:@">\"<" andMsg:@"Không thể kết nối tới máy chủ, xin thử lại sau ít phút nữa. Hoặc kiểm tra lại kết nối Internet."];
}

+ (NSString *)saveImageToCache:(UIImage *)image{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"temp_image.jpg"];
    [UIImageJPEGRepresentation(image, 1) writeToFile:filePath atomically:YES];
    return filePath;
}

+ (NSString *)saveImageToCache:(UIImage *)image name:(NSString *)fileName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:fileName];
    [UIImageJPEGRepresentation(image, 1) writeToFile:filePath atomically:YES];
    return filePath;
}


+ (NSString *)uuidString
{
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return (__bridge NSString *)string;
}

+ (void)registerPushNotification{
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert) categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else{
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }
}

+ (NSString *)deviceTokenStringFromData:(NSData *)tokenData{
    NSString* deviceTokenString = [[[[tokenData description]
                                stringByReplacingOccurrencesOfString: @"<" withString: @""]
                               stringByReplacingOccurrencesOfString: @">" withString: @""]
                             stringByReplacingOccurrencesOfString: @" " withString: @""];
    return deviceTokenString;
}

+ (BOOL)textIsNumber:(NSString *)str{
    NSCharacterSet *_numericOnly = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *myStringSet = [NSCharacterSet characterSetWithCharactersInString:str];
    
    if ([_numericOnly isSupersetOfSet: myStringSet]) {
        return YES;
    }
    return NO;
}

+ (BOOL)networkConnected{
    NetworkStatus status = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    if (status == NotReachable) {
        return NO;
    }
    return YES;
}

+ (id)loadJsonFromFile:(NSString *)fileName{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    id json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    return json;
}

+ (void)callWithNumber:(NSString *)phoneNo{
    NSString *phoneScheme = [@"tel://" stringByAppendingString:phoneNo];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneScheme]];
}

+ (void)gotoWebsiteWithUrl:(NSString *)url{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

+ (BOOL)networkConnectedByWifi{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    if(status != NotReachable){
        if (status == ReachableViaWiFi)
        {
            return YES;
        }
    }
    return NO;
}

+ (BOOL)networkConnectedBy3G{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    if(status != NotReachable){
        if (status == ReachableViaWWAN)
        {
            return YES;
        }
    }
    return NO;
}

+ (CGSize)sizeOfText:(NSString *)text width:(NSInteger ) width font:(UIFont *)font{
    //Label text
    NSString *aLabelTextString = text;
    
    //Label font
    UIFont *aLabelFont = font;
    
    //Width of the Label
    CGFloat aLabelSizeWidth = width;
    
    if ([[UIDevice currentDevice].systemVersion floatValue] < 7.0) {
        //version < 7.0
        return [aLabelTextString boundingRectWithSize:CGSizeMake(aLabelSizeWidth, MAXFLOAT)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:@{
                                                        NSFontAttributeName : aLabelFont
                                                        }
                                              context:nil].size;
    }else{
        //version >= 7.0
        //Return the calculated size of the Label
        return [aLabelTextString boundingRectWithSize:CGSizeMake(aLabelSizeWidth, MAXFLOAT)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:@{
                                                        NSFontAttributeName : aLabelFont
                                                        }
                                              context:nil].size;
    }
}

+ (NSDate *) dateFromString:(NSString *)dateString dateFormat:(NSString *)dateFormat{
    @try {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
        formatter.dateFormat = dateFormat;
        return [formatter dateFromString:dateString];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    return nil;
}

+ (NSString *)getStringIgnoreNull:(id)str{
    if (str == [NSNull null]) {
        return nil;
    }else if([str isKindOfClass:[NSString class]] && [str isEqualToString:@"null"]){
        return nil;
    }
    return str;
}

+ (id)getObjectIgnoreNull:(id)obj{
    if (obj == [NSNull null]) {
        return nil;
    }
    return obj;
}

+ (NSString *)readStringFromHtmlFile:(NSString *)filename extension:(NSString *)ext{
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:filename ofType:ext];
    return [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
}

+ (BOOL)stringIsValid:(id)str{
    if (!str || str == [NSNull null] || ![str isKindOfClass:[NSString class]] || [[str trim] isEqualToString:@""]) {
        return NO;
    }
    return YES;
}

+ (UIImage *)imageWithImage:(UIImage *)image scaleRatio:(CGFloat )scaleRatio{
    return [Utils imageWithImage:image scaledToSize:CGSizeMake(image.size.width * scaleRatio, image.size.height * scaleRatio)];
}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIAlertView *)showAlertLocationServiceDeniedWithDelegate:(id)delegate{
    UIAlertView *alertView;
    if (IS_IOS8_OR_ABOVE) {
        alertView = [[UIAlertView alloc] initWithTitle:@"Thông Báo" message:@"Bật Location để tìm sân bóng gần nhất" delegate:delegate cancelButtonTitle:@"Không" otherButtonTitles:@"Bật", nil];
        alertView.tag = 100;
    }else{
        alertView = [[UIAlertView alloc] initWithTitle:@"Thông Báo" message:@"Bật Location để tìm sân bóng gần nhất. Vào Settings > Privacy > Location Services > FootBall" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    }
    [alertView show];
    return alertView;
}

+ (void)setMaskTo:(UIView*)view byRoundingCorners:(UIRectCorner)corners withRadius:(CGFloat) radius{
    UIBezierPath *rounded = [UIBezierPath bezierPathWithRoundedRect:view.bounds
                                                  byRoundingCorners:corners
                                                        cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    view.layer.mask = shape;
}

+ (NSDictionary *)urlQueryParams:(NSURL *)url{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *param in [url.query componentsSeparatedByString:@"&"]) {
        NSArray *elts = [param componentsSeparatedByString:@"="];
        if([elts count] < 2) continue;
        [params setObject:[elts lastObject] forKey:[elts firstObject]];
    }
    return params;
}

+ (NSString *)encodeStringIncludeEmoji:(NSString *)inputString{
    return [inputString base64EncodedString];
}

+ (NSString *)decodeStringIncludeEmoji:(NSString *)inputString{
    return [inputString base64DecodedString];
}

+ (NSString*)generateSecurehash:(NSArray*)data{
    NSString *securehash = @"";
    
    for (NSString *element in data) {
//        NSString *elementEncoded = [self encodeURL:element];
        securehash = [NSString stringWithFormat:@"%@%@", securehash, element];
        NSLog(@"---- %@ - %@", element, securehash);
    }
    securehash = [NSString stringWithFormat:@"BabyBest@@%@", securehash];
    securehash = [[self md5:securehash] uppercaseString];
    
    return securehash;
}


+ (NSString*)md5:(NSString*)input
{

    const char * pointer = [input UTF8String];
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(pointer, (CC_LONG)strlen(pointer), md5Buffer);
    
    NSMutableString *string = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [string appendFormat:@"%02x",md5Buffer[i]];
    
    return string;
    
}

+ (NSString*)encodeURL:(NSString*)input {
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                 NULL,
                                                                                 (CFStringRef)input,
                                                                                 NULL,
                                                                                 (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                 kCFStringEncodingUTF8 ));
}

+ (NSString*)getIPAddress{
    
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    
                }
                
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
    
}

+(NSString *) hashString :(NSString *) data withSalt: (NSString *) salt {
    
    
    const char *cKey  = [salt cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [data cStringUsingEncoding:NSUTF8StringEncoding];
    unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    NSString *hash;
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", cHMAC[i]];
    hash = output;
    return hash;
    
}

+ (BOOL)checkStringisPhoneNumber:(NSString*)inputString{
    NSCharacterSet *cset = [NSCharacterSet characterSetWithCharactersInString:@"*#;"];
    if ([inputString rangeOfCharacterFromSet:cset].location == NSNotFound) {
        NBPhoneNumberUtil *phoneUtil = [[NBPhoneNumberUtil alloc] init];
        NSError *error  = nil;
        NBPhoneNumber *vnNumber = [phoneUtil parse:inputString defaultRegion:@"VN" error:&error];
        BOOL isValidate = [phoneUtil isValidNumber:vnNumber];
        NSNumber *countryCode = vnNumber.countryCode;
        if (isValidate) {
            if ([countryCode intValue] == 84) {
                return YES;
            }
        }
    }
    return NO;
}

+ (void)showToastMesseger:(NSString*)msg withView:(UIView*)view{
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hub.mode = MBProgressHUDModeText;
    hub.labelText = msg;
    hub.labelFont = [UIFont systemFontOfSize:11.0f];
    hub.margin = 10.f;
    hub.yOffset = 150.f;
    hub.removeFromSuperViewOnHide = YES;
    
    [hub hide:YES afterDelay:3];
}

+ (NSArray*)dateRangeForYear:(NSString*)year Month:(NSString*)month{
    
    // Build calendar and date components
    // get first date  of month
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc]init];
    [components setMonth:[month intValue]];
    [components setYear:[year intValue]];
    
    NSDate *date;
    if (!IS_NOT_NULL(month) || !IS_NOT_NULL(year)) {
        
        date = [NSDate date];
        NSDateComponents* component_Current = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date]; // Get necessary date components

        month = [NSString stringWithFormat:@"%ld",(long)[component_Current month]];
        year = [NSString stringWithFormat:@"%ld",(long)[component_Current year]];

    }else{
        date = [calendar dateFromComponents:components];
  
    }
    
    NSLog(@"Month %@ - Years %@. Calendar %@",month,year, date);
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    NSUInteger numberOfDaysInMonth = range.length;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // Convert my date object into yyyy-mm-dd string object
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    // get first date
    [components setDay:1];
    [components setMonth:[month intValue]];
    [components setYear:[year intValue]];
    NSString *firstDate = [dateFormatter stringFromDate:[calendar dateFromComponents:components]];
    
    // get last date
    [components setDay:numberOfDaysInMonth];
    [components setMonth:[month intValue]];
    [components setYear:[year intValue]];
    NSString *lastDate = [dateFormatter stringFromDate:[calendar dateFromComponents:components]];
    
    return @[firstDate, lastDate, year, month];
}



+ (NSString *)encodeToBase64String:(UIImage *)image {
    
    NSData* jpgData = [[NSData alloc] initWithData:UIImageJPEGRepresentation(image, 1.0f)];

    return [jpgData base64EncodedStringWithOptions:NSDataBase64Encoding76CharacterLineLength];
}

@end



