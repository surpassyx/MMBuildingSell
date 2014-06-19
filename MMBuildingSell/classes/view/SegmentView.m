//
//  SegmentView.m
//  QQ空间-HD
//
//  Created by apple on 13-9-12.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#define kBtnWidth 90
#define kBtnHeight 46

#import "SegmentView.h"

@interface MyButton: UIButton
@end

@implementation MyButton
- (void)setHighlighted:(BOOL)highlighted{}
@end

@interface SegmentView()
{
    UIButton *_currentBtn;
}
@end

@implementation SegmentView

- (id)initWithTitles:(NSArray *)titles
{
    if (self = [super init]) {
        self.titles = titles;
    }
    return self;
}

- (void)btnDown:(UIButton *)btn
{
    _currentBtn.selected = NO;
    btn.selected = YES;
    _currentBtn = btn;
    
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(segmentView:didSelectedSegmentAtIndex:)]) {
        [self.delegate segmentView:self didSelectedSegmentAtIndex:btn.tag];
    }
}

- (void)setTitles:(NSArray *)titles
{
    // 数组内容一致，直接返回
    if ([titles isEqualToArray:_titles]) return;
        
    _titles = titles;
    
    //[UIView beginAnimations:nil context:nil];
    
    // 1.移除所有的按钮
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // 2.添加新的按钮
    int count = titles.count;
    
    for (int i = 0; i<count; i++) {
        MyButton *btn = [MyButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        
        // 设置按钮的frame
        btn.frame = CGRectMake(i * kBtnWidth, 0, kBtnWidth, kBtnHeight);
        
        // 设置按钮图片
        NSString *normal = nil;
        NSString *selected = nil;
        normal = @"SegmentedButton_Normal";
        selected = @"SegmentedButton_Selected@2x";
//        if (i == 0) { // 左边
//            normal = @"SegmentedControl_Left_Normal.png";
//            selected = @"SegmentedControl_Left_Selected.png";
//        } else if (i == count - 1) { // 右边
//            normal = @"SegmentedControl_Right_Normal.png";
//            selected = @"SegmentedControl_Right_Selected.png";
//        } else { // 中间
//            normal = @"SegmentedControl_Normal.png";
//            selected = @"SegmentedControl_Selected.png";
//        }
        [btn setBackgroundImage:[UIImage resizeImage:normal] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage resizeImage:selected] forState:UIControlStateSelected];
        
        // 设置文字
        // btn.adjustsImageWhenHighlighted = NO;
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        // 设置监听器
        [btn addTarget:self action:@selector(btnDown:) forControlEvents:UIControlEventTouchDown];
        // 设置选中
        if (i == 0) {
            [self btnDown:btn];
        }
        
        // 添加按钮
        [self addSubview:btn];
    }
    
    self.bounds = CGRectMake(0, 0, count * kBtnWidth, kBtnHeight);
    
    //[UIView commitAnimations];
}
@end
