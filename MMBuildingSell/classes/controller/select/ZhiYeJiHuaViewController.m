//
//  ZhiYeJiHuaViewController.m
//  MMBuildingSell
//
//  Created by Daisy on 15/1/20.
//  Copyright (c) 2015年 Y.X. All rights reserved.
//

#import "ZhiYeJiHuaViewController.h"
#import "ZheKouViewController.h"
#import "PrintZhiYeJiHuaViewController.h"

@interface ZhiYeJiHuaViewController ()<ZheKouDelegate>

@end

@implementation ZhiYeJiHuaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    rowHouseData = [[NSMutableDictionary alloc]init];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedPushContent:) name:@"PUSHCONTENT" object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"PUSHCONTENT" object:nil];
}

- (void)receivedPushContent:(NSNotification*)notification{
    NSString *content = [notification object];
    [XWAlterview showmessage:@"新消息" subtitle:content cancelbutton:@"确定"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initHouseData:(NSMutableDictionary *)dic
{
    rowHouseData = dic;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)addZheKou:(NSMutableArray *)zhekouList
{
    NSString * strTemp = @"";
    for (NSMutableDictionary *rowData in zhekouList) {
        strTemp = [strTemp stringByAppendingString:[rowData objectForKey:@"name"]];
        strTemp = [strTemp stringByAppendingString:@";"];
    }
    if ([strTemp length] == 0) {
        strTemp = @"无优惠";
    }
    
    [self.zhekoushuomingTextField setText:strTemp];
    NSLog(@"优惠政策:%@",strTemp);
}


- (IBAction)printAction:(id)sender {
    NSString * strTemp = self.zhekoushuomingTextField.text;
    if (strTemp.length > 0) {
        if ([[strTemp substringFromIndex:(strTemp.length -1)] isEqualToString:@";"]==YES) {
            strTemp = [strTemp substringToIndex:(strTemp.length -1)];
        }
    }
    NSString * roomCodeStr = [rowHouseData objectForKey:@"roomcode"];
    
    PrintZhiYeJiHuaViewController * zhiye = [[PrintZhiYeJiHuaViewController alloc]init];
    [zhiye initDataRoomNo:roomCodeStr discount:@"" remark:strTemp totalFee:@"" mortgageFee:self.anjiezongeTextField.text mortgagePrecent:self.anjiebiliTextField.text fundFee:self.gongjijindaikuanTextField.text fundPrecent:self.gongjijinbiliTextField.text];
    [self.navigationController pushViewController:zhiye animated:YES];
}

- (IBAction)quxiaoAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)zhekouBtnAction:(id)sender {
    ZheKouViewController * zhekouView = [[ZheKouViewController alloc]init];
    zhekouView.delegate = self;
    [self.navigationController pushViewController:zhekouView animated:YES];
}
@end
