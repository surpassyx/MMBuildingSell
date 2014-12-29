//
//  TaskPersonListViewController.h
//  MMBuildingSell
//
//  Created by Daisy on 14/12/23.
//  Copyright (c) 2014年 Y.X. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol AddPersonDelegate

-(void)addPerson:(NSString *)userId name:(NSString *)username type:(int)nType;

@end


@interface TaskPersonListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) NSMutableArray *dataList;
@property (strong, nonatomic) IBOutlet UITableView *myTable;

@property (readwrite, nonatomic) int nType;

@property(nonatomic,assign) id<AddPersonDelegate> delegate;


@end
