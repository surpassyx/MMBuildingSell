//
//  IconView.m
//  QQ空间-HD
//
//  Created by apple on 13-9-11.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "IconView.h"
#import <QuartzCore/QuartzCore.h>

#define kIconMaxWidth 100
#define kIconMaxHeight 100

@implementation IconView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.layer.cornerRadius = 5;
        self.imageView.layer.masksToBounds = YES;
        
        NSString *saveFilePath = [LocalFilePath getSessionPath:@"xiangmulogo/"]; //保存文件的路径
        NSMutableArray * arrTemp = [LocalFilePath searchFileInDocumentDirctory:saveFilePath];
        NSString *path1 = @"";
        UIImage * imageBK;
        if (arrTemp != nil && [arrTemp count] > 0) {
            
            for (NSString *path in arrTemp) {
                if([[path pathExtension] isEqualToString:@"jpg"] || [[path pathExtension] isEqualToString:@"png"] || [[path pathExtension] isEqualToString:@"jpeg"]){
                    path1 = [[NSString alloc]initWithString:path];
                }
            }
        }
        if ([path1 length] > 0) {
            imageBK=[[UIImage alloc]initWithContentsOfFile:path1];
        }else
            imageBK = [UIImage imageNamed:@"head_icon.jpg"];
        [self setImage:imageBK forState:UIControlStateNormal];
        
        NSString * strTemp =[[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
        [self setTitle:strTemp forState:UIControlStateNormal];
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        //设置背景
//        [self setBackgroundColor:[UIColor whiteColor]];
        //设置字体颜色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
}

- (void)rotateToOrientation:(UIInterfaceOrientation)orientation
{
    // 1.设置整个头像的frame
    CGFloat width = self.superview.frame.size.width;
    self.frame = CGRectMake(0, 0, width, width);
    
    // 2.根据方向隐藏文字
    NSString * strTemp =[[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    
    NSString *title = UIInterfaceOrientationIsPortrait(orientation)?nil:strTemp;
    [self setTitle:title forState:UIControlStateNormal];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height)];
    [label setText:[[NSUserDefaults standardUserDefaults] objectForKey:@"enterpriseNameinstallmentName"]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:label];
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    
    CGFloat iconWidth = contentRect.size.width;
    if (iconWidth > kIconMaxWidth) {
        CGFloat imgX = (iconWidth - kIconMaxWidth) * 0.5;
        CGFloat imgY = 40;
        return CGRectMake(imgX, imgY, kIconMaxWidth, kIconMaxHeight);
    } else {
        CGFloat imgX = 10;
        CGFloat imgY = 10;
        CGFloat imgWidth = iconWidth - 2 * imgX;
        return CGRectMake(imgX, imgY, imgWidth, imgWidth);
    }
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleY = 150;
    CGFloat titleWidth = contentRect.size.width;
    CGFloat titleHeight = 50;
    return CGRectMake(titleX, titleY, titleWidth, titleHeight);
}

@end
