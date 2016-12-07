//
//  AppConstant.h
//  ChilliN
//
//  Created by Firstak on 18/01/2016.
//  Copyright © 2016 Firstak. All rights reserved.
//
#import <Availability.h>

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#ifndef AppConstant_h
#define AppConstant_h

#define IS_IPHONE ( [ [ [ UIDevice currentDevice ] model ] isEqualToString: @"iPhone" ] )
#define IS_IPOD   ( [ [ [ UIDevice currentDevice ] model ] isEqualToString: @"iPod touch" ] )

#define IS_WIDESCREEN_IOS7 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IS_WIDESCREEN_IOS8 ( fabs( ( double )[ [ UIScreen mainScreen ] nativeBounds ].size.height - ( double )1136 ) < DBL_EPSILON )
#define IS_WIDESCREEN      ( ( [ [ UIScreen mainScreen ] respondsToSelector: @selector( nativeBounds ) ] ) ? IS_WIDESCREEN_IOS8 : IS_WIDESCREEN_IOS7 )


#define IS_IPHONE_5 ( IS_IPHONE && IS_WIDESCREEN )


/* Type Defs */

typedef void(^ServiceCompletionBlock)(id result, NSError *error);
typedef void(^SuccessBlock)(NSURLSessionTask *task, id responseObject); //NSData
typedef void(^FailureBlock)(NSURLSessionTask *operation, NSError *error); //NSError



/* Services EndPoints */
#define SERVICE_ENDPOINT_FORMAT			@"http://firstak.com/merck/web/api/"


/* Users paths */
#define GET_USER_PATH					@"seconnecters/"
#define login				         	@"logins/"


#endif /* AppConstant_h */
