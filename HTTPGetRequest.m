//
//  HTTPGetRequest.m
//  ChilliN
//
//  Created by Firstak on 15/01/2016.
//  Copyright © 2016 Firstak. All rights reserved.
//

#import "HTTPGetRequest.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface HTTPGetRequest ()
@property (nonatomic, strong) SuccessBlock successBlock;
@property (nonatomic, strong) FailureBlock failureBlock;
@property (nonatomic, strong) NSURL *requestURL;
@property (nonatomic, strong) NSDictionary *parameters;
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end

@implementation HTTPGetRequest

- (id)initWithURL:(NSURL *)requestURL andParameters:(NSDictionary *)parameters successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock {
    self = [super init];
    if (self) {
        self.manager  = [AFHTTPSessionManager manager];
        self.requestURL = requestURL;
        self.parameters = parameters;
        self.successBlock = successBlock;
        self.failureBlock = failureBlock;
    }
    return self;
}

- (void)proceedRequest {
    [self.manager GET:self.requestURL.absoluteString parameters:self.parameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        //NSLog(@"JSON: %@", responseObject);
        
        self.successBlock(task, responseObject);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
        self.failureBlock(operation, error);
    }];
    
}

@end
