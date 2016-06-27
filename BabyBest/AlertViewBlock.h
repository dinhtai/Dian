//
//  NewsCollectionViewCell.m
//  Demo1
//
//  Created by TaiND on 3/26/16.
//  Copyright © 2016 TaiND. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Helper.h"

typedef void (^VoidBlock)(void);
typedef void (^AlertBlock)(BOOL status);

@interface AlertViewBlock : NSObject <UIAlertViewDelegate>

+ (void)showConfirmRetryMessage:(NSString *)message withTitle:(NSString *)title withBlock:(AlertBlock)aBlock;
+ (void)showConfirmGoMessage:(NSString *)message withBlock:(AlertBlock)aBlock;
+ (void)showConfirmGoMessage:(NSString *)message labelClose:(NSString*) labelClose labelGo:(NSString*) labelGo withBlock:(AlertBlock)aBlock;
+ (void)showOkMessage:(NSString *)message withBlock:(VoidBlock)aBlock;
+ (void)showOkMessage:(NSString *)message withTitle:(NSString *)title withBlock:(VoidBlock)aBlock;
+ (void)showMessage:(NSString *)message withButton:(NSString *)btnString withBlock:(VoidBlock)aBlock;

+ (void) showConfirmWithTwoButton:(NSString *)msg strLeftButton:(NSString *)leftButton
                   strRightButton:(NSString *)rightButton withBlock:(AlertBlock)aBlock;



@end
