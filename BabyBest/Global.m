//
//  Global.m
//  
//
//  Created by TaiND on 12/20/15.
//
//

#import "Global.h"

User* g_currentUser;


@implementation Global

static Global *g_sharedGlobal;

+ (Global *)shareGlobal{
    if (g_sharedGlobal == nil) {
        g_sharedGlobal = [[Global alloc]init];
    }
    return g_sharedGlobal;
}

- (void)setCurrentUser:(User*)currentUser{
    g_currentUser = currentUser;
}
- (User*)getCurrentUser{
    return g_currentUser;
}

@end
