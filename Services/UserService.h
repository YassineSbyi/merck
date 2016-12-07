//
//  UserService.h
//  merck
//
//  Created by mac on 01/11/2016.
//  Copyright © 2016 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AppConstant.h" 

@interface UserService : NSObject
- (void)authentification:(NSDictionary *)user completionBlock:(ServiceCompletionBlock)completionBlock;
@end
