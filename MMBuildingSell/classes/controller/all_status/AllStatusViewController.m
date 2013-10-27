//
//  AllStatusViewController.m
//  QZone-HD
//
//  Created by mj on 13-9-10.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "AllStatusViewController.h"

@interface AllStatusViewController (){
    CGFloat widthView;
    CGFloat heightView;
}
@end

@implementation AllStatusViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    if ([[UIScreen mainScreen] applicationFrame].size.height==1024) {
        widthView = 768 - kDockMenuItemHeight;
        widthView = 768;
        heightView = self.view.frame.size.height;
    }else{
        widthView = 1024 - kDockMenuItemHeight;
        widthView = 1024;
        heightView = self.view.frame.size.height;
    }
    [self.navigationController.navigationBar setHidden:YES];
    [self addBenYueShouRuBtn];
    [self addShouKuanBtn];
    [self addTaoShuBtn];
    [self addQianKuanBtn];
    [self addMianJiBtn];
    [self addGeZhongXinMingXiBtn];
    [self addXiaoKongBiaoBtn];
    [self addZhiBiaoWanChengBtn];
    [self addRenWuBtn];
    [self addPaiMingBtn];

}
//本月目标模块
-(void)addBenYueShouRuBtn
{
    CGRect frame = CGRectMake(0,0, widthView, heightView/4);
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = frame;
    [button setTitle:@"本月目标" forState: UIControlStateNormal];
    button.backgroundColor = [UIColor grayColor];
    button.tag = 2000;
    [button addTarget:self action:@selector(btnBenYueShouRuClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
//本月目标按钮的响应函数
-(void) btnBenYueShouRuClicked:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:@"单击了动态按钮！"
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}

//收款模块
-(void)addShouKuanBtn
{
    CGRect frame = CGRectMake(0, heightView/4*1, widthView*3/8, heightView/4);
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = frame;
    [button setTitle:@"收款" forState: UIControlStateNormal];
    button.backgroundColor = [UIColor yellowColor];
    button.tag = 2000;
    [button addTarget:self action:@selector(btnShouKuanClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
//收款按钮的响应函数
-(void) btnShouKuanClicked:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:@"单击了动态按钮！"
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}

//套数模块
-(void)addTaoShuBtn
{
    CGRect frame = CGRectMake(widthView*3/8, heightView/4*1, widthView*2/8, heightView/4);
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = frame;
    [button setTitle:@"套数" forState: UIControlStateNormal];
    button.backgroundColor = [UIColor greenColor];
    button.tag = 2000;
    [button addTarget:self action:@selector(btnTaoShuClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
//套数按钮的响应函数
-(void) btnTaoShuClicked:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:@"单击了动态按钮！"
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}

//欠款模块
-(void)addQianKuanBtn
{
    CGRect frame = CGRectMake(widthView*5/8, heightView/4*1, widthView*3/8, heightView/4);
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = frame;
    [button setTitle:@"欠款" forState: UIControlStateNormal];
    button.backgroundColor = [UIColor orangeColor];
    button.tag = 2000;
    [button addTarget:self action:@selector(btnQianKuanClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
//欠款按钮的响应函数
-(void) btnQianKuanClicked:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:@"单击了动态按钮！"
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}

//面积模块
-(void)addMianJiBtn
{
    CGRect frame = CGRectMake(0, heightView/4*2, widthView*2/8, heightView/4);
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = frame;
    [button setTitle:@"面积" forState: UIControlStateNormal];
    button.backgroundColor = [UIColor greenColor];
    button.tag = 2000;
    [button addTarget:self action:@selector(btnMianJiClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
//面积按钮的响应函数
-(void) btnMianJiClicked:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:@"单击了动态按钮！"
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}

//各中心明细模块
-(void)addGeZhongXinMingXiBtn
{
    CGRect frame = CGRectMake(widthView*2/8, heightView/4*2, widthView*3/8, heightView/4);
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = frame;
    [button setTitle:@"各中心明细" forState: UIControlStateNormal];
    button.backgroundColor = [UIColor purpleColor];
    button.tag = 2000;
    [button addTarget:self action:@selector(btnGeZhongXinMingXiClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
//各中心明细按钮的响应函数
-(void) btnGeZhongXinMingXiClicked:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:@"单击了动态按钮！"
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}

//销控表模块
-(void)addXiaoKongBiaoBtn
{
    CGRect frame = CGRectMake(widthView*5/8, heightView/4*2, widthView*3/8, heightView/4);
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = frame;
    [button setTitle:@"销控表" forState: UIControlStateNormal];
    button.backgroundColor = [UIColor yellowColor];
    button.tag = 2000;
    [button addTarget:self action:@selector(btnXiaoKongBiaoClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
//销控表按钮的响应函数
-(void) btnXiaoKongBiaoClicked:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:@"单击了动态按钮！"
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}

//指标完成模块
-(void)addZhiBiaoWanChengBtn
{
    CGRect frame = CGRectMake(0, heightView/4*3 ,widthView*3/8, heightView/4);
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = frame;
    [button setTitle:@"指标完成" forState: UIControlStateNormal];
    button.backgroundColor = [UIColor orangeColor];
    button.tag = 2000;
    [button addTarget:self action:@selector(btnZhiBiaoWanChengClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
//指标完成按钮的响应函数
-(void) btnZhiBiaoWanChengClicked:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:@"单击了动态按钮！"
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}

//任务模块
-(void)addRenWuBtn
{
    CGRect frame = CGRectMake(widthView*3/8, heightView/4*3, widthView*3/8, heightView/4);
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = frame;
    [button setTitle:@"任务" forState: UIControlStateNormal];
    button.backgroundColor = [UIColor blueColor];
    button.tag = 2000;
    [button addTarget:self action:@selector(btnRenWuClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
//任务按钮的响应函数
-(void) btnRenWuClicked:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:@"单击了动态按钮！"
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}

//排名模块
-(void)addPaiMingBtn
{
    CGRect frame = CGRectMake(widthView*6/8, heightView/4*3, widthView*2/8, heightView/4);
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = frame;
    [button setTitle:@"排名" forState: UIControlStateNormal];
    button.backgroundColor = [UIColor brownColor];
    button.tag = 2000;
    [button addTarget:self action:@selector(btnPaiMingClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
//排名按钮的响应函数
-(void) btnPaiMingClicked:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:@"单击了动态按钮！"
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}


@end
