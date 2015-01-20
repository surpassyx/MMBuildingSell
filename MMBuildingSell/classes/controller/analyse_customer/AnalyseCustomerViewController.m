//
//  AnalyseCustomerViewController.m
//  MMBuildingSell
//
//  Created by 3G组 on 13-10-14.
//  Copyright (c) 2013年 Y.X. All rights reserved.
//

#import "AnalyseCustomerViewController.h"
#import "SegmentView.h"
#import <QuartzCore/QuartzCore.h>
#import "AFNetworking.h"

@interface AnalyseCustomerViewController () <SegmentViewDelegate>

@end

@implementation AnalyseCustomerViewController

@synthesize slices = _slices;
@synthesize sliceColors = _sliceColors;


-(void)analysisJson:(NSDictionary *)jsonDic
               type:(int)nType
{
    if (nType == 0) {
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

    } else {
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
    NSString * strUrl = [[NSString alloc]initWithFormat:@"action=9&usercode=%@&enterpriseCode=%@&installment=%@",[userDefaults objectForKey:@"usercode"],[userDefaults objectForKey:@"enterpriseCode"],[userDefaults objectForKey:@"installment"]];
    
    NSString * hexUrl  = [Utility hexStringFromString:strUrl];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:API_BASE_URL(hexUrl) parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
//        NSLog(@"%@",[responseObject objectForKey:@"error"]);
        [self analysisJson:(NSDictionary *)responseObject type:0];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}

-(void)getHttpDetailInfo:(NSString *)strtype
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * strUrl = [[NSString alloc]initWithFormat:@"http://erp.lncct.com/Mobile/Interface.aspx?no=%@&enterpriseCode=%@&type=%@",[userDefaults objectForKey:@"no"],[userDefaults objectForKey:@"enterpriseCode"],strtype];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:strUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [self analysisJson:(NSDictionary *)responseObject type:1];
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
    
    SegmentView *segmentView = [[SegmentView alloc] init];
    segmentView.titles = @[@"来源分析", @"销售阶段分析"];
    segmentView.delegate = self;
    self.navigationItem.titleView = segmentView;
    
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


    //增加饼图
    pieChartRight = [[XYPieChart alloc]initWithFrame:CGRectMake(100 , 44, 200 , 200)];
    //    [pieChartRight setDataSource:self];
    //    [pieChartRight setStartPieAngle:M_PI_2];
    //    [pieChartRight setAnimationSpeed:1.0];
    //    [pieChartRight setLabelFont:[UIFont fontWithName:@"DBLCDTempBlack" size:24]];
    //    [pieChartRight setLabelRadius:160];
    //    [pieChartRight setShowPercentage:YES];
    //    [pieChartRight setPieBackgroundColor:[UIColor colorWithWhite:0.95 alpha:1]];
    //    [pieChartRight setPieCenter:CGPointMake(240, 240)];
    [pieChartRight setUserInteractionEnabled:YES];
    [pieChartRight setDelegate:self];
    [pieChartRight setDataSource:self];
    [pieChartRight setPieCenter:CGPointMake(100, 100)];
    [pieChartRight setShowPercentage:YES];
    self.sliceColors =[NSArray arrayWithObjects:
                       [UIColor colorWithRed:246/255.0 green:155/255.0 blue:0/255.0 alpha:1],
                       [UIColor colorWithRed:129/255.0 green:195/255.0 blue:29/255.0 alpha:1],
                       [UIColor colorWithRed:62/255.0 green:173/255.0 blue:219/255.0 alpha:1],
                       [UIColor colorWithRed:229/255.0 green:66/255.0 blue:115/255.0 alpha:1],
                       [UIColor colorWithRed:148/255.0 green:141/255.0 blue:139/255.0 alpha:1],nil];
    [self.view addSubview:pieChartRight];
    [self addPieText];
    
    
    
    //饼图表格
    [self initPieData];
    tablePieView = [[XCMultiTableView alloc] initWithFrame:CGRectMake(35, 304, 700, 620)];
    tablePieView.leftHeaderEnable = NO;
    tablePieView.datasource = self;
    [self.view addSubview:tablePieView];
    
    //加载梯形
    myWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0,0,width,height)];
    myWebView.delegate = self;
    [self.view addSubview:myWebView];
    [myWebView setHidden:YES];
    
    NSString *htmlPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"mycanvas.htm"];
    NSString *htmlString = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    [myWebView loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:htmlPath]];
    
    
}


-(void)addPieText {
    
    NSMutableArray *list = [NSMutableArray arrayWithObjects:@"电视",@"报纸",@"市场活动",@"电销",@"上门", nil];
    for (int i = 0 ; i < 5; i++) {
        UIButton  *btn1= [[UIButton alloc]initWithFrame:CGRectMake(400, 69 + i * 35, 20, 20)];
        btn1.backgroundColor=[self.sliceColors objectAtIndex:(i % self.sliceColors.count)];
        [self.view addSubview:btn1];
        
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(450, 69 + i * 35, 100, 20)];
        label1.text = [list objectAtIndex:i];
        label1.textColor = [self.sliceColors objectAtIndex:(i % self.sliceColors.count)];
        [self.view addSubview:label1];
    }

}

- (void)initPieData {
    headDataPie = [NSMutableArray arrayWithCapacity:10];
    [headDataPie addObject:@"日期"];
    [headDataPie addObject:@"客户名称"];
    [headDataPie addObject:@"电话"];
    [headDataPie addObject:@"来源"];
    
    leftTableDataPie = [NSMutableArray arrayWithCapacity:10];
    NSMutableArray *one = [NSMutableArray arrayWithCapacity:10];
    for (int i = 0; i < 3; i++) {
        [one addObject:[NSString stringWithFormat:@"ki-%d", i]];
    }
    [leftTableDataPie addObject:one];
    
    
    rightTableDataPie = [NSMutableArray arrayWithCapacity:10];
    
    NSMutableArray *oneR = [NSMutableArray arrayWithCapacity:10];
    for (int i = 0; i < 5; i++) {
        NSMutableArray *ary = [NSMutableArray arrayWithCapacity:4];
        for (int j = 0; j < 4; j++) {
            if (j == 0) {
                [ary addObject:@"2013-02-27"];
            }else if (j == 1) {
                [ary addObject:@"李先生"];
            }
            else if (j == 2){
                [ary addObject:@"13888888888"];
            }else{
                [ary addObject:@"电视"];
            }
        }
        [oneR addObject:ary];
    }
    [rightTableDataPie addObject:oneR];
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
    NSString *js = [NSString stringWithFormat:@"function getUsername(){ return [%d,%d,%d,%d,%d]; }", 10,20,30,40,10];
    [myWebView stringByEvaluatingJavaScriptFromString:js];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getHttpInfo];
    self.slices = [NSMutableArray arrayWithCapacity:5];
    
    for(int i = 0; i < 5; i ++)
    {
        NSNumber *one = [NSNumber numberWithInt:rand()%60+20];
        [_slices addObject:one];
    }

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [self.pieChartLeft reloadData];
    [pieChartRight reloadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}


- (void)segmentView:(SegmentView *)segmentView didSelectedSegmentAtIndex:(int)index
{
//    NSLog(@"点击了哪个位置---%d", index);
    [self clearSlices];
    if (index == 1) {
        [tablePieView setHidden:YES];
        [myWebView setHidden:NO];
    }else if(index == 0)
        [myWebView setHidden:YES];
        [tablePieView setHidden:NO];
        [self addSlice];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clearSlices {
    [_slices removeAllObjects];
//    [self.pieChartLeft reloadData];
//    [pieChartRight reloadData];
}

- (void)addSlice
{
    NSInteger num = 5;
    if (num > 0) {
        for (int n=0; n < abs(num); n++)
        {
            NSNumber *one = [NSNumber numberWithInt:rand()%60+20];
//            NSInteger index = 0;
//            if(self.slices.count > 0)
//            {
//                switch (self.indexOfSlices.selectedSegmentIndex) {
//                    case 1:
//                        index = rand()%self.slices.count;
//                        break;
//                    case 2:
//                        index = self.slices.count - 1;
//                        break;
//                }
//            }
//            [_slices insertObject:one atIndex:index];
            [_slices addObject:one];
        }
    }
    else if (num < 0)
    {
        if(self.slices.count <= 0) return;
        for (int n=0; n < abs(num); n++)
        {
//            NSInteger index = 0;
            if(self.slices.count > 0)
            {
//                switch (self.indexOfSlices.selectedSegmentIndex) {
//                    case 1:
//                        index = rand()%self.slices.count;
//                        break;
//                    case 2:
//                        index = self.slices.count - 1;
//                        break;
//                }
//                [_slices removeObjectAtIndex:index];
            [_slices removeLastObject];
            }
        }
    }
//    [pieChartLeft reloadData];
    [pieChartRight reloadData];
}


#pragma mark - XYPieChart Data Source

- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart
{
    return self.slices.count;
}

- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index
{
    return [[self.slices objectAtIndex:index] intValue];
}

- (UIColor *)pieChart:(XYPieChart *)pieChart colorForSliceAtIndex:(NSUInteger)index
{
//    if(pieChart == pieChartRight) return nil;
    return [self.sliceColors objectAtIndex:(index % self.sliceColors.count)];
}

#pragma mark - XYPieChart Delegate
- (void)pieChart:(XYPieChart *)pieChart didSelectSliceAtIndex:(NSUInteger)index
{
    NSLog(@"did select slice at index %d",index);
//    self.selectedSliceLabel.text = [NSString stringWithFormat:@"$%@",[self.slices objectAtIndex:index]];
}



#pragma mark - XCMultiTableViewDataSource


- (NSArray *)arrayDataForTopHeaderInTableView:(XCMultiTableView *)tableView {
    return [headDataPie copy];
}
- (NSArray *)arrayDataForLeftHeaderInTableView:(XCMultiTableView *)tableView InSection:(NSUInteger)section {
    return [leftTableDataPie objectAtIndex:section];
}

- (NSArray *)arrayDataForContentInTableView:(XCMultiTableView *)tableView InSection:(NSUInteger)section {
    return [rightTableDataPie objectAtIndex:section];
}


- (NSUInteger)numberOfSectionsInTableView:(XCMultiTableView *)tableView {
    return [leftTableDataPie count];
}

- (CGFloat)tableView:(XCMultiTableView *)tableView contentTableCellWidth:(NSUInteger)column {
    if (column == 0) {
        return 185.0f;
    }else if (column == 1){
        return 143.0f;
    }else if (column == 2)
        return 265.0f;
    return 145.0f;
}

- (CGFloat)tableView:(XCMultiTableView *)tableView cellHeightInRow:(NSUInteger)row InSection:(NSUInteger)section {
    if (section == 0) {
        return 60.0f;
    }else {
        return 30.0f;
    }
}

- (UIColor *)tableView:(XCMultiTableView *)tableView bgColorInSection:(NSUInteger)section InRow:(NSUInteger)row InColumn:(NSUInteger)column {
//    if (row == 1 && section == 0) {
//        return [UIColor redColor];
//    }
    return [UIColor clearColor];
}

- (UIColor *)tableView:(XCMultiTableView *)tableView headerBgColorInColumn:(NSUInteger)column {
//    if (column == -1) {
//        return [UIColor redColor];
//    }else if (column == 1) {
//        return [UIColor grayColor];
//    }
    return kAnalyseBg;
//    return [UIColor clearColor];
}



@end
