//
//  ZhiYeJiHuaViewController.h
//  MMBuildingSell
//
//  Created by Daisy on 15/1/20.
//  Copyright (c) 2015年 Y.X. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZhiYeJiHuaViewController : UIViewController<UITextFieldDelegate>
{
    NSMutableDictionary *rowHouseData;
}


@property (strong, nonatomic) IBOutlet UITextField *zhekoushuomingTextField;
@property (strong, nonatomic) IBOutlet UITextField *fangkuanzongeTextField;
@property (strong, nonatomic) IBOutlet UITextField *anjiezongeTextField;
@property (strong, nonatomic) IBOutlet UITextField *gongjijindaikuanTextField;
@property (strong, nonatomic) IBOutlet UITextField *anjiebiliTextField;
@property (strong, nonatomic) IBOutlet UITextField *gongjijinbiliTextField;
@property (strong, nonatomic) IBOutlet UITextField *anjienianxian1TextField;
@property (strong, nonatomic) IBOutlet UITextField *anjienianxian2TextField;
@property (strong, nonatomic) IBOutlet UITextField *anjienianxian3TextField;
@property (strong, nonatomic) IBOutlet UITextField *anjienianxian4TextField;
@property (strong, nonatomic) IBOutlet UITextField *anjienianxian5TextField;
@property (strong, nonatomic) IBOutlet UITextField *anjielilv1TextField;
@property (strong, nonatomic) IBOutlet UITextField *anjielilv2TextField;
@property (strong, nonatomic) IBOutlet UITextField *anjielilv3TextField;
@property (strong, nonatomic) IBOutlet UITextField *anjielilv4TextField;
@property (strong, nonatomic) IBOutlet UITextField *anjielilv5TextField;
@property (strong, nonatomic) IBOutlet UITextField *gongjijinlilv1TextField;
@property (strong, nonatomic) IBOutlet UITextField *gongjijinlilv2TextField;
@property (strong, nonatomic) IBOutlet UITextField *gongjijinlilv3TextField;
@property (strong, nonatomic) IBOutlet UITextField *gongjijinlilv4TextField;
@property (strong, nonatomic) IBOutlet UITextField *gongjijinlilv5TextField;
@property (strong, nonatomic) IBOutlet UIButton *zhekouBtn;

- (IBAction)printAction:(id)sender;
- (IBAction)quxiaoAction:(id)sender;
- (IBAction)zhekouBtnAction:(id)sender;

-(void)initHouseData:(NSMutableDictionary *)dic;

@end
