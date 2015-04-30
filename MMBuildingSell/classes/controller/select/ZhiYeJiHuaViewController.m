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
#import "BuyViewController.h"

@interface ZhiYeJiHuaViewController ()<ZheKouDelegate>

@end

@implementation ZhiYeJiHuaViewController

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"房价计算";
    
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    [cancelItem setTintColor:[UIColor grayColor]];
    self.navigationItem.leftBarButtonItem = cancelItem;
    
    //添加事件处理方法
    self.zhekoushuomingTextField.delegate = self;
    [self.zhekoushuomingTextField addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
    [self.zhekoushuomingTextField addTarget:self action:@selector(textFieldDidEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
    
//    self.fangkuanzongeTextField.delegate = self;
//    [self.fangkuanzongeTextField addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
//    [self.fangkuanzongeTextField addTarget:self action:@selector(textFieldDidEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
    
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
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedPushContent:) name:@"PUSHCONTENT" object:nil];
    self.fangkuanzongeLabel.text = strTotalFangKuan;
}
//
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"PUSHCONTENT" object:nil];
//}
//
//- (void)receivedPushContent:(NSNotification*)notification{
//    NSString *content = [notification object];
//    [XWAlterview showmessage:@"新消息" subtitle:content cancelbutton:@"确定"];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initHouseData:(NSMutableDictionary *)dic
{
    rowHouseData = [[NSMutableDictionary alloc]init];
    rowHouseData = [dic copy];
    roomcode = [rowHouseData objectForKey:@"id"];
    NSLog(@"rowHouseData=%@", [rowHouseData debugDescription]);
    strTotalFangKuan = [rowHouseData objectForKey:@"total"];
    
    NSUserDefaults * myDefaults = [NSUserDefaults standardUserDefaults];
    [myDefaults setObject:[rowHouseData objectForKey:@"allares"] forKey:@"allares"];
    [myDefaults synchronize];
//    [self.fangkuanzongeLabel setText:strTotal];
    
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
    NSString * strTotal =  self.fangkuanzongeLabel.text;
    float fTotal = 0;
    if ([strTotal length] > 0) {
        fTotal = [strTotal floatValue];
    }
    strZheKouNo = @"";
    for (NSMutableDictionary *rowData in zhekouList) {
        strTemp = [strTemp stringByAppendingString:[rowData objectForKey:@"name"]];
        strTemp = [strTemp stringByAppendingString:@";"];
        NSString * calculatMethod = [rowData objectForKey:@"calculatMethod"];
        NSString * discount = [rowData objectForKey:@"discount"];
        NSString * fee = [rowData objectForKey:@"fee"];
        NSString * zhekouno = [rowData objectForKey:@"no"];
        strZheKouNo = [zhekouno stringByAppendingString:@","];
        strZheKouNo = [zhekouno stringByAppendingString:zhekouno];
        float fdiscount = [discount floatValue]/100;
        float ffee = [fee floatValue];
        
        if ([calculatMethod isEqualToString:@"1"]) {
            //减点
            fTotal = fTotal - (fTotal * fdiscount);
        }else if ([calculatMethod isEqualToString:@"2"]) {
            //打折
            fTotal = fTotal * fdiscount;
        }else if ([calculatMethod isEqualToString:@"3"]) {
            //总价优惠
            fTotal = fTotal - ffee;
        }else if ([calculatMethod isEqualToString:@"4"]) {
            //单价优惠
            
            NSString * strAre = [[NSUserDefaults standardUserDefaults] objectForKey:@"allares"];
            if ([strAre length] > 0) {
                fTotal = fTotal - ffee * [strAre floatValue];
            }
            
        }
        
    }
    if ([strTemp length] == 0) {
        strTemp = @"无优惠";
    }
    
    if ([strTotal length] > 0) {
        float zhekouF = fTotal / [strTotal floatValue] * 100;
        [self.zhekouBtn setTitle:[[NSString alloc]initWithFormat:@"%2.0f%%",zhekouF] forState:UIControlStateNormal];
    }
    
    
    strTotalFangKuan = [[NSString alloc]initWithFormat:@"%.0f",fTotal];
    
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
//    NSString * roomCodeStr = [rowHouseData objectForKey:@"roomcode"];
    NSString *strDiscount = self.zhekouBtn.titleLabel.text;
    if ([strDiscount isEqualToString:@"点击设置折扣方案"]) {
        strDiscount = @"0";
    }
    NSRange foundObj=[strDiscount rangeOfString:@"%" options:NSCaseInsensitiveSearch];
    if(foundObj.length>0) {
        strDiscount = [strDiscount substringToIndex:foundObj.location];
    }
    
    if ([self.anjiebiliTextField.text length] == 0 ) {
        self.anjiebiliTextField.text = @"0";
    }
    
    if ([self.anjiezongeTextField.text length] == 0 ) {
        self.anjiezongeTextField.text = @"0";
    }
    
    if ([self.gongjijindaikuanTextField.text length] == 0 ) {
        self.gongjijindaikuanTextField.text = @"0";
    }
    
    if ([self.gongjijinbiliTextField.text length] == 0 ) {
        self.gongjijinbiliTextField.text = @"0";
    }
    
    if ([self.anjiebiliTextField.text length] > 0 && [self.anjiezongeTextField.text length] > 0 && [self.gongjijindaikuanTextField.text length] > 0 && [self.gongjijinbiliTextField.text length]) {
        PrintZhiYeJiHuaViewController * zhiye = [[PrintZhiYeJiHuaViewController alloc]init];
        [zhiye initDataRoomNo:roomcode discount:strDiscount remark:strTemp totalFee:strTotalFangKuan mortgageFee:self.anjiezongeTextField.text mortgagePrecent:self.anjiebiliTextField.text fundFee:self.gongjijindaikuanTextField.text fundPrecent:self.gongjijinbiliTextField.text];
        [self.navigationController pushViewController:zhiye animated:YES];
    }else{
        XWAlterview *alter=[[XWAlterview alloc]initWithTitle:@"提示" contentText:@"数据填写不全" leftButtonTitle:@"确定" rightButtonTitle:@"取消"];
        alter.rightBlock=^()
        {
            //        NSLog(@"右边按钮被点击");
        };
        alter.leftBlock=^()
        {
            //        NSLog(@"左边按钮被点击");
        };
        alter.dismissBlock=^()
        {
            //        NSLog(@"窗口即将消失");
        };
        [alter show];

    }
    
    
}

- (IBAction)quxiaoAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)zhekouBtnAction:(id)sender {
    ZheKouViewController * zhekouView = [[ZheKouViewController alloc]init];
    zhekouView.delegate = self;
    [self.navigationController pushViewController:zhekouView animated:YES];
}

- (IBAction)rengouAction:(id)sender {
    
    NSString * strTemp = self.zhekoushuomingTextField.text;
    if (strTemp.length > 0) {
        if ([[strTemp substringFromIndex:(strTemp.length -1)] isEqualToString:@";"]==YES) {
            strTemp = [strTemp substringToIndex:(strTemp.length -1)];
        }
    }
    
    NSString *strDiscount = self.zhekouBtn.titleLabel.text;
    if ([strDiscount isEqualToString:@"点击设置折扣方案"]) {
        strDiscount = @"0";
    }
    NSRange foundObj=[strDiscount rangeOfString:@"%" options:NSCaseInsensitiveSearch];
    if(foundObj.length>0) {
        strDiscount = [strDiscount substringToIndex:foundObj.location];
    }


    
    BuyViewController * buyView = [[BuyViewController alloc]init];
    [buyView initWithRoomCode:roomcode fangjianjiegou:@"" mianji:@"" danjia:@"" zongjia:strTotalFangKuan zuihouzhekou:strDiscount zhekoushuoming:strTemp chengjiaodanjia:@"" chengjiaozongjia:@"" zhekouNo:strZheKouNo];
    [self.navigationController pushViewController:buyView animated:YES];
}

/**
 * 输入文本结束后，关闭键盘，并恢复视图位置
 */
- (void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];

    self.view.frame =CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height);
    //strTotalFangKuan
    float fTotalFangKuan = [strTotalFangKuan floatValue];
    if (textField == self.anjiebiliTextField) {
        float fAnjieBili = [self.anjiebiliTextField.text floatValue] /100;
        float fAnJieZongE = fTotalFangKuan * fAnjieBili;
        self.anjiezongeTextField.text = [[NSString alloc]initWithFormat:@"%.2f",fAnJieZongE];
    }else if (textField == self.anjiezongeTextField){
        float fAnJieZongE = [self.anjiezongeTextField.text floatValue];
        float fAnjieBili =  fAnJieZongE / fTotalFangKuan * 100;
        self.anjiebiliTextField.text = [[NSString alloc]initWithFormat:@"%.2f",fAnjieBili];
    }else if (textField == self.gongjijinbiliTextField){
        float fGongJiJinBili = [self.gongjijinbiliTextField.text floatValue] /100;
        float fGongJiJinZongE = fTotalFangKuan * fGongJiJinBili;
        self.gongjijindaikuanTextField.text = [[NSString alloc]initWithFormat:@"%.2f",fGongJiJinZongE];
    }else if (textField == self.gongjijindaikuanTextField){
        float fGongJiJinZongE = [self.gongjijindaikuanTextField.text floatValue];
        float fGongJiJinBili =  fGongJiJinZongE / fTotalFangKuan * 100;
        self.gongjijinbiliTextField.text = [[NSString alloc]initWithFormat:@"%.2f",fGongJiJinBili];
    }
    
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
