//
//  NSArray+Json.m
//  ASIAInspection
//
//  Created by Dang Nguyen on 12/24/14.
//
//

#import "NSArray+Json.h"

@implementation NSArray (Json)
- (NSString *)toJsonString{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:0
                                                         error:&error];
    
    if (!jsonData) {
        NSLog(@"Array to JSON error: %@", error.localizedDescription);
        return @"[]";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}
@end
