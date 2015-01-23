//
//  AllStatusViewController.h
//  业务状态查看
//
//  Created by mj on 13-9-10.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllStatusViewController : UIViewController<UIWebViewDelegate>
{
    UIWebView *myWebView;
}
@property (nonatomic, retain) NSMutableArray *dataList;
@end
