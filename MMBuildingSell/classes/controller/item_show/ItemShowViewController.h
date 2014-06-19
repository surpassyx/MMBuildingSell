//
//  ItemShowViewController.h
//  MMBuildingSell
//
//  Created by 3G组 on 13-10-14.
//  Copyright (c) 2013年 Y.X. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Palette.h"
#import <QuartzCore/QuartzCore.h>
#import "MediaPlayer/MPMoviePlayerController.h"
#import "SLGSlideshowView.h"


@interface ItemShowViewController : UIViewController<UINavigationControllerDelegate,SLGSlideshowViewDatasource,SLGSlideshowViewDelegate>
{
    //画板
    Palette * myPlalette;
    CGPoint MyBeganpoint;
	CGPoint MyMovepoint;
    
    //切换图片框体
    
    //切换图片按钮
    UIButton * leftButton;
    UIButton * rightButton;
    SLGSlideshowView * imageShowView;
    
    UIImageView *imageView;
    UIImageView *imageFrameView;
    //内容图片
    UIImage * imageBk;
    //框体图片
    UIImage * imageFrameBk;
    
    //视频控制器
    MPMoviePlayerController *movie;
    //播放按钮
    UIButton* playButton;
    
    //画板按钮
    UIButton* drawButton;
    UIButton* clearButton;
    UIButton* finallyRemoveButton;
    //画画标识
    BOOL isDraw;
}

@end
