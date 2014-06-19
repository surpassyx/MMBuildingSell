//
//  HouseInfoCell.m
//  MMBuildingSell
//
//  Created by 3G组 on 13-10-22.
//  Copyright (c) 2013年 Y.X. All rights reserved.
//

#import "HouseInfoCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation HouseInfoCell

- (id)init {
	
    if (self = [super init]) {
		
        self.frame = CGRectMake(0, 0, 140, 60);
		
		NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"HouseInfoCell" owner:self options:nil];
        
        self.view =[nib objectAtIndex:0];
		
        [self addSubview:self.view];
		
	}
	
    return self;
	
}

//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        // Initialization code
//    }
//    return self;
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
