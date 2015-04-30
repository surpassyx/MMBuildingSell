//
//  SelectViewController.m
//  MMBuildingSell
//
//  Created by 3G组 on 13-10-14.
//  Copyright (c) 2013年 Y.X. All rights reserved.
//

#import "SelectViewController.h"
#import "SegmentView.h"
#import "SJAvatarBrowser.h"
#import <QuartzCore/QuartzCore.h>
#import "AFNetworking.h"
#import "UIViewController+CWPopup.h"
#import "CalculatorViewController.h"
#import "FangDaiViewController.h"
#import "HouseCell.h"

#import "TSTableViewModel.h"
#import "TSDefines.h"
#import <QuartzCore/QuartzCore.h>

#import "ZhiYeJiHuaViewController.h"

#import "UIImageView+WebCache.h"

@interface SelectViewController () <SegmentViewDelegate,QCheckBoxDelegate,TSTableViewDelegate>
{
    TSTableView *_tableView1;
    TSTableViewModel *_model1;
    
//    NSArray *_tables;
//    NSArray *_dataModels;
//    NSArray *_rowExamples;
    
    NSMutableDictionary *louData;

}

//@property (nonatomic,strong) UITableView *myTableView;

@end

@implementation SelectViewController
@synthesize dataList;

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return [self.dataList count];
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"HouseCellIdentifier";
//    HouseCell *cell = (HouseCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"HouseCell" owner:self options:nil];
//        cell = [array objectAtIndex:0];
//        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
//    }
//    NSMutableDictionary *rowData = [[NSMutableDictionary alloc]init];
//    rowData = [self.dataList objectAtIndex:indexPath.row];
//    [cell.roomCode setText:[rowData objectForKey:@"roomcode"]];
//    [cell.roomName setText:[rowData objectForKey:@"roomname"]];
//    [cell.roomType setText:[rowData objectForKey:@"roomtype"]];
//    [cell.allAres setText:[rowData objectForKey:@"allares"]];
//    [cell.roomState setText:[rowData objectForKey:@"roomstatus"]];
//    return cell;
//}
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    nCurSelected = indexPath.row;
//    NSMutableDictionary *rowData = [[NSMutableDictionary alloc]init];
//    rowData = [self.dataList objectAtIndex:indexPath.row];
//    rowHouseData = rowData;
//    roomNameLabel.text = [rowData objectForKey:@"roomname"];
//    NSString * strRoomStatus = [rowData objectForKey:@"roomstatus"];
//    if ([strRoomStatus isEqualToString:@"1"]) {
//        strRoomStatus = @"销售状态：销控";
//    }else if ([strRoomStatus isEqualToString:@"2"]){
//        strRoomStatus = @"销售状态：待售";
//    }else if ([strRoomStatus isEqualToString:@"3"]){
//        strRoomStatus = @"销售状态：预约";
//    }else if ([strRoomStatus isEqualToString:@"4"]){
//        strRoomStatus = @"销售状态：预留";
//    }else if ([strRoomStatus isEqualToString:@"5"]){
//        strRoomStatus = @"销售状态：小订";
//    }else if ([strRoomStatus isEqualToString:@"6"]){
//        strRoomStatus = @"销售状态：认购";
//    }else if ([strRoomStatus isEqualToString:@"7"]){
//        strRoomStatus = @"销售状态：签约";
//    }else if ([strRoomStatus isEqualToString:@"8"]){
//        strRoomStatus = @"销售状态：非售";
//    }
//    roomSatausLabel.text = strRoomStatus;
//    
//    NSString * strRoomType = [rowData objectForKey:@"roomtype"];
//    strRoomType = [@"房间类型：" stringByAppendingString:strRoomType];
//    roomTypeLabel.text = strRoomType;
//    
//    NSString * strAllAres = [rowData objectForKey:@"allares"];
//    strAllAres = [@"建筑面积：" stringByAppendingString:strAllAres];
//    strAllAres = [strAllAres stringByAppendingString:@" ㎡"];
//    allAresLabel.text = strAllAres;
//    
//    NSString * strRealAres = [rowData objectForKey:@"realares"];
//    strRealAres = [@"室内面积：" stringByAppendingString:strRealAres];
//    strRealAres = [strRealAres stringByAppendingString:@" ㎡"];
//    realAresLabel.text = strRealAres;
//    
//    NSString * strRealPrice = [rowData objectForKey:@"realprice"];
//    strRealPrice = [@"建筑单价：" stringByAppendingString:strRealPrice];
//    strRealPrice = [strRealPrice stringByAppendingString:@" 万元/㎡"];
//    realPriceLabel.text = strRealPrice;
//    
////    NSString * strAllPriceSS = @"";
////    strAllPriceSS = [strAllPriceSS stringByAppendingString:[rowData objectForKey:@"allprice"]];
////    strAllPriceSS = [@"套内单价：" stringByAppendingString:strAllPriceSS];
////    strAllPriceSS = [strAllPriceSS stringByAppendingString:@" 万元"];
////    danjiaLabel.text = strAllPriceSS;
//    
//    NSString * strTotal = [rowData objectForKey:@"total"];
//    strTotal = [@"标准总价：" stringByAppendingString:strTotal];
//    strTotal = [strTotal stringByAppendingString:@" 万元"];
//    totalLabel.text = strTotal;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 70;
//}


-(void)initRightView
{
    imageView=[[UIImageView alloc] initWithFrame:CGRectMake(555, 110 - 46, 210, 165)];
    [imageView setImage:[UIImage imageNamed:@"huxingtu.jpg"]];
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick:)];
    [imageView addGestureRecognizer:singleTap];
    
    [self.view addSubview:imageView];

    roomNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(545, 300 - 46, 220, 30)];
    roomNameLabel.text = @"1-1802";
    [self.view addSubview:roomNameLabel];
    
    roomSatausLabel = [[UILabel alloc]initWithFrame:CGRectMake(545, 285, 220, 30)];
    roomSatausLabel.text = @"销售状态：待售";
    [self.view addSubview:roomSatausLabel];
    
    roomTypeLabel = [[UILabel alloc]initWithFrame:CGRectMake(545, 315, 220, 30)];
    roomTypeLabel.text = @"房间类型：一室一厅一卫";
    [self.view addSubview:roomTypeLabel];
    
//    allAresLabel = [[UILabel alloc]initWithFrame:CGRectMake(545, 345, 220, 30)];
//    allAresLabel.text = @"建筑面积：0 ㎡";
//    [self.view addSubview:allAresLabel];
    
    realAresLabel = [[UILabel alloc]initWithFrame:CGRectMake(545, 375, 220, 30)];
    realAresLabel.text = @"室内面积：0 ㎡";
    [self.view addSubview:realAresLabel];
    
    realPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(545, 405, 220, 30)];
    realPriceLabel.text = @"单价：10000";
    [self.view addSubview:realPriceLabel];
    
    
    
    danjiaLabel = [[UILabel alloc]initWithFrame:CGRectMake(545, 435, 220, 30)];
    danjiaLabel.text = @"单价：10000";
    [self.view addSubview:danjiaLabel];
    
    totalLabel = [[UILabel alloc]initWithFrame:CGRectMake(545, 465, 220, 30)];
    totalLabel.text = @"总价：6500000";
    [self.view addSubview:totalLabel];
    
    
//    freeTotalJisuanBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    freeTotalJisuanBtn.frame = CGRectMake(700, 435, 38, 35);
////    [freeTotalJisuanBtn setTitle:@"计算" forState:UIControlStateNormal];
//    [freeTotalJisuanBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [freeTotalJisuanBtn setBackgroundImage:[UIImage imageNamed:@"item_calculator_btn"] forState:UIControlStateNormal];
//    [freeTotalJisuanBtn addTarget:self action:@selector(btnPresentPopup:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:freeTotalJisuanBtn];
    
    
//    selectBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    selectBtn.frame = CGRectMake(545, 500, 220, 40);
//    [selectBtn setTitle:@"购买方案" forState:UIControlStateNormal];
//    [selectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [selectBtn setBackgroundImage:[UIImage imageNamed:@"select_btn_compute"] forState:UIControlStateNormal];
//    [selectBtn addTarget:self action:@selector(selectClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:selectBtn];
    
    nextBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    nextBtn.frame = CGRectMake(545, 550, 220, 40);
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [nextBtn setBackgroundImage:[UIImage imageNamed:@"task_send_normal_btn"] forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(nextBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];

    
}

-(void)analysisHouseJson:(NSDictionary *)jsonDic
{
    NSString * strSign = [jsonDic objectForKey:@"sign"];
    int intString = [strSign intValue];
    if (intString == 1) {
        NSMutableArray *arrInfo = [jsonDic objectForKey:@"arr"];
        for (int i = 0; i < arrInfo.count ; i++) {
            NSDictionary *dicInfo = [arrInfo objectAtIndex:i];
            
            NSString * strLoudongName = [dicInfo objectForKey:@"floorName"];
            NSString * strCengNum = [dicInfo objectForKey:@"floorLayers"];
            NSMutableArray *arrLou = [dicInfo objectForKey:@"floorArr"];
             NSMutableArray *arrTemp2 = [[NSMutableArray alloc]init];
            
            for (int i = 0; i < arrLou.count ; i++) {
                
                NSDictionary *louInfo = [arrLou objectAtIndex:i];
                
                NSString * strDanyuanName = [louInfo objectForKey:@"unitName"];
               
                NSMutableArray *arrDanyuan = [louInfo objectForKey:@"unitArr"];
                
                 NSString * strDanyuanNum = [[NSString alloc]initWithFormat:@"%lu",[arrDanyuan count]/[strCengNum intValue]];
                
                NSMutableDictionary *danyuanArrData = [[NSMutableDictionary alloc]init];
                [danyuanArrData setValue:strDanyuanNum forKey:@"danyuan_num"];
                [danyuanArrData setValue:strDanyuanName forKey:@"unitName"];
                NSMutableArray *arrTemp = [[NSMutableArray alloc]init];
                for (int i = 0; i < arrDanyuan.count ; i++) {
                    NSDictionary *dicInfo = [arrDanyuan objectAtIndex:i];
                    NSString * strId =[dicInfo objectForKey:@"id"];
                    NSString * strRoomCode = [dicInfo objectForKey:@"roomcode"];
                    NSString * strRoomName =[dicInfo objectForKey:@"roomname"];
                    NSString * strRoomType =[dicInfo objectForKey:@"roomtype"];
                    NSString * strRoomStatus =[dicInfo objectForKey:@"roomstatus"];
                    NSString * strAllAres =[dicInfo objectForKey:@"allares"];
                    NSString * strRealAres =[dicInfo objectForKey:@"realares"];
                    NSString * strAllPrice =[dicInfo objectForKey:@"allprice"];
                    NSString * strRealPrice =[dicInfo objectForKey:@"realprice"];
                    NSString * strTotal =[dicInfo objectForKey:@"total"];
                    NSString * strDocname =[dicInfo objectForKey:@"docname"];
                    
                    NSMutableDictionary *roomArrData = [[NSMutableDictionary alloc]init];
                    [roomArrData setValue:strId forKey:@"id"];
                    [roomArrData setValue:[NSNumber numberWithInt: [strRoomCode intValue]] forKey:@"roomcode"];
                    [roomArrData setValue:strRoomName forKey:@"roomname"];
                    [roomArrData setValue:strRoomType forKey:@"roomtype"];
                    [roomArrData setValue:strRoomStatus forKey:@"roomstatus"];
                    [roomArrData setValue:strAllAres forKey:@"allares"];
                    [roomArrData setValue:strRealAres forKey:@"realares"];
                    [roomArrData setValue:strAllPrice forKey:@"allprice"];
                    [roomArrData setValue:strRealPrice forKey:@"realprice"];
                    [roomArrData setValue:strTotal forKey:@"total"];
                    [roomArrData setValue:strDocname forKey:@"docname"];
                    
                    [arrTemp addObject:roomArrData];
                }
                arrTemp = [self sortArray:arrTemp key:@"roomcode" isAscending:YES];
                [danyuanArrData setValue:arrTemp forKey:@"unitArr"];
                [arrTemp2 addObject:danyuanArrData];
            }
            NSMutableDictionary *rowData = [[NSMutableDictionary alloc]init];
            [rowData setValue:strLoudongName forKey:@"floorName"];
            [rowData setValue:strCengNum forKey:@"floorLayers"];
            [rowData setValue:arrTemp2 forKey:@"floorArr"];
            [self.dataList addObject:rowData];
        }
        
    }else{
        NSLog(@"服务端返回错误");
    }
}

#pragma mark数组排序 第一个变量为排序数组 第二个变量为要排序的关键字 第三个变量为是否是升序
-(NSMutableArray *)sortArray:(NSMutableArray *)arr key:(NSString *)keystring isAscending:(BOOL)isAscending
{
    NSSortDescriptor* sortByA = [NSSortDescriptor sortDescriptorWithKey:keystring ascending:isAscending];
    arr = [[NSMutableArray alloc]initWithArray:[arr sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortByA]]];
    return arr;
}

-(void)getHttpInfo
{
    //http://www.ykhome.cn/myhome/gettype.php?&fenterisecode=P0001&finstallment=01
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * strUrl = [[NSString alloc]initWithFormat:@"action=4&enterisecode=%@&installment=%@",[userDefaults objectForKey:@"enterpriseCode"],[userDefaults objectForKey:@"installment"]];
    NSLog(@"房屋信息获取url:%@",strUrl);
    NSString * hexUrl  = [Utility hexStringFromString:strUrl];
    NSLog(@"房屋信息获取hexurl:%@",API_BASE_URL(hexUrl));
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:API_BASE_URL(hexUrl) parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"selectedß---JSON: %@", responseObject);
        [self analysisHouseJson:(NSDictionary *)responseObject];
        [self initAllView];
//        [self.myTableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}

-(void)initAllView
{
    NSMutableArray * nameArr = [[NSMutableArray alloc]init];
    for (NSMutableDictionary *rowData in self.dataList) {
        NSString * strName = [rowData objectForKey:@"floorName"];
        [nameArr addObject:strName];
    }
    SegmentView *segmentView = [[SegmentView alloc] init];
    segmentView.titles = nameArr;
    segmentView.delegate = self;
    self.navigationItem.titleView = segmentView;
    
    self.view.backgroundColor = kAllStatusBg;
    
    if([self.dataList count] > 0)
        strLouDongName = [[self.dataList objectAtIndex:0] objectForKey:@"floorName"];

    
    imageViewLeftBk = [[UIImageView alloc] initWithFrame:CGRectMake(0 , 0, 516, 704)];
    [imageViewLeftBk setImage:[UIImage imageNamed:@"select_left_bk"]];
    [self.view addSubview:imageViewLeftBk];
    
    imageViewRightBk = [[UIImageView alloc] initWithFrame:CGRectMake(516, 0, 297, 704)];
    [imageViewRightBk setImage:[UIImage imageNamed:@"select_right_bk"]];
    [self.view addSubview:imageViewRightBk];
    
    [self initRightView];
    
    _tableView1 = [[TSTableView alloc] initWithFrame:CGRectMake(23, 35, 516 - 34, 704 - 60)];
    _tableView1.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView1.delegate = self;
    _tableView1.lineNumbersHidden = YES;
    [self.view addSubview:_tableView1];
    
    _model1 = [[TSTableViewModel alloc] initWithTableView:_tableView1 andStyle:kTSTableViewStyleLight];
    
    //    NSArray *columns2 = [self columnsInfo2];
    //    NSArray *rows2 = [self rowsInfo2];
    //    [_model2 setColumns:columns2 andRows:rows2];
    if ([self.dataList count] > 0) {
       louData = [self.dataList objectAtIndex:0];
    }
    
    NSArray *columns2 = [self columnsForBuild];
    NSArray *rows2 = [self rowsForBuild];
    [_model1 setColumns:columns2 andRows:rows2];

}

//- (void)receivedPushContent:(NSNotification*)notification{
//    NSString *content = [notification object];
//    [XWAlterview showmessage:@"新消息" subtitle:content cancelbutton:@"确定"];
//}
//
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedPushContent:) name:@"PUSHCONTENT" object:nil];
//}
//
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"PUSHCONTENT" object:nil];
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataList = [[NSMutableArray alloc]init];
    louData = [[NSMutableDictionary alloc]init];
    [self getHttpInfo];
    
    
//    [self initAllView];
    
}

-(void)nextBtnAction:(id)sender {
    ZhiYeJiHuaViewController * zhiye = [[ZhiYeJiHuaViewController alloc]init];
    [zhiye initHouseData:rowHouseData];
    [self.navigationController pushViewController:zhiye animated:NO];
    
//    PrintPurchasingViewController *print = [[PrintPurchasingViewController alloc]init];
//    [print initData:rowHouseData];
//    [self.navigationController pushViewController:print animated:NO];
}

-(void)imageClick:(UITapGestureRecognizer*)sender {
    [SJAvatarBrowser showImage:(UIImageView*)sender.view];
}


- (void)segmentView:(SegmentView *)segmentView didSelectedSegmentAtIndex:(int)index
{
    
    strLouDongName = [[self.dataList objectAtIndex:index] objectForKey:@"floorName"];
    louData = [self.dataList objectAtIndex:index];
    NSArray *columns2 = [self columnsForBuild];
    NSArray *rows2 = [self rowsForBuild];
    [_model1 setColumns:columns2 andRows:rows2];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - QCheckBoxDelegate

- (void)didSelectedCheckBox:(QCheckBox *)checkbox checked:(BOOL)checked {
    NSLog(@"did tap on CheckBox:%@ checked:%d", checkbox.titleLabel.text, checked);
}

//- (void)selectClicked:(id)sender {
//    NSArray * arr = [[NSArray alloc] init];
//    arr = [NSArray arrayWithObjects:@"一次性购房", @"公积金贷款", @"商业贷款", @"混合贷款",nil];
//    NSArray * arrImage = [[NSArray alloc] init];
//    arrImage = [NSArray arrayWithObjects:[UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], nil];
//    if(dropDown == nil) {
//        CGFloat f = 200;
//        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arr :arrImage :@"down"];
//        dropDown.delegate = self;
//    }
//    else {
//        [dropDown hideDropDown:sender];
//        [self rel];
//    }
//}
//
//- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
//    [self rel];
//}
//
//-(void)rel{
//    //    [dropDown release];
//    dropDown = nil;
//}

#pragma mark - Popup Functions

- (void)btnPresentPopup:(UIButton *)sender {

    FangDaiViewController *samplePopupViewController = [[FangDaiViewController alloc] initWithNibName:@"FangDaiViewController" bundle:nil];
    [samplePopupViewController setCurHouseInfo:@"8000" ares:@"90cc"];
    [self.navigationController pushViewController:samplePopupViewController animated:NO];

}

- (void)dismissPopup {
    if (self.popupViewController != nil) {
        [self dismissPopupViewControllerAnimated:YES completion:^{
            NSLog(@"popup view dismissed");
        }];
    }
}

#pragma mark - gesture recognizer delegate functions

// so that tapping popup view doesnt dismiss it
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return touch.view == self.view;
}

#pragma mark - TSTableViewDelegate

- (void)tableView:(TSTableView *)tableView willSelectRowAtPath:(NSIndexPath *)rowPath selectedCell:(NSInteger)cellIndex animated:(BOOL)animated
{
    VerboseLog();
}

- (void)tableView:(TSTableView *)tableView didSelectRowAtPath:(NSIndexPath *)rowPath selectedCell:(NSInteger)cellIndex
{
    VerboseLog();
//    NSLog(@"postion:%d",[rowPath indexAtPosition:0]);
//    NSLog(@"---cellIndex:%d",cellIndex);
    
    int nSelectedRow = [rowPath indexAtPosition:0];
    
    NSMutableArray * floorArr = [[NSMutableArray alloc]init];
    floorArr = [louData objectForKey:@"floorArr"];
    NSString * strCeng = [louData objectForKey:@"floorLayers"];
    int nCeng = [strCeng intValue];
    
    int i = nCeng - nSelectedRow;
    int danyuan_no = 0;
    int nTotalNum = 0;
    for (int q = 0 ; q < [floorArr count]; q++) {
        NSString *danyuan_num = [[floorArr objectAtIndex:q] objectForKey:@"danyuan_num"];
        int nDanyuan_num = [danyuan_num intValue];
        
        if (nTotalNum + nDanyuan_num  >= cellIndex) {
            danyuan_no = q;
            break;
        }
        nTotalNum = nDanyuan_num + nTotalNum;
    }
    
    NSString * danyuan_numStr = [[floorArr objectAtIndex:danyuan_no] objectForKey:@"danyuan_num"];
    int danyuan_num = [danyuan_numStr intValue];
    
    NSMutableArray *unitArr = [[floorArr objectAtIndex:danyuan_no] objectForKey:@"unitArr"];
    
    NSString * strUnitName = [[floorArr objectAtIndex:danyuan_no] objectForKey:@"unitName"];
    
    int k = cellIndex - nTotalNum;
    if (k==0) {
        k = danyuan_num;
    }
    int nn = danyuan_num*(i-1)+k - 1;
    NSMutableDictionary *roomArrData = [[NSMutableDictionary alloc]init];
    roomArrData = [unitArr objectAtIndex:nn];
    
    rowHouseData = roomArrData;
    
//    NSString * strId = [roomArrData objectForKey:@"id"];
//    NSNumber * nRoomCode = [roomArrData objectForKey:@"roomcode"];
    NSString * strRoomName = [roomArrData objectForKey:@"roomname"];
    NSString * strRoomType = [roomArrData objectForKey:@"roomtype"];
    NSString * strRoomStatus = [roomArrData objectForKey:@"roomstatus"];
    NSString * strAllAres = [roomArrData objectForKey:@"allares"];
    NSString * strRealAres = [roomArrData objectForKey:@"realares"];
    NSString * strAllPrice = [roomArrData objectForKey:@"allprice"];
    NSString * strRealPrice = [roomArrData objectForKey:@"realprice"];
    NSString * strTotal = [roomArrData objectForKey:@"total"];
    NSString * strDocname =[roomArrData objectForKey:@"docname"];
    
    [[NSUserDefaults standardUserDefaults] setObject:strDocname forKey:@"huxingtu_pic"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    roomNameLabel.text = [[NSString alloc]initWithFormat:@"%@-%@-%@",strLouDongName,strUnitName,strRoomName];
    if ([strRoomStatus isEqualToString:@"1"]) {
        strRoomStatus = @"销售状态：销控";
    }else if ([strRoomStatus isEqualToString:@"2"]){
        strRoomStatus = @"销售状态：待售";
    }else if ([strRoomStatus isEqualToString:@"3"]){
        strRoomStatus = @"销售状态：预约";
    }else if ([strRoomStatus isEqualToString:@"4"]){
        strRoomStatus = @"销售状态：预留";
    }else if ([strRoomStatus isEqualToString:@"5"]){
        strRoomStatus = @"销售状态：小订";
    }else if ([strRoomStatus isEqualToString:@"6"]){
        strRoomStatus = @"销售状态：认购";
    }else if ([strRoomStatus isEqualToString:@"7"]){
        strRoomStatus = @"销售状态：签约";
    }else if ([strRoomStatus isEqualToString:@"8"]){
        strRoomStatus = @"销售状态：非售";
    }
    roomSatausLabel.text = strRoomStatus;
    
    strRoomType = [@"房间类型：" stringByAppendingString:strRoomType];
    roomTypeLabel.text = strRoomType;
    
    strAllAres = [@"建筑面积：" stringByAppendingString:strAllAres];
    strAllAres = [strAllAres stringByAppendingString:@" ㎡"];
    allAresLabel.text = strAllAres;
    
    strRealAres = [@"室内面积：" stringByAppendingString:strRealAres];
    strRealAres = [strRealAres stringByAppendingString:@" ㎡"];
    realAresLabel.text = strRealAres;
    
    strRealPrice = [@"建筑单价：" stringByAppendingString:strRealPrice];
    strRealPrice = [strRealPrice stringByAppendingString:@" 元/㎡"];
    realPriceLabel.text = strRealPrice;

    strAllPrice = [@"套内单价：" stringByAppendingString:strAllPrice];
    strAllPrice = [strAllPrice stringByAppendingString:@" 元"];
    danjiaLabel.text = strAllPrice;
    
    strTotal = [@"标准总价：" stringByAppendingString:strTotal];
    strTotal = [strTotal stringByAppendingString:@" 元"];
    totalLabel.text = strTotal;

    [imageView sd_setImageWithURL:[NSURL URLWithString:PIC_BASE_URL(strDocname)] placeholderImage:[UIImage imageNamed:@"huxingtu.jpg"]];
    
    
//    NSLog(@"---k:%d",k);
//    NSLog(@"---nTotalNum:%d",nTotalNum);
//    NSLog(@"---strRoomName:%@",strRoomName);
}

- (void)tableView:(TSTableView *)tableView willSelectColumnAtPath:(NSIndexPath *)columnPath animated:(BOOL)animated
{
    VerboseLog();
}

- (void)tableView:(TSTableView *)tableView didSelectColumnAtPath:(NSIndexPath *)columnPath
{
    VerboseLog();
}

- (void)tableView:(TSTableView *)tableView widthDidChangeForColumnAtIndex:(NSInteger)columnIndex
{
    VerboseLog();
}

- (void)tableView:(TSTableView *)tableView expandStateDidChange:(BOOL)expand forRowAtPath:(NSIndexPath *)rowPath
{
    VerboseLog();
}

#pragma mark - FileSystem

- (NSArray *)columnsForBuild
{
    NSMutableArray *myMutableArray = [[NSMutableArray alloc]init];
     NSMutableArray *arrTemp = [[NSMutableArray alloc]init];
    arrTemp = [louData objectForKey:@"floorArr"];
    TSColumn * tsRow = [TSColumn columnWithDictionary:@{ @"title" : @"楼层名称", @"subtitle" : @"", @"minWidth" : @70, @"defWidth" : @70 }];
    [myMutableArray addObject:tsRow];
    for (NSMutableDictionary *danyuanArrData in arrTemp) {
        
        NSString * strNum = [danyuanArrData objectForKey:@"danyuan_num"];
        NSInteger num = [strNum integerValue];
        NSString * strName = [danyuanArrData objectForKey:@"unitName"];
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc]init];
        [tempDic setObject:strName forKey:@"title"];
        NSMutableArray *arrTemp2 = [[NSMutableArray alloc]init];
        for (int i = 1; i <= num; i++) {
            NSMutableDictionary *tempDic2 = [[NSMutableDictionary alloc]init];
            NSString * strNnnn = [[NSString alloc]initWithFormat:@"%2d",i];
            [tempDic2 setObject:strNnnn forKey:@"title"];
            [tempDic2 setObject:@12 forKey:@"titleFontSize"];
            [tempDic2 setObject:@"FF006F00" forKey:@"titleColor"];
            [tempDic2 setObject:@70 forKey:@"defWidth"];
            [tempDic2 setObject:@70 forKey:@"minWidth"];
            
            [arrTemp2 addObject:tempDic2];
        }
        [tempDic setObject:arrTemp2 forKey:@"subcolumns"];
        
        TSColumn * tsRow1 = [TSColumn columnWithDictionary:tempDic];
        [myMutableArray addObject:tsRow1];
    }
    
    return [myMutableArray copy];
}
#pragma mark 每一行构建
- (NSArray *)rowsForBuild
{
    
    NSMutableArray * floorArr = [[NSMutableArray alloc]init];
    floorArr = [louData objectForKey:@"floorArr"];
    NSString * strCeng = [louData objectForKey:@"floorLayers"];
    int nCeng = [strCeng intValue];
//    danyuan_num
    NSMutableArray *rows = [[NSMutableArray alloc] initWithCapacity:nCeng];
    
    for (int i = nCeng; i > 0; i--) {
        
        NSMutableArray *arrTemp2 = [[NSMutableArray alloc]init];
        
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc]init];
        NSString * strI = [[NSString alloc]initWithFormat:@"%02d",i];
        NSDictionary *cellCengInfo = @{
                                   @"value" : strI
                                   };
        [arrTemp2 addObject:cellCengInfo];
        
        for (int j = 0 ; j < [floorArr count]; j++) {
            
            NSString * danyuan_numStr = [[floorArr objectAtIndex:j] objectForKey:@"danyuan_num"];
            int danyuan_num = [danyuan_numStr intValue];
            for (int k = 0; k < danyuan_num; k++) {
                NSMutableArray *unitArr = [[floorArr objectAtIndex:j] objectForKey:@"unitArr"];
                int nn = danyuan_num*(i-1)+k;
                NSString * strRoomName = [[unitArr objectAtIndex:nn] objectForKey:@"roomname"];
                NSString * strRoomState = [[unitArr objectAtIndex:nn] objectForKey:@"roomstatus"];
                TSCell *cellFilename = [TSCell cellWithValue:strRoomName];
                if ([@"1" isEqualToString:strRoomState]) {
                    cellFilename.icon = [UIImage imageNamed:@"1"];
                }else if ([@"2" isEqualToString:strRoomState]){
                    cellFilename.icon = [UIImage imageNamed:@"2"];
                }else if ([@"3" isEqualToString:strRoomState]){
                    cellFilename.icon = [UIImage imageNamed:@"3"];
                }else if ([@"4" isEqualToString:strRoomState]){
                    cellFilename.icon = [UIImage imageNamed:@"4"];
                }else if ([@"5" isEqualToString:strRoomState]){
                    cellFilename.icon = [UIImage imageNamed:@"5"];
                }else if ([@"6" isEqualToString:strRoomState]){
                    cellFilename.icon = [UIImage imageNamed:@"6"];
                }else if ([@"7" isEqualToString:strRoomState]){
                    cellFilename.icon = [UIImage imageNamed:@"7"];
                }else if ([@"8" isEqualToString:strRoomState]){
                    cellFilename.icon = [UIImage imageNamed:@"8"];
                }
                cellFilename.textColor = [UIColor grayColor];
                [arrTemp2 addObject:cellFilename];
            }
            
        }
        [tempDic setObject:arrTemp2 forKey:@"cells"];
        
        TSRow *row = [TSRow rowWithDictionary:tempDic];
        [rows addObject:row];

    }
    
    return [rows copy];
    
}


@end
