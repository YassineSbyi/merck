//
//  User.h
//
//  Created by   on 20/01/2016
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface User : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *nomPrenom;
@property (nonatomic, assign) double internalBaseClassIdentifier;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *pays;


@property (nonatomic, strong) NSString *internalBaseClassDescription;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
