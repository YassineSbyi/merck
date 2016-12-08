//
//  UserService.m
//  ChilliN
//
//  Created by Firstak on 15/01/2016.
//  Copyright © 2016 Firstak. All rights reserved.
//

#import "ServerConnection.h"
#import "HTTPGetRequest.h"
#import "HTTPPostRequest.h"
#import "User.h"
#import "UserDoc.h"
#import "UserDatabase.h"

static NSString *ServerURL = @"http://mytraining.merckcloud.com/api/";
static NSString *ServerURLdev = @"http://firstak.com/merck/web/api/";
#define get_compagne_by_delegues @"compagnebydelegues/"
#define login	@"logins"

@implementation ServerConnection


- (void)addUserWithDictionary:(NSDictionary *)user completionBlock:(void(^)(id result, NSError *error))completionBlock {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", ServerURLdev, login]];
    
    SuccessBlock successBlock = ^(NSURLSessionTask *task, id responseObject) {
        NSError *error;
        
        //        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
        // Data parsed correctly
        if (!error) {
            //User *user = [[User alloc] initWithDictionary:responseObject];
            
            completionBlock(responseObject, nil);
        } else {
            completionBlock(nil, error);
        }
    };
    
    FailureBlock failureBlock = ^(NSURLSessionTask *task, NSError *error) {
        completionBlock(nil, error);
    };
    
    NSDictionary *parameters = user;
    
    HTTPPostRequest *request = [[HTTPPostRequest alloc] initWithURL:url andParameters:parameters successBlock:successBlock failureBlock:failureBlock];
    [request proceedRequest];
}
- (void)getcompagnebydelegues:(NSString *)idUser completionBlock:(ServiceCompletionBlock)completionBlock
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@", ServerURL, get_compagne_by_delegues, idUser]];
    
    SuccessBlock successBlock = ^(NSURLSessionTask *task, id responseObject)
    {
        NSError *error;
        
        if (!error)
        {
            completionBlock(responseObject, nil);
            NSLog(@"responseObject get user profile ==== %@", responseObject);
            
        }
        else
        {
            completionBlock(nil, error);
        }
    };
    FailureBlock failureBlock = ^(NSURLSessionTask *task, NSError *error)
    {
        completionBlock(nil, error);
    };
    
    HTTPGetRequest *request = [[HTTPGetRequest alloc] initWithURL:url andParameters:nil successBlock:successBlock failureBlock:failureBlock];
    [request proceedRequest];
}
@end
