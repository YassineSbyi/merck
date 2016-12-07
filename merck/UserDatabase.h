//
//  UserDatabase.h
//  merck
//
//  Created by mac on 01/12/2016.
//  Copyright © 2016 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDatabase : NSObject
// Add to bottom of file
+ (NSMutableArray *)loadUserDocs;
+ (NSString *)nextUserDocPath;
@end
