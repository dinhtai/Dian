//
//  NSDictionary+Json.h
//  ASIAInspection
//
//  Created by Dang Nguyen on 12/24/14.
//
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Json)
- (NSString *)toJsonString;
+ (NSDictionary *)dictFromUTF8JsonString:(NSString *)jsonString;
@end
