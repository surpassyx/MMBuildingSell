//
//  MessageListViewController.h
//  MMBuildingSell
//
//  Created by Daisy on 15/1/28.
//  Copyright (c) 2015年 Y.X. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) NSMutableArray *dataList;
@property (strong, nonatomic) IBOutlet UITableView *myTable;

@end
