//
//  LocalFilePath.m
//  worldcupalarm
//
//  Created by zhaogyrain on 5/23/14.
//  Copyright (c) 2014 zhaogyrain. All rights reserved.
//

#import "LocalFilePath.h"

@implementation LocalFilePath


+ (NSString *)getCachePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSLog(@"docDir is %@", docDir);
    return docDir;
}

+ (NSString *)getSessionPath:(NSString *)dir
{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *sessionDir = [NSString stringWithFormat:@"%@/%@", [LocalFilePath getCachePath], dir];
    if (![manager createDirectoryAtPath:sessionDir withIntermediateDirectories:YES attributes:nil error:nil]) {
        return nil;
    }
    NSLog(@"sessionDir is %@", sessionDir);
    return sessionDir;
}

+(NSMutableArray *)searchFileInDocumentDirctory:(NSString *)path
{
    NSMutableArray *picPathArray = [[NSMutableArray alloc]init];
//    NSFileManager *fm = [NSFileManager defaultManager];
//    //如果没有目录则创建信息储存目录
//    [fm createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
//    
//    //递归枚举目录
//    NSDirectoryEnumerator *dirEnumerater = [fm enumeratorAtPath:path];
//    NSString * filePath = nil;
//    while (nil != (filePath = [dirEnumerater nextObject])) {
//        //        NSLog(@"%@",filePath);
//        NSString *msgdir = [NSString stringWithFormat:@"%@/%@",path,filePath];
//        BOOL isDir;
//        if ([fm fileExistsAtPath:msgdir isDirectory:&isDir]) {
//            if (!isDir) {
//                if ([[filePath lastPathComponent] isEqualToString:@".png"]||[[filePath lastPathComponent] isEqualToString:@".jpg"]||[[filePath lastPathComponent] isEqualToString:@".jpeg"]) {
//                    [picPathArray addObject:msgdir];
//                }
//            }
//        }
//    }
    
    NSFileManager *manager;
    manager = [NSFileManager defaultManager];
    NSString *home;
    home = [@"~" stringByExpandingTildeInPath];//获得主目录路径
    NSDirectoryEnumerator *direnum;
    direnum = [manager enumeratorAtPath: path];//枚举home下的目录
    NSLog(@"home=%@,direnum=%@",home,direnum);
    NSMutableArray *files;
    files = [NSMutableArray arrayWithCapacity:5];
    NSString *filename;
    while (filename = [direnum nextObject]) {
        if ([[filename pathExtension] isEqualToString:@"jpg"] || [[filename pathExtension] isEqualToString:@"png"] || [[filename pathExtension] isEqualToString:@"jpeg"] || [[filename pathExtension] isEqualToString:@"mp4"]){//判断路径的后缀名是否为m4r
            NSString * strPath = [[NSString alloc]initWithFormat:@"%@%@",path,filename];
            [files addObject: strPath];
        }
    }
    NSEnumerator *fileenum;
    fileenum = [files objectEnumerator];//枚举数组files
    while (filename = [fileenum nextObject]) {
        NSLog (@"%@", filename);
    }
    
    return files;
}

+ (void)deleteDirectoryPath:(NSString *)dir
{
    NSString *imageDir = [NSString stringWithFormat:@"%@/%@", [LocalFilePath getCachePath], dir];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:imageDir error:nil];
}



@end
