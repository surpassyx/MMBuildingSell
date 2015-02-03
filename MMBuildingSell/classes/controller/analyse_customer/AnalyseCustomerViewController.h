//
//  AnalyseCustomerViewController.h
//  MMBuildingSell
//
//  Created by 3G组 on 13-10-14.
//  Copyright (c) 2013年 Y.X. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "XYPieChart.h"
//#import "XCMultiSortTableView.h"
#import "HTHorizontalSelectionList.h"

@interface AnalyseCustomerViewController : UIViewController<UIWebViewDelegate>
{
    UIWebView *myWebView;
    
    UIImageView *imageUpView;
    UIImageView *imageDownView;
    //内容图片
    UIImage * imageUp;
    //框体图片
    UIImage * imageDown;
    
}

@property (nonatomic, retain) NSMutableArray *dataList;

@property (nonatomic, strong) HTHorizontalSelectionList *selectionList;

@end
