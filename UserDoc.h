//
//  UserDoc.h
//  merck
//
//  Created by mac on 01/12/2016.
//  Copyright © 2016 mac. All rights reserved.
//
#import <UIKit/UIKit.h>

#import <Foundation/Foundation.h>
@class User;

@interface UserDoc : NSObject{
NSString *_docPath;
    User *_data;

}
@property (nonatomic, retain) User *Data;

// After @interface
@property (copy) NSString *docPath;
- (id)init;
- (id)initWithDictionary:(NSDictionary *)user;

- (id)initWithDocPath:(NSString *)docPath;
- (void)saveData;
- (void)deleteDoc;
@end
