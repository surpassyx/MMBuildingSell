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

@interface SelectViewController () <SegmentViewDelegate,QCheckBoxDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *myTableView;

@end

@implementation SelectViewController
@synthesize dataList;


-(void)initHouseTable
{
    self.dataList = [[NSMutableArray alloc]init];
    self.myTableView=[[UITableView alloc]initWithFrame:CGRectMake(40, 50, 400, 600) style:UITableViewStylePlain];
    self.myTableView.delegate=self;
    self.myTableView.dataSource=self;
    self.myTableView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.myTableView];
    nCurSelected = 0;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"HouseCellIdentifier";
    HouseCell *cell = (HouseCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"HouseCell" owner:self options:nil];
        cell = [array objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    }
    NSMutableDictionary *rowData = [[NSMutableDictionary alloc]init];
    rowData = [self.dataList objectAtIndex:indexPath.row];
    [cell.roomCode setText:[rowData objectForKey:@"roomcode"]];
    [cell.roomName setText:[rowData objectForKey:@"roomname"]];
    [cell.roomType setText:[rowData objectForKey:@"roomtype"]];
    [cell.allAres setText:[rowData objectForKey:@"allares"]];
    [cell.roomState setText:[rowData objectForKey:@"roomstatus"]];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    nCurSelected = indexPath.row;
    NSMutableDictionary *rowData = [[NSMutableDictionary alloc]init];
    rowData = [self.dataList objectAtIndex:indexPath.row];
    rowHouseData = rowData;
    roomNameLabel.text = [rowData objectForKey:@"roomname"];
    NSString * strRoomStatus = [rowData objectForKey:@"roomstatus"];
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
    
    NSString * strRoomType = [rowData objectForKey:@"roomtype"];
    strRoomType = [@"房间类型：" stringByAppendingString:strRoomType];
    roomTypeLabel.text = strRoomType;
    
    NSString * strAllAres = [rowData objectForKey:@"allares"];
    strAllAres = [@"建筑面积：" stringByAppendingString:strAllAres];
    strAllAres = [strAllAres stringByAppendingString:@" ㎡"];
    allAresLabel.text = strAllAres;
    
    NSString * strRealAres = [rowData objectForKey:@"realares"];
    strRealAres = [@"室内面积：" stringByAppendingString:strRealAres];
    strRealAres = [strRealAres stringByAppendingString:@" ㎡"];
    realAresLabel.text = strRealAres;
    
    NSString * strRealPrice = [rowData objectForKey:@"realprice"];
    strRealPrice = [@"建筑单价：" stringByAppendingString:strRealPrice];
    strRealPrice = [strRealPrice stringByAppendingString:@" 万元/㎡"];
    realPriceLabel.text = strRealPrice;
    
//    NSString * strAllPriceSS = @"";
//    strAllPriceSS = [strAllPriceSS stringByAppendingString:[rowData objectForKey:@"allprice"]];
//    strAllPriceSS = [@"套内单价：" stringByAppendingString:strAllPriceSS];
//    strAllPriceSS = [strAllPriceSS stringByAppendingString:@" 万元"];
//    danjiaLabel.text = strAllPriceSS;
    
    NSString * strTotal = [rowData objectForKey:@"total"];
    strTotal = [@"标准总价：" stringByAppendingString:strTotal];
    strTotal = [strTotal stringByAppendingString:@" 万元"];
    totalLabel.text = strTotal;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}


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
    
    
    selectBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    selectBtn.frame = CGRectMake(545, 500, 220, 40);
    [selectBtn setTitle:@"购买方案" forState:UIControlStateNormal];
    [selectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [selectBtn setBackgroundImage:[UIImage imageNamed:@"select_btn_compute"] forState:UIControlStateNormal];
    [selectBtn addTarget:self action:@selector(selectClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selectBtn];
    
    nextBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    nextBtn.frame = CGRectMake(545, 550, 220, 40);
    [nextBtn setTitle:@"确定" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextBtn setBackgroundImage:[UIImage imageNamed:@"select_btn_ok"] forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(nextBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];

    
}


-(void)analysisJson:(NSDictionary *)jsonDic
{
    //    NSError *error;
    //    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:date options:NSJSONReadingMutableLeaves error:&error];
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
        [self.myTableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self getHttpInfo];
    SegmentView *segmentView = [[SegmentView alloc] init];
    segmentView.titles = @[@"1栋", @"2栋", @"3栋", @"4栋", @"5栋", @"6栋", @"7栋"];
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
    
    [self initHouseTable];
    
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

- (void)selectClicked:(id)sender {
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"一次性购房", @"公积金贷款", @"商业贷款", @"混合贷款",nil];
    NSArray * arrImage = [[NSArray alloc] init];
    arrImage = [NSArray arrayWithObjects:[UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], nil];
    if(dropDown == nil) {
        CGFloat f = 200;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arr :arrImage :@"down"];
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }
}

- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    [self rel];
}

-(void)rel{
    //    [dropDown release];
    dropDown = nil;
}

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


@end
