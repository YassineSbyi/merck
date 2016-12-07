//
//  UserDoc.m
//  merck
//
//  Created by mac on 01/12/2016.
//  Copyright © 2016 mac. All rights reserved.
//

#import "UserDoc.h"
#import "UserDatabase.h"
#import "User.h"
#define kDataKey        @"Data"
#define kDataFile       @"data.plist"
@implementation UserDoc


// At top of file

// After @implementation
@synthesize docPath = _docPath;
@synthesize Data = _data;

// Add to dealloc
_docPath = nil;

// Add new methods
- (id)init {
    if ((self = [super init])) {
    }
    return self;
}
- (id)initWithDictionary:(NSDictionary *)user {
    if ((self = [super init])) {
        _data = [[User alloc] initWithDictionary:user];
        
    }
    return self;
}
- (id)initWithDocPath:(NSString *)docPath {
    if ((self = [super init])) {
        _docPath = [docPath copy];
    }
    return self;
}
- (BOOL)createDataPath {
    
    if (_docPath == nil) {
        self.docPath = [UserDatabase nextUserDocPath];
    }
    
    NSError *error;
    BOOL success = [[NSFileManager defaultManager] createDirectoryAtPath:_docPath withIntermediateDirectories:YES attributes:nil error:&error];
    if (!success) {
        NSLog(@"Error creating data path: %@", [error localizedDescription]);
    }
    return success;
    
}
- (User *)data {
    
    if (_data != nil) return _data;
    
    NSString *dataPath = [_docPath stringByAppendingPathComponent:kDataFile];
    NSData *codedData = [[NSData alloc] initWithContentsOfFile:dataPath] ;
    if (codedData == nil) return nil;
    
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:codedData];
    _data = [unarchiver decodeObjectForKey:kDataKey] ;
    [unarchiver finishDecoding];
    
    return _data;
    
}
- (void)saveData {
    
    if (_data == nil) return;
    
    [self createDataPath];
    
    NSString *dataPath = [_docPath stringByAppendingPathComponent:kDataFile];
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:_data forKey:kDataKey];
    [archiver finishEncoding];
    [data writeToFile:dataPath atomically:YES];
    
    
}
- (void)deleteDoc {
    
    NSError *error;
    BOOL success = [[NSFileManager defaultManager] removeItemAtPath:_docPath error:&error];
    if (!success) {
        NSLog(@"Error removing document path: %@", error.localizedDescription);
    }
    
}
@end
