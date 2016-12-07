//
//  User.m
//
//  Created by   on 20/01/2016
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "User.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NSString *const kUsernomPrenom = @"nomPrenom";
NSString *const kUserUsername  = @"username";
NSString *const kUserEmail     = @"email";
NSString *const kUserImage     = @"image";
NSString *const kUserId        = @"id";
NSString *const kUserPassword  = @"password";
NSString *const kUserPays      = @"pays";

@interface User ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation User

@synthesize nomPrenom = _nomPrenom;
@synthesize username = _username;
@synthesize email = _email;
@synthesize image = _image;
@synthesize internalBaseClassIdentifier = _internalBaseClassIdentifier;
@synthesize password = _password;
@synthesize pays = _pays;




+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // NSLog(@"IS Dictionary : %@", [dict isKindOfClass:[NSDictionary class]] == YES ? @"YES" : @"NO");
    
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.nomPrenom = [self objectOrNilForKey:kUsernomPrenom fromDictionary:dict];
        self.username = [self objectOrNilForKey:kUserUsername fromDictionary:dict];
        self.email = [self objectOrNilForKey:kUserEmail fromDictionary:dict];
        self.internalBaseClassIdentifier = [[self objectOrNilForKey:kUserId fromDictionary:dict] doubleValue];
        self.image = [self objectOrNilForKey:kUserImage fromDictionary:dict];
         self.password = [self objectOrNilForKey:kUserPassword fromDictionary:dict];
        self.pays = [self objectOrNilForKey:kUserPays fromDictionary:dict];

  
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.username forKey:kUserUsername];
    [mutableDict setValue:self.nomPrenom forKey:kUsernomPrenom];
    [mutableDict setValue:self.email forKey:kUserEmail];
    [mutableDict setValue:self.image forKey:kUserImage];
    [mutableDict setValue:self.password forKey:kUserPassword];
    [mutableDict setValue:[NSNumber numberWithDouble:self.internalBaseClassIdentifier] forKey:kUserId];
    [mutableDict setValue:self.pays forKey:kUserPays];
    
    return [NSDictionary dictionaryWithDictionary:mutableDict];
}



- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    self.username = [aDecoder decodeObjectForKey:kUserUsername];
    self.nomPrenom = [aDecoder decodeObjectForKey:kUsernomPrenom];
    self.email = [aDecoder decodeObjectForKey:kUserEmail];
    self.image = [aDecoder decodeObjectForKey:kUserImage];
    self.password = [aDecoder decodeObjectForKey:kUserPassword];
    self.pays = [aDecoder decodeObjectForKey:kUserPays];

    self.internalBaseClassIdentifier = [aDecoder decodeDoubleForKey:kUserId];

    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:_username forKey:kUserUsername];
    [aCoder encodeObject:_nomPrenom forKey:kUsernomPrenom];
    [aCoder encodeObject:_email forKey:kUserEmail];
    [aCoder encodeObject:_image forKey:kUserImage];
    [aCoder encodeObject:_password forKey:kUserPassword];
    [aCoder encodeDouble:_internalBaseClassIdentifier forKey:kUserId];
    [aCoder encodeObject:_pays forKey:kUserPays];

    
}

- (id)copyWithZone:(NSZone *)zone
{
    User *copy = [[User alloc] init];
    
    if (copy) {
        
        copy.username = [self.username copyWithZone:zone];
        copy.nomPrenom = [self.nomPrenom copyWithZone:zone];
        copy.image = [self.image copyWithZone:zone];
        copy.email = [self.email copyWithZone:zone];
        copy.password = [self.password copyWithZone:zone];
        copy.pays = [self.pays copyWithZone:zone];
        copy.internalBaseClassIdentifier = self.internalBaseClassIdentifier;

    }
    
    return copy;
}

@end
