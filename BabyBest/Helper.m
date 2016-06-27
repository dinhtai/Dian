//
//  Helper.m
//  DoDate
//
//  Created by TaiND on 12/20/15.
//  Copyright © 2015 trojan_bk. All rights reserved.
//

#import "Helper.h"
#import "Constants.h"
#import "SVProgressHUD.h"



@implementation Helper



+ (NSString*) replaceSpecialCharacterBase64: (NSString*) str{
    if (!str) {
        return @"";
    }
    
    NSString *result = str;
    result = [result stringByReplacingOccurrencesOfString:@"+"
                                               withString:@"-"];
    result = [result stringByReplacingOccurrencesOfString:@"/"
                                               withString:@"_"];
    result = [result stringByReplacingOccurrencesOfString:@"="
                                               withString:@"."];
    return result;
}


#pragma mark - Show Loading 
+ (void)showLoadingWithStatus:(NSString*)status{
    if ([SVProgressHUD isVisible]) {
        [SVProgressHUD setStatus:status];
    }else{
        [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
        [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
        [SVProgressHUD showWithStatus:status maskType:SVProgressHUDMaskTypeBlack];
    }
}
+ (void)hiddenLoading{
    [SVProgressHUD dismiss];
}

@end
