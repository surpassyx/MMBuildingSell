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

@interface ItemShowViewController : UIViewController<UINavigationControllerDelegate>
{
    Palette * myPlalette;
    CGPoint MyBeganpoint;
	CGPoint MyMovepoint;
    
    UIImageView *imageView;
    
    UIImage * imageBk;
}

@end
