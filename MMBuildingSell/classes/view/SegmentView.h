//
//  SegmentView.h
//  QQ空间-HD
//
//  Created by apple on 13-9-12.
//  Copyright (c) 2013年 itcast. All rights reserved.
//  

#import <UIKit/UIKit.h>

@class SegmentView;

@protocol SegmentViewDelegate <NSObject>
- (void)segmentView:(SegmentView *)segmentView didSelectedSegmentAtIndex:(int)index;
@end

@interface SegmentView : UIView

- (id)initWithTitles:(NSArray *)titles;

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, weak) id<SegmentViewDelegate> delegate;

@end