//
//  MenuView.m
//  QQ空间-HD
//
//  Created by apple on 13-9-11.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MenuView.h"
#import "MenuItemView.h"
#import "DockItem.h"

@interface MenuView()
{
    NSArray *_dockItems;
    
    MenuItemView *_currentItemView;
}
@end

@implementation MenuView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.先添加DockItem
        [self addDockItems];
        
        // 2.添加按钮
        [self addMenuItemViews];
        
        // 3.添加顶部的分隔线
        UIImageView *divider = [[UIImageView alloc] init];
        divider.image = [UIImage resizeImage:@"tabbar_separate_line.png"];
        divider.frame = CGRectMake(0, 0, frame.size.width, 2);
        divider.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addSubview:divider];
    }
    return self;
}

#pragma mark 先添加DockItem
- (void)addDockItems
{
    _dockItems = @[
                   [DockItem itemWithIcon:@"tab_bar_feed_icon.png" title:@"项目展示" className:@"ItemShowViewController"],
                   [DockItem itemWithIcon:@"tab_bar_passive_feed_icon.png" title:@"选房计价" className:@"SelectViewController"],
                   [DockItem itemWithIcon:@"tab_bar_pic_wall_icon.png" title:@"客户管理" className:@"ManageCustomerViewController"],
                   [DockItem itemWithIcon:@"tab_bar_friend_icon.png" title:@"客户分析" className:@"AnalyseCustomerViewController"],
                   [DockItem itemWithIcon:@"tab_bar_app_icon.png" title:@"业务查看" className:@"BusinessViewController"],
                   [DockItem itemWithIcon:@"tab_bar_pic_setting_icon.png" title:@"设置" className:@"SettingViewController" modal:YES]
                   ];
}

#pragma mark 添加按钮
- (void)addMenuItemViews
{
    int count = _dockItems.count;
    for (int i = 0; i<count; i++) {
        MenuItemView *btn = [[MenuItemView alloc] init];
        btn.frame = CGRectMake(0, i * kDockMenuItemHeight, self.frame.size.width, kDockMenuItemHeight);
        btn.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        btn.dockItem = _dockItems[i];
        [btn addTarget:self action:@selector(menuItemClick:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:btn];
    }
}

- (void)menuItemClick:(MenuItemView *)itemView
{
    if(![itemView.dockItem.title isEqualToString:@"设置"]) {
        _currentItemView.selected = NO;
        itemView.selected = YES;
        _currentItemView = itemView;
    }
    
    // 将事件传递给block
    if (_menuItemClickBlock) {
        _menuItemClickBlock(itemView.dockItem);
    }
}

- (void)rotateToOrientation:(UIInterfaceOrientation)orientation composeFrame:(CGRect)composeFrame
{
    // 设置MenuView的frame
    CGFloat width = composeFrame.size.width;
    CGFloat height = _dockItems.count * kDockMenuItemHeight;
    CGFloat y = composeFrame.origin.y - height;
    self.frame = CGRectMake(0, y, width, height);
}

- (void)unselectAll
{
    _currentItemView.selected = NO;
    _currentItemView = nil;
}
@end