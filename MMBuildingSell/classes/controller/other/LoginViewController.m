//
//  LoginViewController.m
//  QQ空间-HD
//
//  Created by apple on 13-9-11.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "LoginViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置背景颜色
    self.view.backgroundColor = kGlobalBg;
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    _qq.text = [userDefaults objectForKey:@"account"];
    _pwd.text = [userDefaults objectForKey:@"password"];
    NSString * strIsSelected =[userDefaults objectForKey:@"isselected"];
    if ([@"1" isEqualToString:strIsSelected]) {
        [_rmbPwd setSelected:YES];
    }else{
        [_rmbPwd setSelected:NO];
    }
}

#pragma mark 弹出错误提示
- (void)alertError:(NSString *)error
{
    // 1.弹框
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登录失败" message:error delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
    
    // 2.发抖
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    anim.repeatCount = 1;
    anim.values = @[@-10, @10, @-10];
    [_loginView.layer addAnimation:anim forKey:nil];
}

#pragma mark 登录
- (IBAction)login {
    // 1.QQ
    if (_qq.text.length == 0) {
        [self alertError:@"请输入帐号"];
        return;
    }
    
    // 2.密码
    if (_pwd.text.length == 0) {
        [self alertError:@"请输入密码"];
        return;
    }
    
    // 3.登录成功
    // 3.1.开始动画
    [_indicator startAnimating];
    
    // 3.2.让整个登录界面停止跟用户交互
    self.view.userInteractionEnabled = NO;
    
    // 3.3.通过定时器跳到主界面
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(loginSuccess) userInfo:nil repeats:NO];
}

#pragma mark 登录成功
- (void)loginSuccess
{
    // 1.停止动画
    [_indicator stopAnimating];
    
    // 2.保存账号密码
     NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([_rmbPwd isSelected]) {
        [userDefaults setValue:@"1" forKey:@"isselected"];
        [userDefaults setValue:_qq.text forKey:@"account"];
        [userDefaults setValue:_pwd.text forKey:@"password"];
    }else{
        [userDefaults setValue:@"0" forKey:@"isselected"];
        [userDefaults setValue:@"" forKey:@"account"];
        [userDefaults setValue:@"" forKey:@"password"];
    }
    [userDefaults synchronize];

    
    // 3.让登录界面可以跟用户交互
    self.view.userInteractionEnabled = YES;
    
    // 4.跳到主界面
    [self performSegueWithIdentifier:@"home" sender:nil];
}

#pragma mark 记住密码
- (IBAction)rmbPwd:(UIButton *)sender {
    // 1.取反
    sender.selected = !sender.isSelected;
    
    // 2.取消选中自动登录
    if (!sender.isSelected) {
        _autoLogin.selected = NO;
    }
}
#pragma mark 自动登录
- (IBAction)autoLogin:(UIButton *)sender {
    // 1.取反
    sender.selected = !sender.isSelected;
    
    // 2.选中记住密码
    if (sender.isSelected) {
        _rmbPwd.selected = YES;
    }
}
@end