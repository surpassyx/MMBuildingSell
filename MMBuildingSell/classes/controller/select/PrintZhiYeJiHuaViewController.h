//
//  PrintZhiYeJiHuaViewController.h
//  MMBuildingSell
//
//  Created by Daisy on 15/1/21.
//  Copyright (c) 2015年 Y.X. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrintZhiYeJiHuaViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *fangjiandaimaLabel;
@property (strong, nonatomic) IBOutlet UILabel *fangjianleixingLabel;
@property (strong, nonatomic) IBOutlet UILabel *fangjianjiegouLabel;
@property (strong, nonatomic) IBOutlet UILabel *huxingLabel;
@property (strong, nonatomic) IBOutlet UILabel *chaoxiangLabel;
@property (strong, nonatomic) IBOutlet UILabel *biaozhunzongjiaLabel;
@property (strong, nonatomic) IBOutlet UILabel *jianzhudanjiaLabel;
@property (strong, nonatomic) IBOutlet UILabel *taoneidanjiaLabel;
@property (strong, nonatomic) IBOutlet UILabel *mianjixiaoshoumoshiLabel;
@property (strong, nonatomic) IBOutlet UILabel *jianzhumianjiLabel;
@property (strong, nonatomic) IBOutlet UILabel *taoneimianjiLabel;

@property (strong, nonatomic) IBOutlet UILabel *zhekouLabel;
@property (strong, nonatomic) IBOutlet UILabel *zhekoushuomingLabel;
@property (strong, nonatomic) IBOutlet UILabel *chengjiaozongjiaLabel;
@property (strong, nonatomic) IBOutlet UILabel *shoufukuanLabel;
@property (strong, nonatomic) IBOutlet UILabel *anjiedaikuanLabel;
@property (strong, nonatomic) IBOutlet UILabel *anjiebiliLabel;
@property (strong, nonatomic) IBOutlet UILabel *gongjijindaikuanLabel;
@property (strong, nonatomic) IBOutlet UILabel *gongjijinbiliLabel;

@property (strong, nonatomic) IBOutlet UILabel *anjienianxianLabel1;
@property (strong, nonatomic) IBOutlet UILabel *anjienianxianLabel2;
@property (strong, nonatomic) IBOutlet UILabel *anjienianxianLabel3;
@property (strong, nonatomic) IBOutlet UILabel *anjienianxianLabel4;
@property (strong, nonatomic) IBOutlet UILabel *anjienianxianLabel5;

@property (strong, nonatomic) IBOutlet UILabel *yuegongLabel1;
@property (strong, nonatomic) IBOutlet UILabel *yuegongLabel2;
@property (strong, nonatomic) IBOutlet UILabel *yuegongLabel3;
@property (strong, nonatomic) IBOutlet UILabel *yuegongLabel4;
@property (strong, nonatomic) IBOutlet UILabel *yuegongLabel5;

@property (strong, nonatomic) IBOutlet UILabel *gongjijinLabel1;
@property (strong, nonatomic) IBOutlet UILabel *gongjijinLabel2;
@property (strong, nonatomic) IBOutlet UILabel *gongjijinLabel3;
@property (strong, nonatomic) IBOutlet UILabel *gongjijinLabel4;
@property (strong, nonatomic) IBOutlet UILabel *gongjijinLabel5;

@property (strong, nonatomic) IBOutlet UILabel *xiaojiLabel1;
@property (strong, nonatomic) IBOutlet UILabel *xiaojiLabel2;
@property (strong, nonatomic) IBOutlet UILabel *xiaojiLabel3;
@property (strong, nonatomic) IBOutlet UILabel *xiaojiLabel4;
@property (strong, nonatomic) IBOutlet UILabel *xiaojiLabel5;

- (IBAction)printAction:(id)sender;

-(void)initDataRoomNo:(NSString *)no
             discount:(NSString *)dis
               remark:(NSString *)re
             totalFee:(NSString *)tota
          mortgageFee:(NSString *)mortFee
      mortgagePrecent:(NSString *)mortPre
              fundFee:(NSString *)fundFe
          fundPrecent:(NSString *)fundPre;


@end
