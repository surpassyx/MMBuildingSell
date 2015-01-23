//
//  ZheKouViewController.h
//  MMBuildingSell
//
//  Created by Daisy on 15/1/21.
//  Copyright (c) 2015年 Y.X. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZheKouDelegate

-(void)addZheKou:(NSMutableArray *)zhekouList;

@end

@interface ZheKouViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *myTable;

@property(nonatomic,assign) id<ZheKouDelegate> delegate;

@property (nonatomic, retain) NSMutableArray *dataList;

@property (nonatomic, retain) NSMutableArray *dataZheKouArr;

@end
