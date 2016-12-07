//
//  UserService.m
//  merck
//
//  Created by mac on 01/11/2016.
//  Copyright © 2016 mac. All rights reserved.
//
#import <Availability.h>


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "UserService.h"
#import "AppConstant.h"
#import "HTTPGetRequest.h"
#import "HTTPPostRequest.h"
#import "User.h"
@implementation UserService

- (void)authentification:(NSDictionary *)user completionBlock:(ServiceCompletionBlock)completionBlock {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", SERVICE_ENDPOINT_FORMAT, login]];
    
    SuccessBlock successBlock = ^(NSURLSessionTask *task, id responseObject) {
        NSError *error;
        
        
        if (!error) {
            completionBlock(responseObject, nil);
        } else {
            completionBlock(nil, error);
        }
    };
    
    FailureBlock failureBlock = ^(NSURLSessionTask *task, NSError *error) {
        completionBlock(nil, error);
    };
    
    NSLog(@"User details : %@", user);
    
    NSDictionary *parameters = user;
    
    HTTPPostRequest *request = [[HTTPPostRequest alloc] initWithURL:url andParameters:parameters successBlock:successBlock failureBlock:failureBlock];
    
    [request proceedRequest];
}

@end
