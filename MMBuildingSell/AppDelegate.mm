//
//  AppDelegate.m
//  MMBuildingSell
//
//  Created by 3G组 on 13-10-12.
//  Copyright (c) 2013年 Y.X. All rights reserved.
//

#import "AppDelegate.h"

#import "JSONKit.h"

@implementation AppDelegate
@synthesize nPhase;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    application.statusBarHidden = NO;
    
    // 2.设置主题
    [self setNavTheme];
    

    
    [application setApplicationIconBadgeNumber:0];
    
    //消息推送注册
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings
                                                                             settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge)
                                                                             categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        //这里还是原来的代码
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeSound|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeBadge];
    }
    return YES;
}


-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSString *error_str = [NSString stringWithFormat: @"%@", error];
    NSLog(@"Failed to get token, error:%@", error_str);
    
    [[NSUserDefaults standardUserDefaults] setObject:error_str forKey:@"ErrordeviceToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    
    NSString *token = [NSString stringWithFormat:@"%@", deviceToken];
    //获取终端设备标识，这个标识需要通过接口发送到服务器端，服务器端推送消息到APNS时需要知道终端的标识，APNS通过注册的终端标识找到终端设备。
    
    NSString *b = [token substringFromIndex:1];
    NSString *a = [b substringToIndex:(b.length - 1)];
    NSString *cleanString = [a stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString* devices_token = [NSString stringWithFormat:@"%@",cleanString];
    
     NSLog(@"My token is:%@", devices_token);
    
    [[NSUserDefaults standardUserDefaults] setObject:devices_token forKey:@"deviceToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"Receive Notify: %@", [userInfo JSONString]);
    NSString *alert = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    if (application.applicationState == UIApplicationStateActive) {
        // Nothing to do if applicationState is Inactive, the iOS already displayed an alert view.
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PUSHCONTENT" object:alert];
    }
    [application setApplicationIconBadgeNumber:0];
    
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


//- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
//    NSString *error_str = [NSString stringWithFormat: @"%@", error];
//    NSLog(@"Failed to get token, error:%@", error_str);
//    
//    NSString *devices_token = @"";
//    
//    [[NSUserDefaults standardUserDefaults] setObject:devices_token forKey:@"deviceToken"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}


@end
