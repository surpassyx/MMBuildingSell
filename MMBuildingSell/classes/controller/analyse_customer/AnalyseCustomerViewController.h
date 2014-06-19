//
//  AnalyseCustomerViewController.h
//  MMBuildingSell
//
//  Created by 3G组 on 13-10-14.
//  Copyright (c) 2013年 Y.X. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYPieChart.h"
#import "XCMultiSortTableView.h"

@interface AnalyseCustomerViewController : UIViewController<XYPieChartDelegate, XYPieChartDataSource,UIWebViewDelegate,XCMultiTableViewDataSource>
{
    XYPieChart *pieChartRight;
    UIWebView *myWebView;
    
    XCMultiTableView *tablePieView;
    XCMultiTableView *tableLouDouView;
    
    NSMutableArray *headDataPie;
    NSMutableArray *leftTableDataPie;
    NSMutableArray *rightTableDataPie;
    
    NSMutableArray *headDataDou;
    NSMutableArray *leftTableDataDou;
    NSMutableArray *rightTableDataDou;
    
    UIImageView *imageUpView;
    UIImageView *imageDownView;
    //内容图片
    UIImage * imageUp;
    //框体图片
    UIImage * imageDown;
    
}

@property(nonatomic, strong) NSMutableArray *slices;
@property(nonatomic, strong) NSArray        *sliceColors;

@end
