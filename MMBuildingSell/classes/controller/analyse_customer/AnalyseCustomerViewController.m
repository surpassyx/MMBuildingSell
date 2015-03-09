//
//  AnalyseCustomerViewController.m
//  MMBuildingSell
//
//  Created by 3G组 on 13-10-14.
//  Copyright (c) 2013年 Y.X. All rights reserved.
//

#import "AnalyseCustomerViewController.h"
//#import "SegmentView.h"
#import <QuartzCore/QuartzCore.h>
#import "AFNetworking.h"

@interface AnalyseCustomerViewController () <HTHorizontalSelectionListDelegate, HTHorizontalSelectionListDataSource>

@end

@implementation AnalyseCustomerViewController
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
    NSString * strUrl = @"action=3&rootNo=313853341447";
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
    
    
    //上框
    imageUp = [UIImage imageNamed:@"analyse_up_bk"];
    imageUpView = [[UIImageView alloc] initWithImage:imageUp];
    imageUpView.frame =CGRectMake(1, 0, width, 271);
    [self.view addSubview:imageUpView];
    
    //下框
    imageDown = [UIImage imageNamed:@"analyse_down_bk"];
    imageDownView = [[UIImageView alloc] initWithImage:imageDown];
    imageDownView.frame =CGRectMake(1,271, width, 422);
    [self.view addSubview:imageDownView];
    
    
    //加载梯形
    myWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0,0,width,height)];
    myWebView.delegate = self;
    [self.view addSubview:myWebView];
    
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
