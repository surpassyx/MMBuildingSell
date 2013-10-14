//
//  AllStatusViewController.m
//  QZone-HD
//
//  Created by mj on 13-9-10.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "AllStatusViewController.h"
#import "SegmentView.h"

@interface AllStatusViewController () <SegmentViewDelegate>
@end

@implementation AllStatusViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    SegmentView *segmentView = [[SegmentView alloc] init];
    segmentView.titles = @[@"全部", @"特别关心", @"好友动态", @"认证空间"];
    segmentView.delegate = self;
    self.navigationItem.titleView = segmentView;
}

- (void)segmentView:(SegmentView *)segmentView didSelectedSegmentAtIndex:(int)index
{
    NSLog(@"点击了哪个位置---%d", index);
}
@end
