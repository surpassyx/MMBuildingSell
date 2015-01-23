//
//  PrintZhiYeJiHuaViewController.m
//  MMBuildingSell
//
//  Created by Daisy on 15/1/21.
//  Copyright (c) 2015年 Y.X. All rights reserved.
//

#import "PrintZhiYeJiHuaViewController.h"

@interface PrintZhiYeJiHuaViewController (){
    NSString * roomNo;
    NSString * discount;
    NSString * remark;
    NSString * totalFee;
    NSString * mortgageFee;
    NSString * mortgagePrecent;
    NSString * fundFee;
    NSString * fundPrecent;
    
}

@end

@implementation PrintZhiYeJiHuaViewController

-(void)initDataRoomNo:(NSString *)no
             discount:(NSString *)dis
               remark:(NSString *)re
             totalFee:(NSString *)tota
          mortgageFee:(NSString *)mortFee
      mortgagePrecent:(NSString *)mortPre
              fundFee:(NSString *)fundFe
          fundPrecent:(NSString *)fundPre
{
    roomNo = no;
    discount = dis;
    remark = re;
    totalFee = tota;
    mortgageFee = mortFee;
    mortgagePrecent = mortPre;
    fundFee = fundFe;
    fundPrecent = fundPre;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

-(void)getHttpInfo
{
    
    NSString * strUrl = [[NSString alloc]initWithFormat:@"action=16&roomNo=%@&discount=%@&remark=%@&totalFee=%@&mortgageFee=%@&mortgagePrecent=%@&fundFee=%@&fundPrecent=%@",roomNo,discount,remark,totalFee,mortgageFee,mortgagePrecent,fundFee,fundPrecent];
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
            self.fangjiandaimaLabel.text = roomcode;
            NSString * layoutname = [responseObject objectForKey:@"layoutname"];
            self.huxingLabel.text = layoutname;
            NSString * typename = [responseObject objectForKey:@"typename"];
            self.fangjianleixingLabel.text = typename;
            NSString * structurename = [responseObject objectForKey:@"structurename"];
            self.fangjianjiegouLabel.text = structurename;
            NSString * orientation = [responseObject objectForKey:@"orientation"];
            self.chaoxiangLabel.text = orientation;
            NSString * sumfee = [responseObject objectForKey:@"sumfee"];
            self.biaozhunzongjiaLabel.text = sumfee;
            NSString * buildfee = [responseObject objectForKey:@"buildfee"];
            self.jianzhudanjiaLabel.text = buildfee;
            NSString * sleevefee = [responseObject objectForKey:@"sleevefee"];
            self.taoneidanjiaLabel.text = sleevefee;
            NSString * pricemodename = [responseObject objectForKey:@"pricemodename"];
            self.mianjixiaoshoumoshiLabel.text = pricemodename;
            NSString * buildarea = [responseObject objectForKey:@"buildarea"];
            self.jianzhumianjiLabel.text = buildarea;
            NSString * sleevearea = [responseObject objectForKey:@"sleevearea"];
            self.taoneimianjiLabel.text = sleevearea;
            
            NSString * discountStr = [responseObject objectForKey:@"discount"];
            self.zhekouLabel.text = discountStr;
            NSString * remarkStr = [responseObject objectForKey:@"remark"];
            self.zhekoushuomingLabel.text = remarkStr;
            NSString * totalfee = [responseObject objectForKey:@"totalfee"];
            self.chengjiaozongjiaLabel.text = totalfee;
            NSString * firstpay = [responseObject objectForKey:@"firstpay"];
            self.shoufukuanLabel.text = firstpay;
            NSString * mortgagefee = [responseObject objectForKey:@"mortgagefee"];
            self.anjiedaikuanLabel.text = mortgagefee;
            NSString * mortgageprecent = [responseObject objectForKey:@"mortgageprecent"];
            self.anjiebiliLabel.text = mortgageprecent;
            NSString * fundfee = [responseObject objectForKey:@"fundfee"];
            self.gongjijindaikuanLabel.text = fundfee;
            NSString * fundprecent = [responseObject objectForKey:@"fundprecent"];
            self.gongjijinbiliLabel.text = fundprecent;
            
            NSMutableArray *arrInfo = [responseObject objectForKey:@"arr"];
            
            NSDictionary *dicInfo1 = [arrInfo objectAtIndex:0];
            NSString * year1 = [dicInfo1 objectForKey:@"year"];
            NSString * mFee1 =[dicInfo1 objectForKey:@"mFee"];
            NSString * fFee1 = [dicInfo1 objectForKey:@"fFee"];
            NSString * sumFee1 =[dicInfo1 objectForKey:@"sumFee"];
            self.anjienianxianLabel1.text = year1;
            self.yuegongLabel1.text = mFee1;
            self.gongjijinLabel1.text = fFee1;
            self.xiaojiLabel1.text = sumFee1;

            NSDictionary *dicInfo2 = [arrInfo objectAtIndex:1];
            NSString * year2 = [dicInfo2 objectForKey:@"year"];
            NSString * mFee2 =[dicInfo2 objectForKey:@"mFee"];
            NSString * fFee2 = [dicInfo2 objectForKey:@"fFee"];
            NSString * sumFee2 =[dicInfo2 objectForKey:@"sumFee"];
            self.anjienianxianLabel2.text = year2;
            self.yuegongLabel2.text = mFee2;
            self.gongjijinLabel2.text = fFee2;
            self.xiaojiLabel2.text = sumFee2;
            
            NSDictionary *dicInfo3 = [arrInfo objectAtIndex:2];
            NSString * year3 = [dicInfo3 objectForKey:@"year"];
            NSString * mFee3 =[dicInfo3 objectForKey:@"mFee"];
            NSString * fFee3 = [dicInfo3 objectForKey:@"fFee"];
            NSString * sumFee3 =[dicInfo3 objectForKey:@"sumFee"];
            self.anjienianxianLabel3.text = year3;
            self.yuegongLabel3.text = mFee3;
            self.gongjijinLabel3.text = fFee3;
            self.xiaojiLabel3.text = sumFee3;
            
            NSDictionary *dicInfo4 = [arrInfo objectAtIndex:3];
            NSString * year4 = [dicInfo4 objectForKey:@"year"];
            NSString * mFee4 =[dicInfo4 objectForKey:@"mFee"];
            NSString * fFee4 = [dicInfo4 objectForKey:@"fFee"];
            NSString * sumFee4 =[dicInfo4 objectForKey:@"sumFee"];
            self.anjienianxianLabel4.text = year4;
            self.yuegongLabel4.text = mFee4;
            self.gongjijinLabel4.text = fFee4;
            self.xiaojiLabel4.text = sumFee4;
            
            
            
            NSArray *arry=[roomcode componentsSeparatedByString:@"-"];
            NSString * titleStr = [arry objectAtIndex:0];
            
            self.titleLabel.text = titleStr;
            
        }else{
            NSLog(@"服务端返回错误");
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}

- (IBAction)printAction:(id)sender {
    NSString * strUrl = [[NSString alloc]initWithFormat:@"action=17&roomNo=%@&discount=%@&remark=%@&totalFee=%@&mortgageFee=%@&mortgagePrecent=%@&fundFee=%@&fundPrecent=%@",roomNo,discount,remark,totalFee,mortgageFee,mortgagePrecent,fundFee,fundPrecent];
    NSString * hexUrl  = [Utility hexStringFromString:strUrl];
    NSLog(@"dayin=%@",API_BASE_URL(hexUrl));
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:API_BASE_URL(hexUrl) parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        NSString * strSign = [responseObject objectForKey:@"sign"];
        int intString = [strSign intValue];
        if (intString == 1) {
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }else{
            NSLog(@"服务端返回错误");
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}
@end
