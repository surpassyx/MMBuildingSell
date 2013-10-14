//
//  SelectViewController.m
//  MMBuildingSell
//
//  Created by 3G组 on 13-10-14.
//  Copyright (c) 2013年 Y.X. All rights reserved.
//

#import "SelectViewController.h"
#import "SegmentView.h"

@interface SelectViewController () <SegmentViewDelegate>

@end

@implementation SelectViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SegmentView *segmentView = [[SegmentView alloc] init];
    segmentView.titles = @[@"整体状况", @"户型选房"];
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
