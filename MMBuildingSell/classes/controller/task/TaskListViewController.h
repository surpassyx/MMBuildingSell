//
//  TaskListViewController.h
//  MMBuildingSell
//
//  Created by 3G组 on 13-11-20.
//  Copyright (c) 2013年 Y.X. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) NSMutableArray *dataList;
@property (strong, nonatomic) IBOutlet UITableView *myTable;

@end
