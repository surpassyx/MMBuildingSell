//
//  PhotoViewController.m
//  QZone-HD
//
//  Created by mj on 13-9-10.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "PhotoViewController.h"
#import "SegmentView.h"
@interface PhotoViewController ()
@end

@implementation PhotoViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SegmentView *segment = [[SegmentView alloc] init];
    segment.titles = @[@"好友照片", @"我的相册"];
    self.navigationItem.titleView = segment;
}
@end