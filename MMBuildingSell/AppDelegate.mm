//
//  AppDelegate.m
//  MMBuildingSell
//
//  Created by 3G组 on 13-10-12.
//  Copyright (c) 2013年 Y.X. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate
@synthesize nPhase;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    application.statusBarHidden = NO;
    
    // 2.设置主题
    [self setNavTheme];
    
//    _mapManager = [[BMKMapManager alloc]init];
//    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
//    BOOL ret = [_mapManager start: @"2ec2d37497e11bca1573c82d7650fb48" generalDelegate:nil];
//    if (!ret) {
//        NSLog(@"manager start failed!");
//    }
    
    return YES;
}

#pragma mark 初始化导航栏主题
- (void)setNavTheme
{
    // 1.设置导航栏背景
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundColor:kSegmentBg];
    [bar setBackgroundImage:[UIImage resizeImage:@"nav_bg"] forBarMetrics:UIBarMetricsDefault];
    // 状态栏
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
    
    // 2.设置导航栏文字属性
    NSMutableDictionary *barAttrs = [NSMutableDictionary dictionary];
    [barAttrs setObject:[UIColor darkGrayColor] forKey:UITextAttributeTextColor];
    [barAttrs setObject:[NSValue valueWithUIOffset:UIOffsetMake(0, 0)] forKey:UITextAttributeTextShadowOffset];
    [bar setTitleTextAttributes:barAttrs];
    
    // 3.按钮
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    [item setBackgroundImage:[UIImage resizeImage:@"BarButtonItem_Normal.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [item setBackgroundImage:[UIImage resizeImage:@"BarButtonItem_Pressed.png"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    
    NSMutableDictionary *itemAttrs = [NSMutableDictionary dictionaryWithDictionary:barAttrs];
    [itemAttrs setObject:[UIFont boldSystemFontOfSize:13] forKey:UITextAttributeFont];
    [item setTitleTextAttributes:itemAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:itemAttrs forState:UIControlStateHighlighted];
    [item setTitleTextAttributes:itemAttrs forState:UIControlStateDisabled];
    
    // 4.返回按钮
    [item setBackButtonBackgroundImage:[UIImage resizeImage:@"BarButtonItem_Back_Normal.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [item setBackButtonBackgroundImage:[UIImage resizeImage:@"BarButtonItem_Back_Pressed.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(NSMutableArray *)searchFileInDocumentDirctory:(NSString *)path
{
    NSMutableArray *picPathArray = [[NSMutableArray alloc]init];
    NSFileManager *fm = [NSFileManager defaultManager];
    //如果没有目录则创建信息储存目录
    [fm createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    
    //递归枚举目录
    NSDirectoryEnumerator *dirEnumerater = [fm enumeratorAtPath:path];
    NSString * filePath = nil;
    while (nil != (filePath = [dirEnumerater nextObject])) {
//        NSLog(@"%@",filePath);
        NSString *msgdir = [NSString stringWithFormat:@"%@/%@",path,filePath];
        BOOL isDir;
        if ([fm fileExistsAtPath:msgdir isDirectory:&isDir]) {
            if (!isDir) {
                if ([[filePath lastPathComponent] isEqualToString:@".png"]||[[filePath lastPathComponent] isEqualToString:@".jpg"]||[[filePath lastPathComponent] isEqualToString:@".jpeg"]) {
                    [picPathArray addObject:msgdir];
                }
            }
        }
    }
    return picPathArray;
}

@end
