//
//  FangDaiViewController.h
//  MMBuildingSell
//
//  Created by 3G组 on 14-2-19.
//  Copyright (c) 2014年 Y.X. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "OANavigationBar.h"
#import "ExpendTableView.h"

@interface FangDaiViewController : UIViewController<UITextFieldDelegate,UIGestureRecognizerDelegate,UITableViewDataSource,UITableViewDelegate,ExpendDelegate>
{
    NSString * strDanjia;
    NSString * strAres;
}
//@property (nonatomic, retain) OANavigationBar * fangDaiBar;
//
//@property (nonatomic, retain) OANavigationBar * resultBar;
@property (nonatomic, retain) UITableView * oneTableView;
@property (nonatomic, retain) NSArray * nameArray_1;
@property (nonatomic, retain) NSArray * dataArray_1;
@property (nonatomic, retain) NSArray * nameArray_2;
@property (nonatomic, retain) NSArray * dataArray_2;
@property (nonatomic, retain) NSString * xianType;//显示类型


-(void)setCurHouseInfo:(NSString *)danjia ares:(NSString *)ares;
@end
