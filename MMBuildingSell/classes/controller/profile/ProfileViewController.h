//
//  ProfileViewController.h
//  QQ空间-HD
//
//  Created by apple on 13-9-12.
//  Copyright (c) 2013年 itcast. All rights reserved.
//  个人信息

#import <UIKit/UIKit.h>

@interface ProfileViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, retain) UITableView * myTableView;


@end
