//
//  Helper.h
//  DoDate
//
//  Created by TaiND on 12/20/15.
//  Copyright © 2015 trojan_bk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Helper : NSObject
+ (NSString*) replaceSpecialCharacterBase64: (NSString*) str;
+ (void)showLoadingWithStatus:(NSString*)status;
+ (void)hiddenLoading;
@end
