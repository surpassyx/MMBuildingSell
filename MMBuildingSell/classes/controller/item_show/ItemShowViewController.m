//
//  ItemShowViewController.m
//  MMBuildingSell
//
//  Created by 3G组 on 13-10-14.
//  Copyright (c) 2013年 Y.X. All rights reserved.
//

#import "ItemShowViewController.h"
#import "SegmentView.h"

// 按钮宽度
#define kDrawButtonWidth 40
// 按钮距右侧距离
#define kDrawButtonRightWidth 70
// 按钮起始Y位置
#define kDrawButtonY 100
// 按钮上下间距
#define kDrawButtonUp 10



@interface ItemShowViewController () <SegmentViewDelegate>
@end

@implementation ItemShowViewController{
    NSMutableArray *_slideshowData;
    NSArray *_transitionOptions;
}


//保存线条颜色
static NSMutableArray *colors;

//- (void)receivedPushContent:(NSNotification*)notification{
//    NSString *content = [notification object];
////    [XWAlterview showmessage:@"新消息" subtitle:content cancelbutton:@"确定"];
//    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:content delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    [alter show];
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SegmentView *segmentView = [[SegmentView alloc] init];
    segmentView.titles = @[@"项目展示", @"剖面图", @"房型展示", @"物业展示",@"周边配套", @"视频展示"];
    segmentView.delegate = self;
    self.navigationItem.titleView = segmentView;
    
//    UIViewAnimationTransitionNone 正常
//    UIViewAnimationTransitionFlipFromLeft 从左向右翻
//    UIViewAnimationTransitionFlipFromRight 从右向左翻
//    UIViewAnimationTransitionCurlUp 从下向上卷
//    UIViewAnimationTransitionCurlDown 从上向下卷
    
//    UIViewAnimationOptionCurveEaseInOut
    
//    _transitionOptions= @[[NSNumber numberWithInteger:UIViewAnimationOptionTransitionFlipFromLeft],
//                          [NSNumber numberWithInteger:UIViewAnimationOptionTransitionFlipFromRight],
//                          [NSNumber numberWithInteger:UIViewAnimationOptionTransitionCurlUp],
//                          [NSNumber numberWithInteger:UIViewAnimationOptionTransitionCurlDown],
//                          [NSNumber numberWithInteger:UIViewAnimationOptionTransitionCrossDissolve],
//                          [NSNumber numberWithInteger:UIViewAnimationOptionTransitionFlipFromTop],
//                          [NSNumber numberWithInteger:UIViewAnimationOptionTransitionFlipFromBottom]];
    _transitionOptions= @[
                          [NSNumber numberWithInteger:UIViewAnimationOptionTransitionCrossDissolve]
                          ];
    
    NSString *saveFilePath = [LocalFilePath getSessionPath:@"xiangmuzhanshi/"]; //保存文件的路径
    NSMutableArray * arrTemp = [LocalFilePath searchFileInDocumentDirctory:saveFilePath];
    
//    NSArray* section1 = @[@"0.jpg",@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg",@"6.jpg"];
    _slideshowData =[NSMutableArray arrayWithObjects:arrTemp,nil,nil];
    

    CGFloat width = 814.0;
    CGFloat height = 748.9;
    
//    if ([[UIScreen mainScreen] applicationFrame].size.height==1024) {
//        width = 768 - kDockMenuItemHeight;
//        height = self.view.frame.size.height;
//    }else{
//        width = 1024 - kDockMenuItemHeight;
//        height = self.view.frame.size.height;
//    }
    
    //外框
    imageFrameBk = [UIImage imageNamed:@"item_view_bk.png"];
    imageFrameView = [[UIImageView alloc] initWithImage:imageFrameBk];
    imageFrameView.frame =CGRectMake(0, 0, width, height - 46);
    [self.view addSubview:imageFrameView];
    
    
    
    //项目展示图片加载
    imageBk = [UIImage imageNamed:@"item_show_demo"];
    imageView = [[UIImageView alloc] initWithImage:imageBk];
    imageView.frame =CGRectMake(47, 50, width-47*2 - 40, height-100 - 46);
    [self.view addSubview:imageView];
    [imageView setHidden:YES];
    
    //画板加载
    [self initPlalette:width height:height];
    
    //播放视频按钮
    [self initPlay:YES];
    
    //左右按钮与图片集切换
    [self initImageShowView];
    
    [self.view bringSubviewToFront:myPlalette];
    [self.view bringSubviewToFront:leftButton];
    [self.view bringSubviewToFront:rightButton];
    [self.view bringSubviewToFront:drawButton];
    [self.view bringSubviewToFront:clearButton];
    [self.view bringSubviewToFront:finallyRemoveButton];
    
    
}
/*
 *图片集与左右按钮初始化
 */
-(void)initImageShowView{
    
    leftButton = [[UIButton alloc]initWithFrame:CGRectMake(23, 300, 64, 161)];
    [leftButton addTarget:self action:@selector(previousButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//    leftButton.backgroundColor=[UIColor redColor];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"item_left_btn"] forState:UIControlStateNormal];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"item_left_btn_selected"] forState:UIControlStateSelected];
    [self.view addSubview:leftButton];

    rightButton = [[UIButton alloc]initWithFrame:CGRectMake(729, 300, 64, 161)];
    [rightButton addTarget:self action:@selector(nextButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//    rightButton.backgroundColor=[UIColor redColor];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"item_right_btn"] forState:UIControlStateNormal];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"item_right_btn_selected"] forState:UIControlStateSelected];
//    rightButton.alpha = 0.2f;
    [self.view addSubview:rightButton];
    
    imageShowView = [[SLGSlideshowView alloc]initWithFrame:CGRectMake(kItemShowImageX, kItemShowImageY, kItemShowImageW, kItemShowImageH)];
    imageShowView.datasource = self;
    imageShowView.delegate = self;
    [self.view addSubview:imageShowView];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [imageShowView beginSlideShow];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedPushContent:) name:@"PUSHCONTENT" object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"PUSHCONTENT" object:nil];
    
}

#pragma mark - Actions
-(void)previousButtonAction:(id)sender{
    
    BOOL isHavePre = [imageShowView previousImage];
    if (isHavePre == NO) {
        [XWAlterview showmessage:@"提示" subtitle:@"前面没有了" cancelbutton:@"确定"];
    }
//    NSLog(@"上一张图片");
}
-(void)playButtonAction:(id)sender{
    
    [imageShowView pauseResumeSlideShow];
}
-(void)nextButtonAction:(id)sender{
    
    BOOL isHaveNext = [imageShowView nextImage];
//    NSLog(@"下一张图片");
    if (isHaveNext == NO) {
        [XWAlterview showmessage:@"提示" subtitle:@"已经是最后一张了" cancelbutton:@"确定"];
    }

}


-(void)initPlay:(BOOL)isHidden{
    playButton= [[UIButton alloc]initWithFrame:CGRectMake(303, 270, 208, 208)];
    [playButton addTarget:self action:@selector(PlayMovieAction:) forControlEvents:UIControlEventTouchUpInside];
//    playButton.backgroundColor=[UIColor redColor];
    [playButton setBackgroundImage:[UIImage imageNamed:@"item_play_btn"] forState:UIControlStateNormal];
    [self.view addSubview:playButton];
    
    [playButton setHidden:isHidden];

}

-(void)initPlalette:(CGFloat)width height:(CGFloat)height{
    myPlalette = [[Palette alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    myPlalette.tag = 1000;
    myPlalette.backgroundColor = [UIColor clearColor];
    [self.view addSubview:myPlalette];
    
    //画笔按钮
    isDraw = NO;
    drawButton = [[UIButton alloc]initWithFrame:CGRectMake(width - kDrawButtonRightWidth, kDrawButtonY, kDrawButtonWidth, kDrawButtonWidth)];
    [drawButton addTarget:self action:@selector(drawFlagAction:) forControlEvents:UIControlEventTouchUpInside];
//    drawButton.backgroundColor=[UIColor redColor];
    [drawButton setBackgroundImage:[UIImage imageNamed:@"item_draw_pen_btn.png"] forState:UIControlStateNormal];
    [drawButton setBackgroundImage:[UIImage imageNamed:@"item_draw_pen_btn_select2.png"] forState:UIControlStateHighlighted];
    [drawButton setBackgroundImage:[UIImage imageNamed:@"item_draw_pen_btn_select2.png"] forState:UIControlStateSelected];
    [self.view addSubview:drawButton];
    
    clearButton = [[UIButton alloc]initWithFrame:CGRectMake(width - kDrawButtonRightWidth, kDrawButtonY + kDrawButtonWidth + kDrawButtonUp, kDrawButtonWidth, kDrawButtonWidth)];
    [clearButton addTarget:self action:@selector(clearAction:) forControlEvents:UIControlEventTouchUpInside];
//    clearButton.backgroundColor=[UIColor blueColor];
    [clearButton setBackgroundImage:[UIImage imageNamed:@"item_draw_clear_btn2.png"] forState:UIControlStateNormal];
    [clearButton setBackgroundImage:[UIImage imageNamed:@"item_draw_clear_btn_select2.png"] forState:UIControlStateHighlighted];
    [self.view addSubview:clearButton];
    
    finallyRemoveButton = [[UIButton alloc]initWithFrame:CGRectMake(width - kDrawButtonRightWidth, kDrawButtonY + (kDrawButtonWidth + kDrawButtonUp)* 2 , kDrawButtonWidth, kDrawButtonWidth)];
    [finallyRemoveButton addTarget:self action:@selector(finallyRemoveAction:) forControlEvents:UIControlEventTouchUpInside];
//    finallyRemoveButton.backgroundColor=[UIColor greenColor];
    [finallyRemoveButton setBackgroundImage:[UIImage imageNamed:@"item_draw_back_btn.png"] forState:UIControlStateNormal];
    [finallyRemoveButton setBackgroundImage:[UIImage imageNamed:@"item_draw_back_btn_select2.png"] forState:UIControlStateHighlighted];
    [self.view addSubview:finallyRemoveButton];

}

-(void)finallyRemoveAction:(id)sender{
    [myPlalette myLineFinallyRemove];
}
-(void)clearAction:(id)sender{
    [myPlalette myalllineclear];
}

-(void)drawFlagAction:(id)sender{
    isDraw = !isDraw;
    if (isDraw == YES) {
        [drawButton setSelected:YES];
    } else {
        [drawButton setSelected:NO];
    }
}

-(void)setDrawButtonShow:(BOOL)isShow{
    [drawButton setHidden:!isShow];
    [clearButton setHidden:!isShow];
    [finallyRemoveButton setHidden:!isShow];
    [imageView setHidden:isShow];
    [leftButton setHidden:!isShow];
    [rightButton setHidden:!isShow];
    [imageShowView setHidden:!isShow];
    
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
        {
            //项目展示背景
//            imageBk = [UIImage imageNamed:@"xiangmuzhanshi.jpg"];
//            [imageView setImage:imageBk];
            
//            NSArray* section1 = @[@"0.jpg",@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg",@"6.jpg"];
            NSString *saveFilePath = [LocalFilePath getSessionPath:@"xiangmuzhanshi/"]; //保存文件的路径
            NSMutableArray * arrTemp = [LocalFilePath searchFileInDocumentDirctory:saveFilePath];
            _slideshowData =[NSMutableArray arrayWithObjects:arrTemp,nil,nil];
            [self setDrawButtonShow:YES];
            [imageShowView beginSlideShow];
            break;
        }
        case 1:
        {
            //剖面图
//            imageBk = [UIImage imageNamed:@"poumianzhanshi.jpg"];
//            [imageView setImage:imageBk];
//            NSArray* section1 = @[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg",@"6.jpg"];
            NSString *saveFilePath = [LocalFilePath getSessionPath:@"poumiantu/"]; //保存文件的路径
            NSMutableArray * arrTemp = [LocalFilePath searchFileInDocumentDirctory:saveFilePath];
            _slideshowData =[NSMutableArray arrayWithObjects:arrTemp,nil,nil];
            [self setDrawButtonShow:YES];
            [imageShowView beginSlideShow];
            break;
        }
        case 2:
        {
            //房型展示
//            imageBk = [UIImage imageNamed:@"huxingtu.jpg"];
//            [imageView setImage:imageBk];
//            NSArray* section1 = @[@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg",@"6.jpg"];
            NSString *saveFilePath = [LocalFilePath getSessionPath:@"fangxingzhanshi/"]; //保存文件的路径
            NSMutableArray * arrTemp = [LocalFilePath searchFileInDocumentDirctory:saveFilePath];
            _slideshowData =[NSMutableArray arrayWithObjects:arrTemp,nil,nil];
            [self setDrawButtonShow:YES];
            [imageShowView beginSlideShow];
            break;
        }
        case 3:
        {
            //物业展示
//            imageBk = [UIImage imageNamed:@"wuyezhanshi.jpg"];
//            [imageView setImage:imageBk];
//            NSArray* section1 = @[@"3.jpg",@"4.jpg",@"5.jpg",@"6.jpg"];
            NSString *saveFilePath = [LocalFilePath getSessionPath:@"wuyezhanshi/"]; //保存文件的路径
            NSMutableArray * arrTemp = [LocalFilePath searchFileInDocumentDirctory:saveFilePath];
            _slideshowData =[NSMutableArray arrayWithObjects:arrTemp,nil,nil];
            [self setDrawButtonShow:YES];
            [imageShowView beginSlideShow];
            break;
        }
        case 4:
        {
            //周边配套
//            imageBk = [UIImage imageNamed:@"zhoubianpeitao.jpg"];
//            [imageView setImage:imageBk];
//            NSArray* section1 = @[@"4.jpg",@"5.jpg",@"6.jpg"];
            NSString *saveFilePath = [LocalFilePath getSessionPath:@"zhoubianpeitao/"]; //保存文件的路径
            NSMutableArray * arrTemp = [LocalFilePath searchFileInDocumentDirctory:saveFilePath];
            _slideshowData =[NSMutableArray arrayWithObjects:arrTemp,nil,nil];
            [self setDrawButtonShow:YES];
            [imageShowView beginSlideShow];
            break;
        }
        case 5:
            //视频播放
            //视频预览图片
        {
//            [playButton setHidden:NO];
            [playButton removeFromSuperview];
            [self initPlay:NO];
            
            NSString *saveFilePath = [LocalFilePath getSessionPath:@"shipintupian/"]; //保存文件的路径
            NSMutableArray * arrTemp = [LocalFilePath searchFileInDocumentDirctory:saveFilePath];
            NSString *path1 = @"";
            if (arrTemp != nil && [arrTemp count] > 0) {

                for (NSString *path in arrTemp) {
                    if([[path pathExtension] isEqualToString:@"jpg"] || [[path pathExtension] isEqualToString:@"png"] || [[path pathExtension] isEqualToString:@"jpeg"]){
                        path1 = [[NSString alloc]initWithString:path];
                    }
                }
            }
            if ([path1 length] > 0) {
                imageBk=[[UIImage alloc]initWithContentsOfFile:path1];
            }else
                imageBk = [UIImage imageNamed:@"item_show_demo"];
            
            [imageView setImage:imageBk];
            [self setDrawButtonShow:NO];
            
            break;
        }

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
    if (isDraw == YES) {
        UITouch* touch=[touches anyObject];
        MyBeganpoint=[touch locationInView:self.view ];
        
        [myPlalette Introductionpoint4:1];
        [myPlalette Introductionpoint5:2];
        [myPlalette Introductionpoint1];
        [myPlalette Introductionpoint3:MyBeganpoint];
    }
		
//	NSLog(@"======================================");
//	NSLog(@"MyPalette Segment=%i",1);
}
//手指移动时候发出
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
//    NSLog(@"》》》》》》》》》》》》");
    if (isDraw == YES) {
        NSArray* MovePointArray=[touches allObjects];
        MyMovepoint=[[MovePointArray objectAtIndex:0] locationInView:myPlalette];
        [myPlalette Introductionpoint3:MyMovepoint];
        [myPlalette setNeedsDisplay];
    }
	
}
//当手指离开屏幕时候
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
//    NSLog(@"++++++++++++");
    if (isDraw == YES) {
        [myPlalette Introductionpoint2];
        [myPlalette setNeedsDisplay];
    }
	
}
//电话呼入等事件取消时候发出
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	//NSLog(@"touches Canelled");
}


-(void)PlayMovieAction:(id)sender{
    
    // NSLog(@"PlayMovieAction====");
    //视频文件路径，此视频已经存入项目包中。属于本地播放
    
    NSString *saveFilePath = [LocalFilePath getSessionPath:@"shipinzhanshi/"]; //保存文件的路径
    NSMutableArray * arrTemp = [LocalFilePath searchFileInDocumentDirctory:saveFilePath];
    NSString *path = @"";
    if (arrTemp != nil && [arrTemp count] > 0) {
        for (NSString *path1 in arrTemp) {
            if([[path1 pathExtension] isEqualToString:@"mp4"]){
                path = [[NSString alloc]initWithString:path1];
            }
    }
//        NSString *path = [arrTemp objectAtIndex:0];
        
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"Movie" ofType:@"m4v"];
        //视频URL
        NSURL *url = [NSURL fileURLWithPath:path];
        //视频播放对象
        movie = [[MPMoviePlayerController alloc] initWithContentURL:url];
        movie.controlStyle = MPMovieControlStyleFullscreen;
        [movie.view setFrame:CGRectMake(18, 20, 776, 661)];
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

    }else{
        
    }
    
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

#pragma mark - Datasource
-(NSUInteger)numberOfSectionsInSlideshow:(SLGSlideshowView*)slideShowView{
    
    return [_slideshowData count];
    
}
-(NSInteger)numberOfItems:(SLGSlideshowView*)slideShowView inSection:(NSUInteger)section{
    
    return [[_slideshowData objectAtIndex:section]count];
}
-(UIView*)viewForSlideShow:(SLGSlideshowView*)slideShowView atIndexPath:(NSIndexPath*)indexPath{
    
    NSString* imageName = [[_slideshowData objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
//    UIImage* img  = [UIImage imageNamed:imageName];
    //路径
    UIImage *img = [UIImage imageWithContentsOfFile:imageName];
    UIImageView* imageView = [[UIImageView alloc]initWithImage:img];
//    imageView.frame = CGRectMake(kItemShowImageX, kItemShowImageY, kItemShowImageW, kItemShowImageH);
//    imageView.contentMode = UIViewContentModeScaleAspectFill;
    return imageView;
}

-(NSTimeInterval)slideDurationForSlideShow:(SLGSlideshowView*)slideShowView atIndexPath:(NSIndexPath*)indexPath{
    
    // random time
//    return arc4random()%4;
    return 1;
    
}
-(NSTimeInterval)transitionDurationForSlideShow:(SLGSlideshowView*)slideShowView atIndexPath:(NSIndexPath*)indexPath{
    // random time
//    return (arc4random()%(4-1))+1;
    
    return 1;
}
-(NSUInteger)transitionStyleForSlideShow:(SLGSlideshowView*)slideShowView atIndexPath:(NSIndexPath*)indexPath{
    
    
    //random style
    NSUInteger rIndex = arc4random()%[_transitionOptions count];
    return [[_transitionOptions objectAtIndex:rIndex]integerValue];
    
}

#pragma mark - SlideShowDelegate
-(void)slideShowViewDidEnd:(SLGSlideshowView*)slideShowView willRepeat:(BOOL)willRepeat{
//    NSLog(@"%s",__PRETTY_FUNCTION__);
}
-(void)slideShowView:(SLGSlideshowView*)slideShowView willDisplaySlideAtIndexPath:(NSIndexPath*)indexPath{
//    NSLog(@"%s: %i : %i",__PRETTY_FUNCTION__,indexPath.section,indexPath.row);
}
-(void)slideShowView:(SLGSlideshowView*)slideShowView didDisplaySlideAtIndexPath:(NSIndexPath*)indexPath{
//    NSLog(@"%s: %i : %i",__PRETTY_FUNCTION__,indexPath.section,indexPath.row);
}
-(void)slideShowView:(SLGSlideshowView*)slideShowView willBeginSection:(NSUInteger)section{
//    NSLog(@"%s:%i",__PRETTY_FUNCTION__,section);
}
-(void)slideShowView:(SLGSlideshowView*)slideShowView didBeginSection:(NSUInteger)section{
//    NSLog(@"%s:%i",__PRETTY_FUNCTION__,section);
    
}
-(void)slideShowViewDidPause:(SLGSlideshowView*)slideShowView{
//    NSLog(@"%s",__PRETTY_FUNCTION__);
}
-(void)slideShowViewDidResume:(SLGSlideshowView*)slideShowView{
//    NSLog(@"%s",__PRETTY_FUNCTION__);
}


@end
