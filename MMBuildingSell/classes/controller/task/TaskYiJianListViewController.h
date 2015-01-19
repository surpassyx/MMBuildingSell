//
//  TaskYiJianListViewController.h
//  MMBuildingSell
//
//  Created by Daisy on 15/1/15.
//  Copyright (c) 2015年 Y.X. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskYiJianListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) NSMutableArray *dataList;
@property (strong, nonatomic) IBOutlet UITableView *myTable;

-(void)initTaskId:(NSString *)strId;
@end
