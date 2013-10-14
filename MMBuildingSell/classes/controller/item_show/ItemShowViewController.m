//
//  ItemShowViewController.m
//  MMBuildingSell
//
//  Created by 3G组 on 13-10-14.
//  Copyright (c) 2013年 Y.X. All rights reserved.
//

#import "ItemShowViewController.h"
#import "SegmentView.h"

@interface ItemShowViewController () <SegmentViewDelegate>

@end

@implementation ItemShowViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SegmentView *segmentView = [[SegmentView alloc] init];
    segmentView.titles = @[@"项目展示", @"剖面图", @"全景展示", @"视频展示", @"周边环境", @"房型展示", @"物业展示"];
    segmentView.delegate = self;
    self.navigationItem.titleView = segmentView;
}

- (void)segmentView:(SegmentView *)segmentView didSelectedSegmentAtIndex:(int)index
{
    NSLog(@"点击了哪个位置---%d", index);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
