//
//  BuyViewController.h
//  MMBuildingSell
//
//  Created by Daisy on 15/3/18.
//  Copyright (c) 2015年 Y.X. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuyViewController : UIViewController{
    NSString * strRoomCode;
    NSString * strRoomName;
    NSString * strFangJianJieGou;
    NSString * strMianJi;
    NSString * strDanJia;
    NSString * strZongJia;
    NSString * strZuiHouZheKou;
    NSString * strZheKouShuoMing;
    NSString * strChengJiaoDanJia;
    NSString * strChengJiaoZongJia;
    
}

@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *telTextField;
@property (strong, nonatomic) IBOutlet UILabel *roomNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *fangjianjiegouLabel;
@property (strong, nonatomic) IBOutlet UILabel *mianjiLabel;
@property (strong, nonatomic) IBOutlet UILabel *danjiaLabel;
@property (strong, nonatomic) IBOutlet UILabel *zongjiaLabel;
@property (strong, nonatomic) IBOutlet UILabel *zuihouzhekouLabel;
@property (strong, nonatomic) IBOutlet UILabel *zhekoushuomingLabel;
@property (strong, nonatomic) IBOutlet UILabel *chengjiaodanjiaLabel;
@property (strong, nonatomic) IBOutlet UILabel *chengjiaozongjiaLabel;
@property (strong, nonatomic) IBOutlet UISegmentedControl *fukuanfangshiSeg;

- (IBAction)okAction:(id)sender;
- (IBAction)cancelAction:(id)sender;

-(void)initWithRoomCode:(NSString *)roomCode
         fangjianjiegou:(NSString *)fangjianjiegou
                 mianji:(NSString *)mianji
                 danjia:(NSString *)danjia
                zongjia:(NSString *)zongjia
           zuihouzhekou:(NSString *)zuihouzhekou
         zhekoushuoming:(NSString *)zhekoushuoming
        chengjiaodanjia:(NSString *)chengjiaodanjia
       chengjiaozongjia:(NSString *)chengjiaozongjia;

@end
