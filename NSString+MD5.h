//
//  NSString+MD5.h
//  merck
//
//  Created by mac on 30/11/2016.
//  Copyright © 2016 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSString (MD5)

- (NSString *)MD5Digest;

@end
