//
//  AllStatusViewController.m
//  QZone-HD
//
//  Created by mj on 13-9-10.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "AllStatusViewController.h"
#import "AFNetworking.h"


#define LEFTUPDOWN 18
#define LEFTLEFTRIGHT 17
#define UPDOWN 12
#define LEFTRIGHT 5

@interface AllStatusViewController (){
    CGFloat widthView;
    CGFloat heightView;
}
@end

@implementation AllStatusViewController

-(void)analysisJson:(NSDictionary *)jsonDic
{
    //    NSError *error;
    //    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:date options:NSJSONReadingMutableLeaves error:&error];
    NSString * strSign = [jsonDic objectForKey:@"sign"];
    int intString = [strSign intValue];
    if (intString == 1) {
        //        NSMutableArray *arrInfo = [jsonDic objectForKey:@"arr"];
        //        for (int i = 0; i < arrInfo.count ; i++) {
        //            NSDictionary *dicInfo = [arrInfo objectAtIndex:i];
        //            NSString * strDescription = [dicInfo objectForKey:@"Description"];
        //            NSString * strConnect =[dicInfo objectForKey:@"Connect"];
        //            NSString * strUrlpic = [dicInfo objectForKey:@"urlpic"];
        //            NSString * strType = [dicInfo objectForKey:@"Type"];
        //
        //            NSMutableDictionary *rowData = [[NSMutableDictionary alloc]init];
        //            [rowData setValue:strDescription forKey:@"Description"];
        //            [rowData setValue:strConnect forKey:@"Connect"];
        //            [rowData setValue:strUrlpic forKey:@"urlpic"];
        //            [rowData setValue:strType forKey:@"Type"];
        ////            [arrAd addObject:rowData];
        //        }
    }else{
        NSLog(@"服务端返回错误");
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // 3.2.让整个登录界面停止跟用户交互
        self.view.userInteractionEnabled = NO;
        
        // 3.3.通过定时器跳到主界面
        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(getInfoSuccess) userInfo:nil repeats:NO];
        
        //        [self setADScrollView];
    });
}

- (void)getInfoSuccess
{
    
}

-(void)getHttpInfo
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * strUrl = [[NSString alloc]initWithFormat:@"http://erp.lncct.com/Mobile/Interface.aspx?no=%@&enterpriseCode=%@",[userDefaults objectForKey:@"no"],[userDefaults objectForKey:@"enterpriseCode"]];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:strUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [self analysisJson:(NSDictionary *)responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}
- (void)receivedPushContent:(NSNotification*)notification{
    NSString *content = [notification object];
    [XWAlterview showmessage:@"新消息" subtitle:content cancelbutton:@"确定"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedPushContent:) name:@"PUSHCONTENT" object:nil];
    
//    self.view.backgroundColor = kAllStatusBg;
    
    CGFloat width = 814.0;
    CGFloat height = 748.9;
    
    if ([[UIScreen mainScreen] applicationFrame].size.height==1024) {
//        widthView = 768 - kDockMenuItemHeight;
        widthView = width;
        heightView = height;
    }else{
//        widthView = width - kDockMenuItemHeight;
        widthView = width;
        heightView = height;
    }
    [self.navigationController.navigationBar setHidden:YES];
    
    UIImage * imageFrameBk = [UIImage imageNamed:@"all_status_bg.png"];
    UIImageView * imageFrameView = [[UIImageView alloc] initWithImage:imageFrameBk];
    imageFrameView.frame =CGRectMake(0, 0, widthView, heightView);
    [self.view addSubview:imageFrameView];

    
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
    CGRect frame = CGRectMake(LEFTLEFTRIGHT,LEFTUPDOWN, 219, 229);
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = frame;
    [button.titleLabel setFont:[UIFont systemFontOfSize: 14.0]];
    [button setTitle:@"本月目标" forState: UIControlStateNormal];
//    button.backgroundColor = [UIColor grayColor];
    [button setBackgroundImage:[UIImage imageNamed:@"all_status_benyuemubiao"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"all_status_benyuemubiao"] forState:UIControlStateSelected];
    button.tag = 2001;
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
//欠款模块
-(void)addQianKuanBtn
{
    CGRect frame = CGRectMake(LEFTLEFTRIGHT,LEFTUPDOWN + 229 + UPDOWN, 219, 229);
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = frame;
    [button.titleLabel setFont:[UIFont systemFontOfSize: 17.0]];
    [button setTitle:@"欠款" forState: UIControlStateNormal];
    //    button.backgroundColor = [UIColor orangeColor];
    [button setBackgroundImage:[UIImage imageNamed:@"all_status_qiankuan"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"all_status_qiankuan"] forState:UIControlStateSelected];
    button.tag = 2004;
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
//指标完成模块
-(void)addZhiBiaoWanChengBtn
{
    CGRect frame = CGRectMake(LEFTLEFTRIGHT,LEFTUPDOWN + UPDOWN * 2 + 229 * 2,219, 229);
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = frame;
    [button setTitle:@"指标完成" forState: UIControlStateNormal];
    //    button.backgroundColor = [UIColor orangeColor];
    [button setBackgroundImage:[UIImage imageNamed:@"all_status_zhibiaowancheng"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"all_status_zhibiaowancheng"] forState:UIControlStateSelected];
    button.tag = 2007;
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


//收款模块
-(void)addShouKuanBtn
{
    CGRect frame = CGRectMake(LEFTLEFTRIGHT + 219 + LEFTRIGHT, LEFTUPDOWN, 330, 229);
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = frame;
    [button.titleLabel setFont:[UIFont systemFontOfSize: 15.0]];
    [button setTitle:@"收款" forState: UIControlStateNormal];
//    button.backgroundColor = [UIColor yellowColor];
    [button setBackgroundImage:[UIImage imageNamed:@"all_status_shoukuan"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"all_status_shoukuan"] forState:UIControlStateSelected];
    button.tag = 2002;
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

//面积模块
-(void)addMianJiBtn
{
    CGRect frame = CGRectMake(LEFTLEFTRIGHT + 219 + LEFTRIGHT, LEFTUPDOWN + 229 + UPDOWN, 219, 229);
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = frame;
    [button.titleLabel setFont:[UIFont systemFontOfSize: 18.0]];
    [button setTitle:@"面积" forState: UIControlStateNormal];
    //    button.backgroundColor = [UIColor greenColor];
    [button setBackgroundImage:[UIImage imageNamed:@"all_status_ares"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"all_status_ares"] forState:UIControlStateSelected];
    button.tag = 2005;
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

//任务模块
-(void)addRenWuBtn
{
    CGRect frame = CGRectMake(LEFTLEFTRIGHT + 219 + LEFTRIGHT, LEFTUPDOWN + 229 * 2 + UPDOWN * 2, 219, 229);
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = frame;
    [button setTitle:@"任务" forState: UIControlStateNormal];
    //    button.backgroundColor = [UIColor blueColor];
    [button setBackgroundImage:[UIImage imageNamed:@"all_status_task"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"all_status_task"] forState:UIControlStateSelected];
    button.tag = 2008;
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

//各中心明细模块
-(void)addGeZhongXinMingXiBtn
{
    CGRect frame = CGRectMake(LEFTLEFTRIGHT + 219 * 2+ LEFTRIGHT * 2, LEFTUPDOWN + 229 + UPDOWN, 106, 229);
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = frame;
    [button setTitle:@"各中心明细" forState: UIControlStateNormal];
    //    button.backgroundColor = [UIColor purpleColor];
    [button setBackgroundImage:[UIImage imageNamed:@"all_status_mingxi"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"all_status_mingxi"] forState:UIControlStateSelected];
    button.tag = 2006;
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

//排名模块
-(void)addPaiMingBtn
{
    CGRect frame = CGRectMake(LEFTLEFTRIGHT + 219 * 2+ LEFTRIGHT * 2, LEFTUPDOWN + 229 * 2 + UPDOWN * 2, 106, 229);
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = frame;
    [button setTitle:@"排名" forState: UIControlStateNormal];
    //    button.backgroundColor = [UIColor brownColor];
    [button setBackgroundImage:[UIImage imageNamed:@"all_status_paiming"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"all_status_paiming"] forState:UIControlStateSelected];
    button.tag = 2009;
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


//套数模块
-(void)addTaoShuBtn
{
    CGRect frame = CGRectMake(LEFTLEFTRIGHT + 219 + LEFTRIGHT * 2 + 330, LEFTUPDOWN, 219, 229);
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = frame;
    [button.titleLabel setFont:[UIFont systemFontOfSize: 16.0]];
    [button setTitle:@"套数" forState: UIControlStateNormal];
//    button.backgroundColor = [UIColor greenColor];
    [button setBackgroundImage:[UIImage imageNamed:@"all_status_taoshu"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"all_status_taoshu"] forState:UIControlStateSelected];
    button.tag = 2003;
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



//销控表模块
-(void)addXiaoKongBiaoBtn
{
    CGRect frame = CGRectMake(LEFTLEFTRIGHT + 219 + LEFTRIGHT * 2 + 330, LEFTUPDOWN + 229 + UPDOWN, 219, 471);
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = frame;
    [button setTitle:@"销控表" forState: UIControlStateNormal];
//    button.backgroundColor = [UIColor yellowColor];
    [button setBackgroundImage:[UIImage imageNamed:@"all_status_xiaokongbiao"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"all_status_xiaokongbiao"] forState:UIControlStateSelected];
    button.tag = 2010;
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







@end
