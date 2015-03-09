//
//  AllStatusViewController.m
//  QZone-HD
//
//  Created by mj on 13-9-10.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "AllStatusViewController.h"
#import "AFNetworking.h"
//#import "SegmentView.h"

//#define LEFTUPDOWN 18
//#define LEFTLEFTRIGHT 17
//#define UPDOWN 12
//#define LEFTRIGHT 5

@interface AllStatusViewController () <HTHorizontalSelectionListDelegate, HTHorizontalSelectionListDataSource>{
//    CGFloat widthView;
//    CGFloat heightView;
}
@end

@implementation AllStatusViewController

@synthesize dataList;

-(void)analysisJson:(NSDictionary *)jsonDic
{
    //{"sign":"1","arr":[{"menuName":"来电来访[周]","menuUrl":"/roomtest/action3/stat_customstat_index.action","sortNo":"9"},{"menuName":"来电来访[媒体]","menuUrl":"/roomtest/action3/stat_customstat_indexGetway.action","sortNo":"8"},{"menuName":"月度销售额","menuUrl":"/roomtest/action3/stat_contractstat_salesmanStat.action","sortNo":"10"},{"menuName":"月度目标设置","menuUrl":"/roomtest/action3/service_target_index.action","sortNo":"11"},{"menuName":"来电","menuUrl":"/roomtest/action3/stat_customstat_indexCustomCallVisit.action?customstat.callVisitkey=1","sortNo":"1"},{"menuName":"电转访","menuUrl":"/roomtest/action3/stat_customstat_indexCustomCallVisit.action?customstat.callVisitkey=3","sortNo":"2"},{"menuName":"来访","menuUrl":"/roomtest/action3/stat_customstat_indexCustomCallVisit.action?customstat.callVisitkey=2","sortNo":"3"},{"menuName":"回访","menuUrl":"/roomtest/action3/stat_customstat_indexCustomCallVisit.action?customstat.callVisitkey=4","sortNo":"4"},{"menuName":"月度表","menuUrl":"/roomtest/action3/stat_customstat_indexCustomstatFollow.action","sortNo":"5"}]}
    NSString * strSign = [jsonDic objectForKey:@"sign"];
    int intString = [strSign intValue];
    if (intString == 1) {
        [self.dataList removeAllObjects];
        NSMutableArray *arrInfo = [jsonDic objectForKey:@"arr"];
        for (int i = 0; i < arrInfo.count ; i++) {
            NSDictionary *dicInfo = [arrInfo objectAtIndex:i];
            NSString * strMenuUrl = [dicInfo objectForKey:@"menuUrl"];
            NSString * strMenuName =[dicInfo objectForKey:@"menuName"];
            NSString * strSortNo =[dicInfo objectForKey:@"sortNo"];
            
            
            NSMutableDictionary *rowData = [[NSMutableDictionary alloc]init];
            [rowData setValue:strMenuUrl forKey:@"menuUrl"];
            [rowData setValue:strMenuName forKey:@"menuName"];
            [rowData setValue:strSortNo forKey:@"sortNo"];
            [self.dataList addObject:rowData];
        }
        
        [self.dataList sortUsingComparator:^NSComparisonResult(__strong id obj1,__strong id obj2){
            NSMutableDictionary *rowData1 = (NSMutableDictionary *)obj1;
            NSMutableDictionary *rowData2 = (NSMutableDictionary *)obj2;
            return [[rowData1 objectForKey:@"sortNo"] intValue] > [[rowData2 objectForKey:@"sortNo"] intValue];
        }];
//        NSLog(@"%@", [self.dataList debugDescription]);
    }else{
        NSLog(@"服务端返回错误");
    }
    
}


-(void)getHttpInfo
{
    NSString * strUrl = @"action=3&rootNo=313852949353";
    NSString * hexUrl  = [Utility hexStringFromString:strUrl];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:API_BASE_URL(hexUrl) parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        //        NSLog(@"%@",[responseObject objectForKey:@"error"]);
        [self analysisJson:(NSDictionary *)responseObject];
        [self initMenuView];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}

- (void)receivedPushContent:(NSNotification*)notification{
    NSString *content = [notification object];
    [XWAlterview showmessage:@"新消息" subtitle:content cancelbutton:@"确定"];
}

-(void)initMenuView
{
    NSMutableArray * nameArr = [[NSMutableArray alloc]init];
    for (NSMutableDictionary *rowData in self.dataList) {
        NSString * strName = [rowData objectForKey:@"menuName"];
        [nameArr addObject:strName];
    }
    
    self.selectionList = [[HTHorizontalSelectionList alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    self.selectionList.delegate = self;
    self.selectionList.dataSource = self;
    self.navigationItem.titleView = self.selectionList;
    
//    SegmentView *segmentView = [[SegmentView alloc] init];
//    segmentView.titles = nameArr;
//    segmentView.delegate = self;
//    self.navigationItem.titleView = segmentView;
    
    if ([self.dataList count] > 0) {
        NSMutableDictionary *rowData = [self.dataList objectAtIndex:0];
        NSString * strUrl = [rowData objectForKey:@"menuUrl"];
        
        NSURL *url =[NSURL URLWithString:MENU_BASE_URL(strUrl)];
        NSURLRequest *request =[NSURLRequest requestWithURL:url];
        [myWebView loadRequest:request];
    }
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getHttpInfo];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedPushContent:) name:@"PUSHCONTENT" object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"PUSHCONTENT" object:nil];
}

//- (void)segmentView:(SegmentView *)segmentView didSelectedSegmentAtIndex:(int)index
//{
//    
//    NSMutableDictionary *rowData = [self.dataList objectAtIndex:index];
//    NSString * strUrl = [rowData objectForKey:@"menuUrl"];
//    
//    NSURL *url =[NSURL URLWithString:HTTP_BASE_URL(strUrl)];
//    NSURLRequest *request =[NSURLRequest requestWithURL:url];
//    [myWebView loadRequest:request];
//    
//}

#pragma mark - HTHorizontalSelectionListDataSource Protocol Methods

- (NSInteger)numberOfItemsInSelectionList:(HTHorizontalSelectionList *)selectionList {
    return self.dataList.count;
}

- (NSString *)selectionList:(HTHorizontalSelectionList *)selectionList titleForItemWithIndex:(NSInteger)index {
//    return self.dataList[index];
    NSMutableDictionary *rowData = [self.dataList objectAtIndex:index];
    NSString * strMenuName = [rowData objectForKey:@"menuName"];
    return strMenuName;
}

#pragma mark - HTHorizontalSelectionListDelegate Protocol Methods

- (void)selectionList:(HTHorizontalSelectionList *)selectionList didSelectButtonWithIndex:(NSInteger)index {
    // update the view for the corresponding index
//    self.selectedItemLabel.text = self.carMakes[index];
    
    NSMutableDictionary *rowData = [self.dataList objectAtIndex:index];
    NSString * strUrl = [rowData objectForKey:@"menuUrl"];
    
    NSURL *url =[NSURL URLWithString:MENU_BASE_URL(strUrl)];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [myWebView loadRequest:request];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataList = [[NSMutableArray alloc]init];
    
    
    
    CGFloat width = 814.0;
    CGFloat height = 748.9;
    
    //加载梯形
    myWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0,0,width,height)];
    myWebView.delegate = self;
    [self.view addSubview:myWebView];

    
    [self getHttpInfo];
    
    
//    self.view.backgroundColor = kAllStatusBg;
    
//    CGFloat width = 814.0;
//    CGFloat height = 748.9;
//    
//    if ([[UIScreen mainScreen] applicationFrame].size.height==1024) {
////        widthView = 768 - kDockMenuItemHeight;
//        widthView = width;
//        heightView = height;
//    }else{
////        widthView = width - kDockMenuItemHeight;
//        widthView = width;
//        heightView = height;
//    }
//    [self.navigationController.navigationBar setHidden:YES];
//    
//    UIImage * imageFrameBk = [UIImage imageNamed:@"all_status_bg.png"];
//    UIImageView * imageFrameView = [[UIImageView alloc] initWithImage:imageFrameBk];
//    imageFrameView.frame =CGRectMake(0, 0, widthView, heightView);
//    [self.view addSubview:imageFrameView];
//
//    
//    [self addBenYueShouRuBtn];
//    [self addShouKuanBtn];
//    [self addTaoShuBtn];
//    [self addQianKuanBtn];
//    [self addMianJiBtn];
//    [self addGeZhongXinMingXiBtn];
//    [self addXiaoKongBiaoBtn];
//    [self addZhiBiaoWanChengBtn];
//    [self addRenWuBtn];
//    [self addPaiMingBtn];

}
////本月目标模块
//-(void)addBenYueShouRuBtn
//{
//    CGRect frame = CGRectMake(LEFTLEFTRIGHT,LEFTUPDOWN, 219, 229);
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
//    button.frame = frame;
//    [button.titleLabel setFont:[UIFont systemFontOfSize: 14.0]];
//    [button setTitle:@"本月目标" forState: UIControlStateNormal];
////    button.backgroundColor = [UIColor grayColor];
//    [button setBackgroundImage:[UIImage imageNamed:@"all_status_benyuemubiao"] forState:UIControlStateNormal];
//    [button setBackgroundImage:[UIImage imageNamed:@"all_status_benyuemubiao"] forState:UIControlStateSelected];
//    button.tag = 2001;
//    [button addTarget:self action:@selector(btnBenYueShouRuClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
//}
////本月目标按钮的响应函数
//-(void) btnBenYueShouRuClicked:(id)sender {
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
//                                                    message:@"单击了动态按钮！"
//                                                   delegate:self
//                                          cancelButtonTitle:@"确定"
//                                          otherButtonTitles:nil];
//    [alert show];
//}
////欠款模块
//-(void)addQianKuanBtn
//{
//    CGRect frame = CGRectMake(LEFTLEFTRIGHT,LEFTUPDOWN + 229 + UPDOWN, 219, 229);
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
//    button.frame = frame;
//    [button.titleLabel setFont:[UIFont systemFontOfSize: 17.0]];
//    [button setTitle:@"欠款" forState: UIControlStateNormal];
//    //    button.backgroundColor = [UIColor orangeColor];
//    [button setBackgroundImage:[UIImage imageNamed:@"all_status_qiankuan"] forState:UIControlStateNormal];
//    [button setBackgroundImage:[UIImage imageNamed:@"all_status_qiankuan"] forState:UIControlStateSelected];
//    button.tag = 2004;
//    [button addTarget:self action:@selector(btnQianKuanClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
//}
////欠款按钮的响应函数
//-(void) btnQianKuanClicked:(id)sender {
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
//                                                    message:@"单击了动态按钮！"
//                                                   delegate:self
//                                          cancelButtonTitle:@"确定"
//                                          otherButtonTitles:nil];
//    [alert show];
//}
////指标完成模块
//-(void)addZhiBiaoWanChengBtn
//{
//    CGRect frame = CGRectMake(LEFTLEFTRIGHT,LEFTUPDOWN + UPDOWN * 2 + 229 * 2,219, 229);
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
//    button.frame = frame;
//    [button setTitle:@"指标完成" forState: UIControlStateNormal];
//    //    button.backgroundColor = [UIColor orangeColor];
//    [button setBackgroundImage:[UIImage imageNamed:@"all_status_zhibiaowancheng"] forState:UIControlStateNormal];
//    [button setBackgroundImage:[UIImage imageNamed:@"all_status_zhibiaowancheng"] forState:UIControlStateSelected];
//    button.tag = 2007;
//    [button addTarget:self action:@selector(btnZhiBiaoWanChengClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
//}
////指标完成按钮的响应函数
//-(void) btnZhiBiaoWanChengClicked:(id)sender {
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
//                                                    message:@"单击了动态按钮！"
//                                                   delegate:self
//                                          cancelButtonTitle:@"确定"
//                                          otherButtonTitles:nil];
//    [alert show];
//}
//
//
////收款模块
//-(void)addShouKuanBtn
//{
//    CGRect frame = CGRectMake(LEFTLEFTRIGHT + 219 + LEFTRIGHT, LEFTUPDOWN, 330, 229);
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
//    button.frame = frame;
//    [button.titleLabel setFont:[UIFont systemFontOfSize: 15.0]];
//    [button setTitle:@"收款" forState: UIControlStateNormal];
////    button.backgroundColor = [UIColor yellowColor];
//    [button setBackgroundImage:[UIImage imageNamed:@"all_status_shoukuan"] forState:UIControlStateNormal];
//    [button setBackgroundImage:[UIImage imageNamed:@"all_status_shoukuan"] forState:UIControlStateSelected];
//    button.tag = 2002;
//    [button addTarget:self action:@selector(btnShouKuanClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
//}
////收款按钮的响应函数
//-(void) btnShouKuanClicked:(id)sender {
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
//                                                    message:@"单击了动态按钮！"
//                                                   delegate:self
//                                          cancelButtonTitle:@"确定"
//                                          otherButtonTitles:nil];
//    [alert show];
//}
//
////面积模块
//-(void)addMianJiBtn
//{
//    CGRect frame = CGRectMake(LEFTLEFTRIGHT + 219 + LEFTRIGHT, LEFTUPDOWN + 229 + UPDOWN, 219, 229);
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
//    button.frame = frame;
//    [button.titleLabel setFont:[UIFont systemFontOfSize: 18.0]];
//    [button setTitle:@"面积" forState: UIControlStateNormal];
//    //    button.backgroundColor = [UIColor greenColor];
//    [button setBackgroundImage:[UIImage imageNamed:@"all_status_ares"] forState:UIControlStateNormal];
//    [button setBackgroundImage:[UIImage imageNamed:@"all_status_ares"] forState:UIControlStateSelected];
//    button.tag = 2005;
//    [button addTarget:self action:@selector(btnMianJiClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
//}
////面积按钮的响应函数
//-(void) btnMianJiClicked:(id)sender {
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
//                                                    message:@"单击了动态按钮！"
//                                                   delegate:self
//                                          cancelButtonTitle:@"确定"
//                                          otherButtonTitles:nil];
//    [alert show];
//}
//
////任务模块
//-(void)addRenWuBtn
//{
//    CGRect frame = CGRectMake(LEFTLEFTRIGHT + 219 + LEFTRIGHT, LEFTUPDOWN + 229 * 2 + UPDOWN * 2, 219, 229);
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
//    button.frame = frame;
//    [button setTitle:@"任务" forState: UIControlStateNormal];
//    //    button.backgroundColor = [UIColor blueColor];
//    [button setBackgroundImage:[UIImage imageNamed:@"all_status_task"] forState:UIControlStateNormal];
//    [button setBackgroundImage:[UIImage imageNamed:@"all_status_task"] forState:UIControlStateSelected];
//    button.tag = 2008;
//    [button addTarget:self action:@selector(btnRenWuClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
//}
////任务按钮的响应函数
//-(void) btnRenWuClicked:(id)sender {
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
//                                                    message:@"单击了动态按钮！"
//                                                   delegate:self
//                                          cancelButtonTitle:@"确定"
//                                          otherButtonTitles:nil];
//    [alert show];
//}
//
////各中心明细模块
//-(void)addGeZhongXinMingXiBtn
//{
//    CGRect frame = CGRectMake(LEFTLEFTRIGHT + 219 * 2+ LEFTRIGHT * 2, LEFTUPDOWN + 229 + UPDOWN, 106, 229);
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
//    button.frame = frame;
//    [button setTitle:@"各中心明细" forState: UIControlStateNormal];
//    //    button.backgroundColor = [UIColor purpleColor];
//    [button setBackgroundImage:[UIImage imageNamed:@"all_status_mingxi"] forState:UIControlStateNormal];
//    [button setBackgroundImage:[UIImage imageNamed:@"all_status_mingxi"] forState:UIControlStateSelected];
//    button.tag = 2006;
//    [button addTarget:self action:@selector(btnGeZhongXinMingXiClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
//}
////各中心明细按钮的响应函数
//-(void) btnGeZhongXinMingXiClicked:(id)sender {
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
//                                                    message:@"单击了动态按钮！"
//                                                   delegate:self
//                                          cancelButtonTitle:@"确定"
//                                          otherButtonTitles:nil];
//    [alert show];
//}
//
////排名模块
//-(void)addPaiMingBtn
//{
//    CGRect frame = CGRectMake(LEFTLEFTRIGHT + 219 * 2+ LEFTRIGHT * 2, LEFTUPDOWN + 229 * 2 + UPDOWN * 2, 106, 229);
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
//    button.frame = frame;
//    [button setTitle:@"排名" forState: UIControlStateNormal];
//    //    button.backgroundColor = [UIColor brownColor];
//    [button setBackgroundImage:[UIImage imageNamed:@"all_status_paiming"] forState:UIControlStateNormal];
//    [button setBackgroundImage:[UIImage imageNamed:@"all_status_paiming"] forState:UIControlStateSelected];
//    button.tag = 2009;
//    [button addTarget:self action:@selector(btnPaiMingClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
//}
////排名按钮的响应函数
//-(void) btnPaiMingClicked:(id)sender {
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
//                                                    message:@"单击了动态按钮！"
//                                                   delegate:self
//                                          cancelButtonTitle:@"确定"
//                                          otherButtonTitles:nil];
//    [alert show];
//}
//
//
////套数模块
//-(void)addTaoShuBtn
//{
//    CGRect frame = CGRectMake(LEFTLEFTRIGHT + 219 + LEFTRIGHT * 2 + 330, LEFTUPDOWN, 219, 229);
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
//    button.frame = frame;
//    [button.titleLabel setFont:[UIFont systemFontOfSize: 16.0]];
//    [button setTitle:@"套数" forState: UIControlStateNormal];
////    button.backgroundColor = [UIColor greenColor];
//    [button setBackgroundImage:[UIImage imageNamed:@"all_status_taoshu"] forState:UIControlStateNormal];
//    [button setBackgroundImage:[UIImage imageNamed:@"all_status_taoshu"] forState:UIControlStateSelected];
//    button.tag = 2003;
//    [button addTarget:self action:@selector(btnTaoShuClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
//}
////套数按钮的响应函数
//-(void) btnTaoShuClicked:(id)sender {
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
//                                                    message:@"单击了动态按钮！"
//                                                   delegate:self
//                                          cancelButtonTitle:@"确定"
//                                          otherButtonTitles:nil];
//    [alert show];
//}
//
//
//
////销控表模块
//-(void)addXiaoKongBiaoBtn
//{
//    CGRect frame = CGRectMake(LEFTLEFTRIGHT + 219 + LEFTRIGHT * 2 + 330, LEFTUPDOWN + 229 + UPDOWN, 219, 471);
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
//    button.frame = frame;
//    [button setTitle:@"销控表" forState: UIControlStateNormal];
////    button.backgroundColor = [UIColor yellowColor];
//    [button setBackgroundImage:[UIImage imageNamed:@"all_status_xiaokongbiao"] forState:UIControlStateNormal];
//    [button setBackgroundImage:[UIImage imageNamed:@"all_status_xiaokongbiao"] forState:UIControlStateSelected];
//    button.tag = 2010;
//    [button addTarget:self action:@selector(btnXiaoKongBiaoClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
//}
////销控表按钮的响应函数
//-(void) btnXiaoKongBiaoClicked:(id)sender {
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
//                                                    message:@"单击了动态按钮！"
//                                                   delegate:self
//                                          cancelButtonTitle:@"确定"
//                                          otherButtonTitles:nil];
//    [alert show];
//}







@end
