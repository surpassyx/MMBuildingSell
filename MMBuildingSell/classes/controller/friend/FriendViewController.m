//
//  FriendViewController.m
//  QZone-HD
//
//  Created by mj on 13-9-10.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "FriendViewController.h"
#import "SegmentView.h"
@interface FriendViewController ()

@end

@implementation FriendViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    SegmentView *segment = [[SegmentView alloc] init];
    segment.titles = @[@"好友列表", @"特别关心"];
    self.navigationItem.titleView = segment;
}

@end
