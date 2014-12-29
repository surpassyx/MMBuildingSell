//
//  TaskPersonListViewController.h
//  MMBuildingSell
//
//  Created by Daisy on 14/12/23.
//  Copyright (c) 2014年 Y.X. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskPersonListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) NSMutableArray *dataList;
@property (strong, nonatomic) IBOutlet UITableView *myTable;

@property (readwrite, nonatomic) int nType;


@end
