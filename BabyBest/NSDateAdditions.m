//
//  NSDateAdditions.m
//  DoDate
//
//  Created by TaiND on 1/9/16.
//  Copyright © 2016 TaiND. All rights reserved.
//

#import "NSDateAdditions.h"

@implementation NSDate (NSDateAdditions)

-(BOOL) isLaterThanOrEqualTo:(NSDate*)date {
    return !([self compare:date] == NSOrderedAscending);
}

-(BOOL) isEarlierThanOrEqualTo:(NSDate*)date {
    return !([self compare:date] == NSOrderedDescending);
}
-(BOOL) isLaterThan:(NSDate*)date {
    return ([self compare:date] == NSOrderedDescending);
    
}
-(BOOL) isEarlierThan:(NSDate*)date {
    return ([self compare:date] == NSOrderedAscending);
}

@end