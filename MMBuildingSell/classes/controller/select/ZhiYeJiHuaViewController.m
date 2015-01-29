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
    
    //添加事件处理方法
    self.zhekoushuomingTextField.delegate = self;
    [self.zhekoushuomingTextField addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
    [self.zhekoushuomingTextField addTarget:self action:@selector(textFieldDidEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
    
    self.fangkuanzongeTextField.delegate = self;
    [self.fangkuanzongeTextField addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
    [self.fangkuanzongeTextField addTarget:self action:@selector(textFieldDidEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
    
    self.anjiezongeTextField.delegate = self;
    [self.anjiezongeTextField addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
    [self.anjiezongeTextField addTarget:self action:@selector(textFieldDidEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
    
    self.gongjijindaikuanTextField.delegate = self;
    [self.gongjijindaikuanTextField addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
    [self.gongjijindaikuanTextField addTarget:self action:@selector(textFieldDidEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
    
    self.anjiebiliTextField.delegate = self;
    [self.anjiebiliTextField addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
    [self.anjiebiliTextField addTarget:self action:@selector(textFieldDidEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
    
    self.gongjijinbiliTextField.delegate = self;
    [self.gongjijinbiliTextField addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
    [self.gongjijinbiliTextField addTarget:self action:@selector(textFieldDidEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
    
    self.anjienianxian1TextField.delegate = self;
    [self.anjienianxian1TextField addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
    [self.anjienianxian1TextField addTarget:self action:@selector(textFieldDidEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
    
    self.anjienianxian2TextField.delegate = self;
    [self.anjienianxian2TextField addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
    [self.anjienianxian2TextField addTarget:self action:@selector(textFieldDidEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
    
    self.anjienianxian3TextField.delegate = self;
    [self.anjienianxian3TextField addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
    [self.anjienianxian3TextField addTarget:self action:@selector(textFieldDidEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
    
    self.anjienianxian4TextField.delegate = self;
    [self.anjienianxian4TextField addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
    [self.anjienianxian4TextField addTarget:self action:@selector(textFieldDidEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
    
    self.anjienianxian5TextField.delegate = self;
    [self.anjienianxian5TextField addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
    [self.anjienianxian5TextField addTarget:self action:@selector(textFieldDidEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
    
    self.anjielilv1TextField.delegate = self;
    [self.anjielilv1TextField addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
    [self.anjielilv1TextField addTarget:self action:@selector(textFieldDidEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
    
    self.anjielilv2TextField.delegate = self;
    [self.anjielilv2TextField addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
    [self.anjielilv2TextField addTarget:self action:@selector(textFieldDidEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
    
    self.anjielilv3TextField.delegate = self;
    [self.anjielilv3TextField addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
    [self.anjielilv3TextField addTarget:self action:@selector(textFieldDidEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
    
    self.anjielilv4TextField.delegate = self;
    [self.anjielilv4TextField addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
    [self.anjielilv4TextField addTarget:self action:@selector(textFieldDidEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
    
    self.anjielilv5TextField.delegate = self;
    [self.anjielilv5TextField addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
    [self.anjielilv5TextField addTarget:self action:@selector(textFieldDidEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
    
    self.gongjijinlilv1TextField.delegate = self;
    [self.gongjijinlilv1TextField addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
    [self.gongjijinlilv1TextField addTarget:self action:@selector(textFieldDidEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
    
    self.gongjijinlilv2TextField.delegate = self;
    [self.gongjijinlilv2TextField addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
    [self.gongjijinlilv2TextField addTarget:self action:@selector(textFieldDidEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
    
    self.gongjijinlilv3TextField.delegate = self;
    [self.gongjijinlilv3TextField addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
    [self.gongjijinlilv3TextField addTarget:self action:@selector(textFieldDidEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
    
    self.gongjijinlilv4TextField.delegate = self;
    [self.gongjijinlilv4TextField addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
    [self.gongjijinlilv4TextField addTarget:self action:@selector(textFieldDidEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
    
    self.gongjijinlilv5TextField.delegate = self;
    [self.gongjijinlilv5TextField addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
    [self.gongjijinlilv5TextField addTarget:self action:@selector(textFieldDidEndEditing:) forControlEvents:UIControlEventEditingDidEnd];

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
    NSString * strTotal = [rowHouseData objectForKey:@"total"];
    [self.fangkuanzongeTextField setText:strTotal];
    
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

/**
 * 输入文本结束后，关闭键盘，并恢复视图位置
 */
- (void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];

    self.view.frame =CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height);
    
}


/**
 * 开始输入文本时，将当前视图向上移动，以显示键盘
 */
-(void)textFieldDidBeginEditing:(UITextField *)textField	 {
    
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 32 + 44 - (self.view.frame.size.height - 352 - 216);//键盘高度216
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
        self.view.frame = CGRectMake(0, -offset, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
    
}

//当用户按下return键或者按回车键，keyboard消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
