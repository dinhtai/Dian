//
//  NSDictionary+Json.m
//  ASIAInspection
//
//  Created by Dang Nguyen on 12/24/14.
//
//

#import "NSDictionary+Json.h"

@implementation NSDictionary (Json)
- (NSString *)toJsonString{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:0
                                                        error:&error];
    if (! jsonData) {
        NSLog(@"NSDictionary to Json: error: %@", error.localizedDescription);
        return @"{}";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}

+ (NSDictionary *)dictFromUTF8JsonString:(NSString *)jsonString{
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    if (data) {
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        return json;
    }
    return nil;
}
@end
