//
//  Utility.h
//  MMBuildingSell
//
//  Created by Daisy on 14/11/6.
//  Copyright (c) 2014年 Y.X. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utility : NSObject
// 十六进制转换为普通字符串的。
+ (NSString *)stringFromHexString:(NSString *)hexString;
//普通字符串转换为十六进制的。
+ (NSString *)hexStringFromString:(NSString *)string;
@end
