//
//  AnalyseCustomerViewController.m
//  MMBuildingSell
//
//  Created by 3G组 on 13-10-14.
//  Copyright (c) 2013年 Y.X. All rights reserved.
//

#import "AnalyseCustomerViewController.h"
#import "SegmentView.h"

@interface AnalyseCustomerViewController () <SegmentViewDelegate>

@end

@implementation AnalyseCustomerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SegmentView *segmentView = [[SegmentView alloc] init];
    segmentView.titles = @[@"来源分析", @"销售阶段分析"];
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
