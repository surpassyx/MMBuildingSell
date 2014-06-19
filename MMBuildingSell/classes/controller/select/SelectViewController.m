//
//  SelectViewController.m
//  MMBuildingSell
//
//  Created by 3G组 on 13-10-14.
//  Copyright (c) 2013年 Y.X. All rights reserved.
//

#import "SelectViewController.h"
#import "SegmentView.h"
#import "HouseStateCell.h"
#import "HouseInfoCell.h"
#import "SJAvatarBrowser.h"
#import <QuartzCore/QuartzCore.h>
#import "AFNetworking.h"
#import "UIViewController+CWPopup.h"
#import "CalculatorViewController.h"
#import "FangDaiViewController.h"



#import "HeadView.h"
#import "TimeView.h"
#import "MyCell.h"
#import "MeetModel.h"




@interface SelectViewController () <SegmentViewDelegate,QCheckBoxDelegate,UITableViewDataSource,UITableViewDelegate,MyCellDelegate>

@property (nonatomic,strong) UIView *myHeadView;
@property (nonatomic,strong) UITableView *myTableView;
@property (nonatomic,strong) TimeView *timeView;
@property (nonatomic,strong) NSMutableArray *meets;
@property (nonatomic,strong) NSMutableArray *currentTime;

@end

@implementation SelectViewController
@synthesize dataList;


-(void)initData
{
    self.meets=[NSMutableArray array];
    self.currentTime=[NSMutableArray array];
    for(int i=0;i<10;i++){
        
        MeetModel *meet=[[MeetModel alloc]init];
        meet.meetRoom=[NSString stringWithFormat:@"%03d",i];
        int currentTime=i*30+520;
        NSString *time=[NSString stringWithFormat:@"%d:%02d",currentTime/60,currentTime%60];
        meet.meetTime=time;

        [self.meets addObject:meet];
    }
    
}

-(void)initHouseTable
{
    [self initData];
    
    //40, 142, 400, 850
    UIView *tableViewHeadView=[[UIView alloc]initWithFrame:CGRectMake(40, 142, kCount*kWidth, kHeight)];
    self.myHeadView=tableViewHeadView;
    
    for(int i=0;i<kCount;i++){
        
        HeadView *headView=[[HeadView alloc]initWithFrame:CGRectMake(i*kWidth, 0, kWidth, kHeight)];
        headView.num=[NSString stringWithFormat:@"%03d",i];
        headView.detail=@"";
        headView.backgroundColor=[UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
        [tableViewHeadView addSubview:headView];
    }
    
    UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.myHeadView.frame.size.width, 460) style:UITableViewStylePlain];
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.bounces=NO;
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.myTableView=tableView;
    tableView.backgroundColor=[UIColor whiteColor];
    
    UIScrollView *myScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(70, 100, 400, 460)];
    [myScrollView addSubview:tableView];
    myScrollView.bounces=NO;
    myScrollView.contentSize=CGSizeMake(self.myHeadView.frame.size.width,0);
    [self.view addSubview:myScrollView];
    
    self.timeView=[[TimeView alloc]initWithFrame:CGRectMake(25, 150, 40, 410)];
    [self.view addSubview:self.timeView];


}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return kCount-1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier=@"cell";
    
    MyCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell==nil){
        
        cell=[[MyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.delegate=self;
        cell.backgroundColor=[UIColor grayColor];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    [self.currentTime removeAllObjects];
    for(MeetModel *model in self.meets){
        
//        NSArray *timeArray=[ model.meetTime componentsSeparatedByString:@":"];
//        int min=[timeArray[0] intValue]*60+[timeArray[1] intValue];
//        int currentTime=indexPath.row*30+510;
//        if(min>currentTime&&min<currentTime+30){
//            [self.currentTime addObject:model];
//        }
        [self.currentTime addObject:model];
    }
    cell.index=indexPath.row;
    cell.currentTime=self.currentTime;
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return self.myHeadView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return kHeight;
}
-(void)myHeadView:(HeadView *)headView point:(CGPoint)point
{
    CGPoint myPoint= [self.myTableView convertPoint:point fromView:headView];
    
    [self convertRoomFromPoint:myPoint];
}
-(void)convertRoomFromPoint:(CGPoint)ponit
{
    NSString *roomNum=[NSString stringWithFormat:@"%03d",(int)(ponit.x)/kWidth];
    int currentTime=(ponit.y-kHeight-kHeightMargin)*30.0/(kHeight+kHeightMargin)+510;
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"clicked room" message:[NSString stringWithFormat:@"time :%@ room :%@",[NSString stringWithFormat:@"%d:%02d",currentTime/60,currentTime%60],roomNum] delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:@"ok", nil];
    [alert show];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY= self.myTableView.contentOffset.y;
    CGPoint timeOffsetY=self.timeView.timeTableView.contentOffset;
    timeOffsetY.y=offsetY;
    self.timeView.timeTableView.contentOffset=timeOffsetY;
    if(offsetY==0){
        self.timeView.timeTableView.contentOffset=CGPointZero;
    }
}


-(void)initRightView
{
    imageView=[[UIImageView alloc] initWithFrame:CGRectMake(555, 110 - 46, 210, 165)];
    [imageView setImage:[UIImage imageNamed:@"huxingtu.jpg"]];
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick:)];
    [imageView addGestureRecognizer:singleTap];
    
    [self.view addSubview:imageView];
    
    showLabel = [[UILabel alloc]initWithFrame:CGRectMake(545, 300 - 46, 220, 30)];
    showLabel.text = @"1栋2单元1102 113.30平方米";
    [self.view addSubview:showLabel];
    
    danjiaLabel = [[UILabel alloc]initWithFrame:CGRectMake(545, 285, 220, 30)];
    danjiaLabel.text = @"单价：1万";
    [self.view addSubview:danjiaLabel];
    
    totalLabel = [[UILabel alloc]initWithFrame:CGRectMake(545, 315, 220, 30)];
    totalLabel.text = @"总价：65万";
    [self.view addSubview:totalLabel];
    
//    freeLabel = [[UILabel alloc]initWithFrame:CGRectMake(545, 345, 105, 30)];
//    freeLabel.text = @"优惠后单价：";
//    [self.view addSubview:freeLabel];
//    
//    freeFieldText = [[UITextField alloc]initWithFrame:CGRectMake(650, 345, 60, 30)];
//    [freeFieldText setKeyboardType:UIKeyboardTypeNumberPad];
//    freeFieldText.borderStyle = UITextBorderStyleLine;
//    [self.view addSubview:freeFieldText];
//    
//    freeLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(710, 345, 50, 30)];
//    freeLabel2.text = @"万";
//    [self.view addSubview:freeLabel2];
    
//    freeJisuanBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    freeJisuanBtn.frame = CGRectMake(730, 345, 38, 35);
////    [freeJisuanBtn setTitle:@"计算" forState:UIControlStateNormal];
//    [freeJisuanBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [freeJisuanBtn setBackgroundImage:[UIImage imageNamed:@"item_calculator_btn"] forState:UIControlStateNormal];
//    [freeJisuanBtn addTarget:self action:@selector(btnPresentPopup:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:freeJisuanBtn];
    
//    freeTotalLabel = [[UILabel alloc]initWithFrame:CGRectMake(545, 380, 105, 30)];
//    freeTotalLabel.text = @"优惠后总价：";
//    [self.view addSubview:freeTotalLabel];
//    
//    freeTotalFieldText = [[UITextField alloc]initWithFrame:CGRectMake(650, 380, 60, 30)];
//    [freeTotalFieldText setKeyboardType:UIKeyboardTypeNumberPad];
//    freeTotalFieldText.borderStyle = UITextBorderStyleLine;
//    [self.view addSubview:freeTotalFieldText];
    
//    freeTotalLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(710, 380, 50, 30)];
//    freeTotalLabel2.text = @"万";
//    [self.view addSubview:freeTotalLabel2];
    
    freeTotalJisuanBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    freeTotalJisuanBtn.frame = CGRectMake(545, 380, 38, 35);
//    [freeTotalJisuanBtn setTitle:@"计算" forState:UIControlStateNormal];
    [freeTotalJisuanBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [freeTotalJisuanBtn setBackgroundImage:[UIImage imageNamed:@"item_calculator_btn"] forState:UIControlStateNormal];
    [freeTotalJisuanBtn addTarget:self action:@selector(btnPresentPopup:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:freeTotalJisuanBtn];

    
//    okLabel = [[UILabel alloc]initWithFrame:CGRectMake(545, 350, 220, 30)];
//    okLabel.text = @"成交：";
//    [self.view addSubview:okLabel];
//    
//    okLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(595, 350, 220, 30)];
//    okLabel2.text = @"65万";
//    [self.view addSubview:okLabel2];
    
    
    selectBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    selectBtn.frame = CGRectMake(545, 450, 220, 40);
    [selectBtn setTitle:@"购买方案" forState:UIControlStateNormal];
    //    [selectBtn setTitle:@"计算" forState:UIControlStateHighlighted];
    [selectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [selectBtn setBackgroundImage:[UIImage imageNamed:@"select_btn_compute"] forState:UIControlStateNormal];
    [selectBtn addTarget:self action:@selector(selectClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selectBtn];
    
//    jisuanBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    jisuanBtn.frame = CGRectMake(545, 470, 220, 40);
//    [jisuanBtn setTitle:@"计算" forState:UIControlStateNormal];
//    //    [jisuanBtn setTitle:@"计算" forState:UIControlStateHighlighted];
//    [jisuanBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [jisuanBtn setBackgroundImage:[UIImage imageNamed:@"select_btn_compute"] forState:UIControlStateNormal];
//    [jisuanBtn addTarget:self action:@selector(jisuanBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:jisuanBtn];
    
    nextBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    nextBtn.frame = CGRectMake(545, 550, 220, 40);
    [nextBtn setTitle:@"确定" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextBtn setBackgroundImage:[UIImage imageNamed:@"select_btn_ok"] forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(nextBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];

    
}


-(void)initGridView
{
    int nDanYuanNum = 2; //单元个数
    int nHuShu = 3;//每单元每层楼户数
    for (int i = 0 ; i < nDanYuanNum; i++) {
        UIImageView *imageViewHead = [[UIImageView alloc] initWithFrame:CGRectMake(40 + 74*3 * i, 44, 74*3, 50)];
        [imageViewHead setImage:[UIImage imageNamed:@"select_head_2.png"]];
        [self.view addSubview:imageViewHead];
        UILabel * textLabel = [[UILabel alloc]initWithFrame:CGRectMake( 130 + 74* 3 * i, 53, 35*3, 30)];
        textLabel.text = [[NSString alloc]initWithFormat:@"%d单元",i+1];
        [self.view addSubview:textLabel];
        
    }
    
    for (int i = 0 ; i < 6; i++) {
        UIImageView *imageViewHead = [[UIImageView alloc] initWithFrame:CGRectMake(40 + 74 * i, 94, 74, 50)];
        [imageViewHead setImage:[UIImage imageNamed:@"select_head_4.png"]];
        [self.view addSubview:imageViewHead];
        
        UILabel * textLabel = [[UILabel alloc]initWithFrame:CGRectMake( 65 + 74 * i, 102, 35, 30)];
        if (i < 3) {
            textLabel.text = [[NSString alloc]initWithFormat:@"A%d",i];
        } else {
            textLabel.text = [[NSString alloc]initWithFormat:@"A%d",i%3];
        }
        
        [self.view addSubview:textLabel];
    }
    
    gridView = [[MSGridView alloc] initWithFrame:CGRectMake(40, 142, 400, 850)];
    gridView.gridViewDelegate = self;
    gridView.gridViewDataSource = self;
    [gridView setInnerSpacing:CGSizeMake(50, 0)];
    [self.view addSubview:gridView];


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
            NSString * strRoomCode = [dicInfo objectForKey:@"froomcode"];
            NSString * strRoomName =[dicInfo objectForKey:@"froomname"];
            NSString * strRoomStatus =[dicInfo objectForKey:@"froomstatus"];
            NSString * strRoomType =[dicInfo objectForKey:@"froomtype"];
            NSString * strAllAres =[dicInfo objectForKey:@"fallares"];
            NSString * strRealAres =[dicInfo objectForKey:@"frealares"];
            NSString * strRealPrice =[dicInfo objectForKey:@"frealprice"];
            NSString * strTotal =[dicInfo objectForKey:@"ftotal"];
            NSString * strId =[dicInfo objectForKey:@"id"];
            
            
        //            NSString * strUrlpic = [dicInfo objectForKey:@"urlpic"];
        //            NSString * strType = [dicInfo objectForKey:@"Type"];
        //
            NSMutableDictionary *rowData = [[NSMutableDictionary alloc]init];
            [rowData setValue:strRoomCode forKey:@"froomcode"];
            [rowData setValue:strRoomName forKey:@"froomname"];
            [rowData setValue:strRoomStatus forKey:@"froomstatus"];
            [rowData setValue:strRoomType forKey:@"froomtype"];
            [rowData setValue:strAllAres forKey:@"fallares"];
            [rowData setValue:strRealAres forKey:@"frealares"];
            [rowData setValue:strRealPrice forKey:@"frealprice"];
            [rowData setValue:strTotal forKey:@"ftotal"];
            [rowData setValue:strId forKey:@"id"];
            
        //            [rowData setValue:strDescription forKey:@"Description"];
        //            [rowData setValue:strConnect forKey:@"Connect"];
        //            [rowData setValue:strUrlpic forKey:@"urlpic"];
        //            [rowData setValue:strType forKey:@"Type"];
            [self.dataList addObject:rowData];
        }
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
    self.view.userInteractionEnabled = YES;
}

-(void)getHttpInfo
{
    //http://www.ykhome.cn/myhome/gettype.php?&fenterisecode=P0001&finstallment=01
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * strUrl = [[NSString alloc]initWithFormat:@"http://www.ykhome.cn/myhome/gettype.php?&fenterisecode=%@&finstallment=%@",[userDefaults objectForKey:@"enterpriseCode"],@"01"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:strUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [self analysisJson:(NSDictionary *)responseObject];
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
//    [self initGridView];
    
    [self initHouseTable];
    
//    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPopup)];
//    tapRecognizer.numberOfTapsRequired = 1;
//    tapRecognizer.delegate = self;
//    [self.view addGestureRecognizer:tapRecognizer];
//    self.useBlurForPopup = YES;

    
    
    
}

//-(void)jisuanBtnAction:(id)sender {
//    float rel = 65.0 - [freeFieldText.text floatValue];
//    okLabel2.text = [[NSString alloc]initWithFormat:@"%.4f万",rel];
//}

-(void)nextBtnAction:(id)sender {
    PrintPurchasingViewController *print = [[PrintPurchasingViewController alloc]init];
    [self.navigationController pushViewController:print animated:NO];
}

-(void)imageClick:(UITapGestureRecognizer*)sender {
    [SJAvatarBrowser showImage:(UIImageView*)sender.view];
}


- (void)segmentView:(SegmentView *)segmentView didSelectedSegmentAtIndex:(int)index
{
    NSLog(@"点击了哪个位置---%d", index);
}

#pragma mark gridView delegate methods

#pragma mark gridView datasource methods


-(MSGridViewCell *)cellForIndexPath:(NSIndexPath*)indexPath inGridWithIndexPath:(NSIndexPath *)gridIndexPath;
{
    
    static NSString *reuseIdentifier = @"cell";
    MSGridViewCell *cell = [MSGridView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if(cell == nil) {
        cell = [[MSGridViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:reuseIdentifier tittleContent:@"201"];
    }
    
    cell.backgroundColor = [UIColor whiteColor];
//    NSLog(@"%d-%d",indexPath.section,indexPath.row);
    if (indexPath.row == 2 && indexPath.section == 1) {
        cell.backgroundColor = [UIColor colorWithHue:([indexPath indexAtPosition:0]*3+[indexPath indexAtPosition:1])/9.0f saturation:1 brightness:1 alpha:1];
    }
    
    if (indexPath.row == 4 && indexPath.section == 3) {
        cell.backgroundColor = [UIColor colorWithHue:([indexPath indexAtPosition:0]*3+[indexPath indexAtPosition:1])/9.0f saturation:1 brightness:1 alpha:1];
    }
    
    cell.layer.borderColor = [UIColor blackColor].CGColor;
    cell.layer.borderWidth = 1;
    return cell;
    
}

// Returns the number of supergrid rows
-(NSUInteger)numberOfGridRows
{
    return 1;
}

// Returns the number of supergrid rows
-(NSUInteger)numberOfGridColumns
{
    return 1;
}


-(NSUInteger)numberOfColumnsForGridAtIndexPath:(NSIndexPath*)indexPath
{
    return 6;
}

-(NSUInteger)numberOfRowsForGridAtIndexPath:(NSIndexPath*)indexPath
{
    return 10;
}


-(void)didSelectCellWithIndexPath:(NSIndexPath*) indexPath
{
    
    int index = [indexPath indexAtPosition:2]*3+[indexPath indexAtPosition:3];
    NSLog(@"index: %i",index);
    
    [[[UIAlertView alloc] initWithTitle:@"Tapped" message:[NSString stringWithFormat:@"You tapped cell %i in grid (%i,%i)",index,[indexPath indexAtPosition:0],[indexPath indexAtPosition:1]] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
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
//    CalculatorViewController *samplePopupViewController = [[CalculatorViewController alloc] initWithNibName:@"CalculatorViewController" bundle:nil];
    FangDaiViewController *samplePopupViewController = [[FangDaiViewController alloc] initWithNibName:@"FangDaiViewController" bundle:nil];
    [samplePopupViewController setCurHouseInfo:@"8000" ares:@"90cc"];
    [self.navigationController pushViewController:samplePopupViewController animated:NO];
//    [self presentPopupViewController:samplePopupViewController animated:YES completion:^(void) {
//        NSLog(@"popup view presented");
//    }];
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
