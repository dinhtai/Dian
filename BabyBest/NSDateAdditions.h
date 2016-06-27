//
//  NSDateAdditions.h
//  DoDate
//
//  Created by TaiND on 1/9/16.
//  Copyright © 2016 TaiND. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Foundation/Foundation.h>

@interface NSDate (NSDateAdditions)
-(BOOL) isLaterThanOrEqualTo:(NSDate*)date;
-(BOOL) isEarlierThanOrEqualTo:(NSDate*)date;
-(BOOL) isLaterThan:(NSDate*)date;
-(BOOL) isEarlierThan:(NSDate*)date;
@end