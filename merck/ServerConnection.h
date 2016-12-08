//
//  ServerConnection.h
//  merck
//
//  Created by Asma Saidi on 05/12/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ServiceCompletionBlock)(id result, NSError *error);
typedef void(^SuccessBlock)(NSURLSessionTask *task, id responseObject); //NSData
typedef void(^FailureBlock)(NSURLSessionTask *operation, NSError *error); //NSError

@interface ServerConnection : NSObject


- (void)addUserWithDictionary:(NSDictionary *)user completionBlock:(ServiceCompletionBlock)completionBlock;
- (void)getcompagnebydelegues:(NSString *)idUser completionBlock:(ServiceCompletionBlock)completionBlock;

@end
