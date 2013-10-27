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

@interface ItemShowViewController : UIViewController<UINavigationControllerDelegate>
{
    //画板
    Palette * myPlalette;
    CGPoint MyBeganpoint;
	CGPoint MyMovepoint;
    
    UIImageView *imageView;
    //背景图片
    UIImage * imageBk;
    
    //视频控制器
    MPMoviePlayerController *movie;
    //播放按钮
    UIButton* playButton;
}

@end
