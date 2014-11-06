//
//  LocalFilePath.h
//  worldcupalarm
//
//  Created by zhaogyrain on 5/23/14.
//  Copyright (c) 2014 zhaogyrain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalFilePath : NSObject

+ (NSString *)getCachePath;
+ (NSString *)getSessionPath:(NSString *)dir;
+ (void )deleteDirectoryPath:(NSString *)dir;

+(NSMutableArray *)searchFileInDocumentDirctory:(NSString *)path;

@end
