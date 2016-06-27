//
//  Global.h
//  
//
//  Created by TaiND on 12/20/15.
//
//

#import <Foundation/Foundation.h>s
#import "User.h"


@interface Global : NSObject

+(Global*)shareGlobal;
- (void)setCurrentUser:(User*)currentUser;
- (User*)getCurrentUser;


@end
