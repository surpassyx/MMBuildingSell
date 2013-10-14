//
//  SettingViewController.m
//  QZone-HD
//
//  Created by mj on 13-9-10.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "SettingViewController.h"
#import "CellItem.h"
#import "SettingCell.h"

@interface SettingViewController ()
{
    NSMutableArray *_cellItems;
}
@end

@implementation SettingViewController

- (id)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 搭建UI界面
    [self buildUI];
    
    // 初始化item
    [self addCellItems];
    
    // 添加尾部
    [self addFooter];
}

- (void)buildUI
{
    self.title = @"设置";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(close)];
    
    // 覆盖group样式tableView默认的header
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 10)];
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
}

- (void)addFooter
{
    CGFloat footerHeight = 135;
    // 尾部
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, footerHeight)];
    self.tableView.tableFooterView = footer;
    
    CGFloat footerWidth = 540;
    CGFloat btnX =  14;
    CGFloat btnWidth = footerWidth - 2 * btnX;
    CGFloat btnHeight = 45;
    
    // 退出当前账号
    UIButton *logout = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat logoutY = footerHeight - btnHeight;
    logout.frame = CGRectMake(btnX, logoutY, btnWidth, btnHeight);
    [logout setTitle:@"退出当前帐号" forState:UIControlStateNormal];
    [logout setBackgroundImage:[UIImage resizeImage:@"logout_btn_bg.png"] forState:UIControlStateNormal];
    [logout setBackgroundImage:[UIImage resizeImage:@"logout_btn_bg_highlighted.png"] forState:UIControlStateHighlighted];
    [logout addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    logout.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [footer addSubview:logout];
    
    // 清除缓存
    UIButton *clear = [UIButton buttonWithType:UIButtonTypeCustom];
    [clear setTitle:@"清除缓存" forState:UIControlStateNormal];
    CGFloat clearY = logoutY - 5 - btnHeight;
    clear.frame = CGRectMake(btnX, clearY, btnWidth, btnHeight);
    clear.titleLabel.font = logout.titleLabel.font;
    [clear setBackgroundImage:[UIImage resizeImage:@"btn_permission.png"] forState:UIControlStateNormal];
    [clear setBackgroundImage:[UIImage resizeImage:@"btn_permission_click.png"] forState:UIControlStateHighlighted];
    [clear setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [footer addSubview:clear];
}

- (void)logout
{
    [self dismissViewControllerAnimated:YES completion:^{
        // 发出通知给HomeViewController
        [[NSNotificationCenter defaultCenter] postNotificationName:@"logout" object:nil];
    }];
}

- (void)addCellItems
{
    CellItem *note = [CellItem itemWithTitle:@"通知设置" cellItemType:CellItemTypeDisclosureIndicator];
    
    CellItem *upload = [CellItem itemWithTitle:@"上传高清图片" cellItemType:CellItemTypeSwitch];
    CellItem *photo = [CellItem itemWithTitle:@"照片水印" cellItemType:CellItemTypeSwitch];
    
    CellItem *power = [CellItem itemWithTitle:@"权限设置" cellItemType:CellItemTypeDisclosureIndicator];
    
    CellItem *skin = [CellItem itemWithTitle:@"皮肤" cellItemType:CellItemTypeDisclosureIndicator];
    
    CellItem *voice = [CellItem itemWithTitle:@"提示音" cellItemType:CellItemTypeSwitch];
    
    CellItem *suggest = [CellItem itemWithTitle:@"意见反馈" cellItemType:CellItemTypeDisclosureIndicator];
    suggest.className = @"SuggestViewController";
    
    CellItem *about = [CellItem itemWithTitle:@"关于" cellItemType:CellItemTypeDisclosureIndicator];
    about.className = @"AboutViewController";
    
    NSArray *array = @[
                    @[note],
                    @[upload, photo],
                    @[power],
                    @[skin],
                    @[voice],
                    @[suggest, about]
                   ];
    _cellItems = [NSMutableArray arrayWithArray:array];
}

#pragma mark close
- (void)close
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _cellItems.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = _cellItems[section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[SettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.myTableView = tableView;
    }
    
    cell.indexPath = indexPath;
    cell.cellItem = _cellItems[indexPath.section][indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellItem *item = _cellItems[indexPath.section][indexPath.row];
    if (item.cellClickBlock) {
        item.cellClickBlock(item);
    } else if (item.className) { // 想跳到下一个界面
        Class c = NSClassFromString(item.className);
        UIViewController *vc = [[c alloc] init];
        vc.title = item.title;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end