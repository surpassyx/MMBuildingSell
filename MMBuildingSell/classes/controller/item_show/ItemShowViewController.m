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
    segmentView.titles = @[@"项目展示", @"剖面图", @"全景展示", @"视频展示", @"房型展示", @"物业展示"];
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
    

    //项目展示图片加载
    imageBk = [UIImage imageNamed:@"6.jpg"];
    imageView = [[UIImageView alloc] initWithImage:imageBk];
    imageView.frame =CGRectMake(0, 0, width, height);
    [self.view addSubview:imageView];
    
    //画板加载
    myPlalette = [[Palette alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    myPlalette.tag = 1000;
    myPlalette.backgroundColor = [UIColor clearColor];
    [self.view addSubview:myPlalette];
    
    
    //播放视频按钮
    playButton= [[UIButton alloc]initWithFrame:CGRectMake(145, 250, 70, 80)];
    [playButton addTarget:self action:@selector(PlayMovieAction:) forControlEvents:UIControlEventTouchUpInside];
    playButton.backgroundColor=[UIColor redColor];
    [self.view addSubview:playButton];
    
    [playButton setHidden:YES];

}

- (void)segmentView:(SegmentView *)segmentView didSelectedSegmentAtIndex:(int)index
{
    [myPlalette myalllineclear];
    [imageView setHidden:NO];
    [playButton setHidden:YES];
    if (movie != NULL) {
        [movie stop];
    }
    
    switch (index) {
        case 0:
            //项目展示背景
            imageBk = [UIImage imageNamed:@"0.jpg"];
            [imageView setImage:imageBk];
            break;
        case 1:
            //剖面图
            imageBk = [UIImage imageNamed:@"1.jpg"];
            [imageView setImage:imageBk];
            break;
        case 2:
            //全景展示
            [imageView setHidden:YES];
            break;
        case 3:
            //视频播放
            //视频预览图片
            [playButton setHidden:NO];
            imageBk = [UIImage imageNamed:@"7.jpg"];
            [imageView setImage:imageBk];
            break;
        case 4:
            //房型展示
            imageBk = [UIImage imageNamed:@"5.jpg"];
            [imageView setImage:imageBk];
            break;
        case 5:
            //物业展示
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
	
//	NSLog(@"======================================");
//	NSLog(@"MyPalette Segment=%i",1);
}
//手指移动时候发出
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
//    NSLog(@"》》》》》》》》》》》》");

	NSArray* MovePointArray=[touches allObjects];
	MyMovepoint=[[MovePointArray objectAtIndex:0] locationInView:myPlalette];
	[myPlalette Introductionpoint3:MyMovepoint];
	[myPlalette setNeedsDisplay];
}
//当手指离开屏幕时候
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
//    NSLog(@"++++++++++++");
	[myPlalette Introductionpoint2];
	[myPlalette setNeedsDisplay];
}
//电话呼入等事件取消时候发出
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	//NSLog(@"touches Canelled");
}


-(void)PlayMovieAction:(id)sender{
    
    // NSLog(@"PlayMovieAction====");
    //视频文件路径，此视频已经存入项目包中。属于本地播放
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Movie" ofType:@"m4v"];
    //视频URL
    NSURL *url = [NSURL fileURLWithPath:path];
    //视频播放对象
    movie = [[MPMoviePlayerController alloc] initWithContentURL:url];
    movie.controlStyle = MPMovieControlStyleFullscreen;
    [movie.view setFrame:self.view.bounds];
    movie.initialPlaybackTime = -1;
    [self.view addSubview:movie.view];
    
//    self.view.userInteractionEnabled = NO;
    
    // 注册一个播放结束的通知，当播放结束时，监听到并且做一些处理
    //播放器自带有播放结束的通知，在此仅仅只需要注册观察者监听通知即可。
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(myMovieFinishedCallback:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:movie];
    [movie play];
}
-(void)myMovieFinishedCallback:(NSNotification*)notify
{
    //视频播放对象
    MPMoviePlayerController* theMovie = [notify object];
    //销毁播放通知
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:theMovie];
    [theMovie.view removeFromSuperview];
//    self.view.userInteractionEnabled = YES;

    // NSLog(@"视频播放完成");
}


@end
