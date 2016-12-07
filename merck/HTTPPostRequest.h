//
//  HTTPPostRequest.h
//  ChilliN
//
//  Created by Firstak on 15/01/2016.
//  Copyright © 2016 Firstak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

#import "AppConstant.h" // SuccessBlock And FailureBlock Definition

@interface HTTPPostRequest : NSObject

- (id)initWithURL:(NSURL *)requestURL andParameters:(NSDictionary *)parameters successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

- (void)proceedRequest;


@end
