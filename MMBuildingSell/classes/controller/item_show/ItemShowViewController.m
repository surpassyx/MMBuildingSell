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

//保存线条颜色
static NSMutableArray *colors;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SegmentView *segmentView = [[SegmentView alloc] init];
    segmentView.titles = @[@"项目展示", @"剖面图", @"全景展示", @"视频展示", @"周边环境", @"房型展示", @"物业展示"];
    segmentView.delegate = self;
    self.navigationItem.titleView = segmentView;

    CGFloat width;
    CGFloat height;
    
    if ([[UIScreen mainScreen] applicationFrame].size.height==1024) {
        width = 768 - kDockMenuItemHeight;
        height = self.view.frame.size.height;
    }else{
        width = 1024 - kDockMenuItemHeight;
        height = self.view.frame.size.height;
    }
    
    imageBk = [UIImage imageNamed:@"6.jpg"];
    imageView = [[UIImageView alloc] initWithImage:imageBk];
    imageView.frame =CGRectMake(0, 0, width, height);
    [self.view addSubview:imageView];
    
    myPlalette = [[Palette alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    myPlalette.tag = 1000;
    myPlalette.backgroundColor = [UIColor clearColor];
    [self.view addSubview:myPlalette];
    

}

- (void)segmentView:(SegmentView *)segmentView didSelectedSegmentAtIndex:(int)index
{
   [imageView setHidden:NO];
    NSLog(@"点击了哪个位置---%d", index);
    switch (index) {
        case 0:
            imageBk = [UIImage imageNamed:@"0.jpg"];
            [imageView setImage:imageBk];
            break;
        case 1:
            imageBk = [UIImage imageNamed:@"1.jpg"];
            [imageView setImage:imageBk];
            break;
        case 2:
            [imageView setHidden:YES];
            break;
        case 3:
            [imageView setHidden:YES];
            break;
        case 4:
            [imageView setHidden:YES];
            break;
        case 5:
            imageBk = [UIImage imageNamed:@"5.jpg"];
            [imageView setImage:imageBk];
            break;
        case 6:
            imageBk = [UIImage imageNamed:@"6.jpg"];
            [imageView setImage:imageBk];
            break;
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
//手指开始触屏开始
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
	UITouch* touch=[touches anyObject];
	MyBeganpoint=[touch locationInView:self.view ];
	
	[myPlalette Introductionpoint4:1];
	[myPlalette Introductionpoint5:2];
	[myPlalette Introductionpoint1];
	[myPlalette Introductionpoint3:MyBeganpoint];
	
	NSLog(@"======================================");
	NSLog(@"MyPalette Segment=%i",1);
}
//手指移动时候发出
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	NSArray* MovePointArray=[touches allObjects];
	MyMovepoint=[[MovePointArray objectAtIndex:0] locationInView:myPlalette];
	[myPlalette Introductionpoint3:MyMovepoint];
	[myPlalette setNeedsDisplay];
}
//当手指离开屏幕时候
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[myPlalette Introductionpoint2];
	[myPlalette setNeedsDisplay];
}
//电话呼入等事件取消时候发出
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	//NSLog(@"touches Canelled");
}


@end
