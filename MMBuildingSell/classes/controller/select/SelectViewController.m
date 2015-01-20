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
    roomNameLabel.text = @"1#楼1单元1楼1号";
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
    realPriceLabel.text = @"单价：1万";
    [self.view addSubview:realPriceLabel];
    
    
    
    danjiaLabel = [[UILabel alloc]initWithFrame:CGRectMake(545, 435, 220, 30)];
    danjiaLabel.text = @"单价：1万";
    [self.view addSubview:danjiaLabel];
    
    totalLabel = [[UILabel alloc]initWithFrame:CGRectMake(545, 465, 220, 30)];
    totalLabel.text = @"总价：65万";
    [self.view addSubview:totalLabel];
    
    
    freeTotalJisuanBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    freeTotalJisuanBtn.frame = CGRectMake(700, 435, 38, 35);
//    [freeTotalJisuanBtn setTitle:@"计算" forState:UIControlStateNormal];
    [freeTotalJisuanBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [freeTotalJisuanBtn setBackgroundImage:[UIImage imageNamed:@"item_calculator_btn"] forState:UIControlStateNormal];
    [freeTotalJisuanBtn addTarget:self action:@selector(btnPresentPopup:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:freeTotalJisuanBtn];
    
    
//    selectBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    selectBtn.frame = CGRectMake(545, 500, 220, 40);
//    [selectBtn setTitle:@"购买方案" forState:UIControlStateNormal];
//    [selectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [selectBtn setBackgroundImage:[UIImage imageNamed:@"select_btn_compute"] forState:UIControlStateNormal];
//    [selectBtn addTarget:self action:@selector(selectClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:selectBtn];
    
    nextBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    nextBtn.frame = CGRectMake(545, 550, 220, 40);
    [nextBtn setTitle:@"确定" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextBtn setBackgroundImage:[UIImage imageNamed:@"select_btn_ok"] forState:UIControlStateNormal];
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
            
            NSString * strLoudongName = [dicInfo objectForKey:@"loudong_name"];
            NSString * strCengNum = [dicInfo objectForKey:@"ceng_num"];
            NSMutableArray *arrLou = [dicInfo objectForKey:@"louarr"];
             NSMutableArray *arrTemp2 = [[NSMutableArray alloc]init];
            
            for (int i = 0; i < arrLou.count ; i++) {
                NSString * strDanyuanName = [dicInfo objectForKey:@"danyuan_name"];
                NSString * strDanyuanNum = [dicInfo objectForKey:@"danyuan_num"];
                NSMutableArray *arrDanyuan = [dicInfo objectForKey:@"danyuan_arr"];
                
                NSMutableDictionary *danyuanArrData = [[NSMutableDictionary alloc]init];
                [danyuanArrData setValue:strDanyuanNum forKey:@"danyuan_num"];
                [danyuanArrData setValue:strDanyuanName forKey:@"danyuan_name"];
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
                    NSString * strRealPrice =[dicInfo objectForKey:@"realprice"];
                    NSString * strTotal =[dicInfo objectForKey:@"total"];
                    
                    NSMutableDictionary *roomArrData = [[NSMutableDictionary alloc]init];
                    [roomArrData setValue:strId forKey:@"id"];
                    [roomArrData setValue:strRoomCode forKey:@"roomcode"];
                    [roomArrData setValue:strRoomName forKey:@"roomname"];
                    [roomArrData setValue:strRoomType forKey:@"roomtype"];
                    [roomArrData setValue:strRoomStatus forKey:@"roomstatus"];
                    [roomArrData setValue:strAllAres forKey:@"allares"];
                    [roomArrData setValue:strRealAres forKey:@"realares"];
                    [roomArrData setValue:strRealPrice forKey:@"realprice"];
                    [roomArrData setValue:strTotal forKey:@"total"];
                    
                    
                    [arrTemp addObject:roomArrData];
                }
                
                [danyuanArrData setValue:arrTemp forKey:@"danyuan_arr"];
                [arrTemp2 addObject:danyuanArrData];
            }
            NSMutableDictionary *rowData = [[NSMutableDictionary alloc]init];
            [rowData setValue:strLoudongName forKey:@"loudong_name"];
            [rowData setValue:strCengNum forKey:@"ceng_num"];
            [rowData setValue:arrTemp2 forKey:@"louarr"];
            [self.dataList addObject:rowData];
        }
        
    }else{
        NSLog(@"服务端返回错误");
    }
}

-(void)analysisJson:(NSDictionary *)jsonDic
{
    NSString * strSign = [jsonDic objectForKey:@"sign"];
    int intString = [strSign intValue];
    if (intString == 1) {
        NSMutableArray *arrInfo = [jsonDic objectForKey:@"arr"];
        for (int i = 0; i < arrInfo.count ; i++) {
            NSDictionary *dicInfo = [arrInfo objectAtIndex:i];
            NSString * strRoomCode = [dicInfo objectForKey:@"roomcode"];
            NSString * strRoomName =[dicInfo objectForKey:@"roomname"];
            NSString * strRoomStatus =[dicInfo objectForKey:@"roomstatus"];
            NSString * strRoomType =[dicInfo objectForKey:@"roomtype"];
            NSString * strAllAres =[dicInfo objectForKey:@"allares"];
            NSString * strRealAres =[dicInfo objectForKey:@"realares"];
            NSString * strRealPrice =[dicInfo objectForKey:@"realprice"];
            NSString * strTotal =[dicInfo objectForKey:@"total"];
            NSString * strId =[dicInfo objectForKey:@"id"];
            
            NSMutableDictionary *rowData = [[NSMutableDictionary alloc]init];
            [rowData setValue:strRoomCode forKey:@"roomcode"];
            [rowData setValue:strRoomName forKey:@"roomname"];
            [rowData setValue:strRoomStatus forKey:@"roomstatus"];
            [rowData setValue:strRoomType forKey:@"roomtype"];
            [rowData setValue:strAllAres forKey:@"allares"];
            [rowData setValue:strRealAres forKey:@"realares"];
            [rowData setValue:strRealPrice forKey:@"realprice"];
            [rowData setValue:strTotal forKey:@"total"];
            [rowData setValue:strId forKey:@"id"];

            [self.dataList addObject:rowData];
        }
    }else{
        NSLog(@"服务端返回错误");
    }
    
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
        [self analysisJson:(NSDictionary *)responseObject];
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
        NSString * strName = [rowData objectForKey:@"loudong_name"];
        [nameArr addObject:strName];
    }
    SegmentView *segmentView = [[SegmentView alloc] init];
    segmentView.titles = nameArr;
    segmentView.delegate = self;
    self.navigationItem.titleView = segmentView;
    
    self.view.backgroundColor = kAllStatusBg;
    
    imageViewLeftBk = [[UIImageView alloc] initWithFrame:CGRectMake(0 , 0, 516, 704)];
    [imageViewLeftBk setImage:[UIImage imageNamed:@"select_left_bk"]];
    [self.view addSubview:imageViewLeftBk];
    
    imageViewRightBk = [[UIImageView alloc] initWithFrame:CGRectMake(516, 0, 297, 704)];
    [imageViewRightBk setImage:[UIImage imageNamed:@"select_right_bk"]];
    [self.view addSubview:imageViewRightBk];
    
    [self initRightView];
    
    _tableView1 = [[TSTableView alloc] initWithFrame:CGRectMake(20, self.view.frame.size.height/2 + 50, self.view.frame.size.width - 40, self.view.frame.size.height/2 - 70)];
    _tableView1.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView1.delegate = self;
    
    [self.view addSubview:_tableView1];
    
    _model1 = [[TSTableViewModel alloc] initWithTableView:_tableView1 andStyle:kTSTableViewStyleLight];
    
    //    NSArray *columns2 = [self columnsInfo2];
    //    NSArray *rows2 = [self rowsInfo2];
    //    [_model2 setColumns:columns2 andRows:rows2];
    
    NSArray *columns2 = [self columnsForBuild];
    NSArray *rows2 = [self rowsForAppDirectory];
    [_model1 setColumns:columns2 andRows:rows2];

}

- (void)receivedPushContent:(NSNotification*)notification{
    NSString *content = [notification object];
    [XWAlterview showmessage:@"新消息" subtitle:content cancelbutton:@"确定"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedPushContent:) name:@"PUSHCONTENT" object:nil];
    
    self.dataList = [[NSMutableArray alloc]init];
    louData = [[NSMutableDictionary alloc]init];
    [self getHttpInfo];
    
    
    [self initAllView];
    
}

-(void)nextBtnAction:(id)sender {
    PrintPurchasingViewController *print = [[PrintPurchasingViewController alloc]init];
    [print initData:rowHouseData];
    [self.navigationController pushViewController:print animated:NO];
}

-(void)imageClick:(UITapGestureRecognizer*)sender {
    [SJAvatarBrowser showImage:(UIImageView*)sender.view];
}


- (void)segmentView:(SegmentView *)segmentView didSelectedSegmentAtIndex:(int)index
{
    NSLog(@"点击了哪个位置---%d", index);
    louData = [self.dataList objectAtIndex:index];
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
    arrTemp = [louData objectForKey:@"louarr"];
    TSColumn * tsRow = [TSColumn columnWithDictionary:@{ @"title" : @"楼层名称", @"subtitle" : @"", @"minWidth" : @50, @"defWidth" : @50 }];
    [myMutableArray addObject:tsRow];
    for (NSMutableDictionary *danyuanArrData in arrTemp) {
        
        NSString * strNum = [danyuanArrData objectForKey:@"danyuan_num"];
        NSInteger num = [strNum integerValue];
        NSString * strName = [danyuanArrData objectForKey:@"danyuan_name"];
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc]init];
        [tempDic setObject:strName forKey:@"title"];
        NSMutableArray *arrTemp2 = [[NSMutableArray alloc]init];
        for (int i = 1; i <= num; i++) {
            NSMutableDictionary *tempDic2 = [[NSMutableDictionary alloc]init];
            NSString * strNnnn = [[NSString alloc]initWithFormat:@"%2d",i];
            [tempDic2 setObject:strNnnn forKey:@"title"];
            [tempDic2 setObject:@12 forKey:@"titleFontSize"];
            [tempDic2 setObject:@"FF006F00" forKey:@"titleColor"];
            [tempDic2 setObject:@50 forKey:@"defWidth"];
            [tempDic2 setObject:@50 forKey:@"minWidth"];
            
            [arrTemp2 addObject:tempDic2];
        }
        [tempDic setObject:arrTemp2 forKey:@"subcolumns"];
        
        TSColumn * tsRow1 = [TSColumn columnWithDictionary:tempDic];
        [myMutableArray addObject:tsRow1];
    }
    
   
    
    
//    NSArray *columns = @[
//                         [TSColumn columnWithDictionary:@{ @"title" : @"楼层名称", @"subtitle" : @"", @"minWidth" : @50, @"defWidth" : @50 }],
//                         [TSColumn columnWithDictionary:@{ @"title" : @"Attributes", @"subcolumns" : @[
//                                                                   @{ @"title" : @"File size", @"titleFontSize" : @12, @"titleColor" : @"FF006F00", @"headerHeight" : @24, @"defWidth" : @64},
//                                                                   @{ @"title" : @"Modification date", @"titleFontSize" : @12, @"headerHeight" : @24, @"defWidth" : @200},
//                                                                   @{ @"title" : @"Creation date", @"titleFontSize" : @12, @"headerHeight" : @24, @"defWidth" : @200}
//                                                                   ]}
//                          ]
//                         ];
    return [myMutableArray copy];
}

- (NSArray *)rowsForAppDirectory
{
    NSArray *dirs = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    if(!dirs || dirs.count ==0)
        return nil;
    
    NSURL *rootUrl = [dirs lastObject];
    
    return [self rowsForDirectory:[rootUrl URLByDeletingLastPathComponent]];
}

- (NSArray *)rowsForDirectory:(NSURL *)rootUrl
{
    NSError *error = nil;
    NSArray *properties = @[
                            NSURLLocalizedNameKey,
                            NSURLCreationDateKey,
                            NSURLContentModificationDateKey,
                            NSURLIsSymbolicLinkKey,
                            NSURLIsDirectoryKey,
                            NSURLIsHiddenKey,
                            NSURLFileSizeKey
                            ];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:MM  dd-MMM-YYYY"];
    
    NSArray *array = [[NSFileManager defaultManager] contentsOfDirectoryAtURL:rootUrl
                                                   includingPropertiesForKeys:properties
                                                                      options:0//(NSDirectoryEnumerationSkipsHiddenFiles)
                                                                        error:&error];
    NSMutableArray *rows = [[NSMutableArray alloc] initWithCapacity:array.count];
    for(NSURL * url in array)
    {
        NSString *localizedName = nil;
        [url getResourceValue:&localizedName forKey:NSURLLocalizedNameKey error:NULL];
        
        NSNumber *isPackage = nil;
        [url getResourceValue:&isPackage forKey:NSURLIsPackageKey error:NULL];
        
        NSNumber *isDirectory = nil;
        [url getResourceValue:&isDirectory forKey:NSURLIsDirectoryKey error:NULL];
        
        NSNumber *isHidden = nil;
        [url getResourceValue:&isHidden forKey:NSURLIsHiddenKey error:NULL];
        
        NSNumber *isSymbolic = nil;
        [url getResourceValue:&isSymbolic forKey:NSURLIsSymbolicLinkKey error:NULL];
        
        TSCell *cellFilename = [TSCell cellWithValue:localizedName];
        cellFilename.textAlignment = NSTextAlignmentLeft;
        NSArray *subrows = @[];
        if([isDirectory boolValue])
        {
            subrows = [self rowsForDirectory:url];
            cellFilename.icon = [UIImage imageNamed:@"TableViewFolderIcon"];
            
        }
        else
        {
            cellFilename.icon = [UIImage imageNamed:@"TableViewFileIcon"];
            cellFilename.textColor = [UIColor colorWithRed:0.5 green:0.4 blue:0 alpha:1];
        }
        
        if([isHidden boolValue])
        {
            cellFilename.textColor = [UIColor colorWithRed:0.5 green:0.1 blue:0.1 alpha:1];
        }
        
        if([isPackage boolValue])
        {
            cellFilename.icon = [UIImage imageNamed:@"TableViewPackageIcon"];
        }
        
        NSNumber *fileSize = nil;
        [url getResourceValue:&fileSize forKey:NSURLFileSizeKey error:NULL];
        NSString *fileSizeStr = @"";
        if(fileSize)
            fileSizeStr = [NSString stringWithFormat:@"%.2f kb",[fileSize floatValue]/1024];
        
        NSDate *creationDate = nil;
        [url getResourceValue:&creationDate forKey:NSURLCreationDateKey error:NULL];
        
        NSDate *modificationDate = nil;
        [url getResourceValue:&modificationDate forKey:NSURLContentModificationDateKey error:NULL];
        
        TSRow *row = [TSRow rowWithDictionary:@{
                                                @"cells" : @[
                                                        cellFilename,
                                                        @{@"value" : fileSizeStr},
                                                        @{@"value" : [dateFormatter stringFromDate:modificationDate]},
                                                        @{@"value" : [dateFormatter stringFromDate:creationDate]}
                                                        
                                                        ],
                                                @"subrows" : subrows
                                                }];
        [rows addObject:row];
    }
    return [NSArray arrayWithArray:rows];
}

- (TSRow *)rowForDummyFile
{
    TSRow *row = [TSRow rowWithDictionary:@{
                                            @"cells" : @[
                                                    @{@"value" : @"New File"},
                                                    @{@"value" : @"-"},
                                                    @{@"value" : @"-"},
                                                    @{@"value" : @"-"}
                                                    ],
                                            }];
    return row;
    
}



@end
