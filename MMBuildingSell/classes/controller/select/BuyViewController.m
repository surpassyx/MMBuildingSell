//
//  BuyViewController.m
//  MMBuildingSell
//
//  Created by Daisy on 15/3/18.
//  Copyright (c) 2015年 Y.X. All rights reserved.
//

#import "BuyViewController.h"

@interface BuyViewController ()
{
    MBProgressHUD *waitHUD;
}

@end

@implementation BuyViewController

-(void)initWithRoomCode:(NSString *)roomCode
         fangjianjiegou:(NSString *)fangjianjiegou
                 mianji:(NSString *)mianji
                 danjia:(NSString *)danjia
                zongjia:(NSString *)zongjia
           zuihouzhekou:(NSString *)zuihouzhekou
         zhekoushuoming:(NSString *)zhekoushuoming
        chengjiaodanjia:(NSString *)chengjiaodanjia
       chengjiaozongjia:(NSString *)chengjiaozongjia
{
    strRoomCode = roomCode;
    strFangJianJieGou = fangjianjiegou;
    strMianJi = mianji;
    strDanJia = danjia;
    strZongJia = zongjia;
    strZuiHouZheKou = zuihouzhekou;
    strZheKouShuoMing = zhekoushuoming;
    strChengJiaoDanJia = chengjiaodanjia;
    strChengJiaoZongJia = chengjiaozongjia;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"认购签约";
}

-(void)viewDidAppear:(BOOL)animated
{
    waitHUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:waitHUD];
    waitHUD.dimBackground = YES;
    waitHUD.labelText = @"正在制定置业计划书，请稍后";
    [waitHUD show:YES];
    
    [self getHttpInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getHttpInfo
{
    
    NSString * strUrl = [[NSString alloc]initWithFormat:@"action=16&roomNo=%@&discount=%@&remark=%@&totalFee=%@&mortgageFee=%@&mortgagePrecent=%@&fundFee=%@&fundPrecent=%@",strRoomCode,strZuiHouZheKou,strZheKouShuoMing,strZongJia,@"0",@"0",@"0",@"0"];
    NSString * hexUrl  = [Utility hexStringFromString:strUrl];
    NSLog(@"zhiyejihuaUrl=%@",API_BASE_URL(hexUrl));
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:API_BASE_URL(hexUrl) parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        //{"sign":"1","roomcode":"沈阳恒大名都二期-住宅-B2-1-601","layoutname":"A","typename":"住宅","structurename":"一室一厅一卫","orientation":"南北","sumfee":"900000.00","buildfee":"9375.00","sleevefee":"11250.00","pricemodename":"建筑面积 ","buildarea":"96.00","sleevearea":"80.00","discount":"96.71","remark":"领导特批;内部折扣","totalfee":"870400","firstpay":"435200","mortgagefee":"174080","mortgageprecent":"20","fundfee":"261120","fundprecent":"30","arr":[{"year":"5","mFee":"3496.48","fFee":"5121.35","sumFee":"8617.83"},{"year":"10","mFee":"2084.58","fFee":"2991.61","sumFee":"5076.19"},{"year":"15","mFee":"1643.56","fFee":"2317.92","sumFee":"3961.48"},{"year":"20","mFee":"1445.26","fFee":"2008.82","sumFee":"3454.08"}]}
        
        NSString * strSign = [responseObject objectForKey:@"sign"];
        int intString = [strSign intValue];
        if (intString == 1) {
            NSString * roomcode = [responseObject objectForKey:@"roomcode"];
            strRoomName = roomcode;
            [self.roomNameLabel setText:strRoomName];
            NSString * structurename = [responseObject objectForKey:@"structurename"];
            self.fangjianjiegouLabel.text = structurename;
   
            NSString * sumfee = [responseObject objectForKey:@"sumfee"];
            self.zongjiaLabel.text = sumfee;
            NSString * buildarea = [responseObject objectForKey:@"buildarea"];
            self.mianjiLabel.text = buildarea;
            NSString * sleevefee = [responseObject objectForKey:@"sleevefee"];
            self.danjiaLabel.text = sleevefee;
            NSString * discountStr = [responseObject objectForKey:@"discount"];
            self.zuihouzhekouLabel.text = discountStr;
            NSString * remarkStr = [responseObject objectForKey:@"remark"];
            self.zhekoushuomingLabel.text = remarkStr;
            NSString * totalfee = [responseObject objectForKey:@"totalfee"];
            self.chengjiaozongjiaLabel.text = totalfee;
            
            self.chengjiaodanjiaLabel.text = [[NSString alloc]initWithFormat:@"%.2f",[totalfee floatValue]/[buildarea floatValue]];
            
                        
        }else{
            NSLog(@"服务端返回错误");
        }
        [waitHUD removeFromSuperview];
        waitHUD = nil;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [waitHUD removeFromSuperview];
        waitHUD = nil;
    }];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [self.roomNameLabel setText:strRoomName];
    [self.fangjianjiegouLabel setText:strFangJianJieGou];
    [self.mianjiLabel setText:strMianJi];
    [self.danjiaLabel setText:strDanJia];
    [self.zongjiaLabel setText:strZongJia];
    [self.zuihouzhekouLabel setText:strZuiHouZheKou];
    [self.zhekoushuomingLabel setText:strZheKouShuoMing];
    [self.chengjiaodanjiaLabel setText:strChengJiaoDanJia];
    [self.chengjiaozongjiaLabel setText:strChengJiaoZongJia];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)okAction:(id)sender {
    
}

- (IBAction)cancelAction:(id)sender {
    
}
@end
