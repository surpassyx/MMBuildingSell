//
//  SettingCell.h
//  QQ空间-HD
//
//  Created by apple on 13-9-12.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CellItem;

@interface SettingCell : UITableViewCell
@property (nonatomic, strong) CellItem *cellItem;

@property (nonatomic, weak) UITableView *myTableView;
@property (nonatomic, strong) NSIndexPath *indexPath;
@end