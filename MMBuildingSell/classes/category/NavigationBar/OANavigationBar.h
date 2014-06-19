//
//  OANavigationBar.h
//  OAManager
//
//  Created by 百腾_nsm on 13-11-5.
//  Copyright (c) 2013年 百腾科技. All rights reserved.
//

/*
 * 自定义NavgationBar
 */

#import "OABaseView.h"

@interface OANavigationBar : OABaseView

{
    UIImageView * _contentView;
    UILabel * _titleLabel;
}

/**
 *自定义bar上的标题
 */
@property (nonatomic,retain) NSString * title;
/**
 *左侧的按钮，需使用是传入，没有返回nil
 */
@property (nonatomic,retain) UIButton * leftButton;
/**
 *右侧的按钮，需使用是传入，没有返回nil
 */
@property (nonatomic,retain) UIButton * rightButton;

/**
 *frame：bar的frame
 *backImage：bar的背景图片
 */
-(id)initWithFrame:(CGRect)frame BackImage:(UIImage *)backImage;


@end
