//
//  OANavigationBar.m
//  OAManager
//
//  Created by 百腾_nsm on 13-11-5.
//  Copyright (c) 2013年 百腾科技. All rights reserved.
//

#import "OANavigationBar.h"
#import "OAFont.h"

@implementation OANavigationBar

@synthesize title=_title;
@synthesize leftButton=_leftButton;
@synthesize rightButton=_rightButton;

-(void)dealloc
{
    [_contentView removeFromSuperview];
    [_contentView release];
    
    [_titleLabel removeFromSuperview];
    [_titleLabel release];
    
    [_title release];

    [super dealloc];
}

-(id)initWithFrame:(CGRect)frame BackImage:(UIImage *)backImage
{
    if(self=[super initWithFrame:frame])
    {
        _contentView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _contentView.userInteractionEnabled=YES;
        _contentView.backgroundColor=[UIColor clearColor];
        _contentView.image=backImage;
        [self addSubview:_contentView];
        
        _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(60, 0, frame.size.width-120, frame.size.height)];
        _titleLabel.backgroundColor=[UIColor clearColor];
        _titleLabel.font=fontDefaultTitleFont(21.0);
        _titleLabel.textColor=[UIColor whiteColor];
        _titleLabel.shadowColor=[UIColor blackColor];
        _titleLabel.shadowOffset=CGSizeMake(1.0, 0.0);
        _titleLabel.textAlignment=NSTextAlignmentCenter;
        [_contentView addSubview:_titleLabel];
    }
    return self;
}

-(UIButton *)rightButton
{
    return _rightButton;
}
-(UIButton *)leftButton
{
    return _leftButton;
}
-(NSString *)title
{
    return _title;
}

-(void)setLeftButton:(UIButton *)leftButton
{
    [_leftButton removeFromSuperview];
    [_leftButton release];
    _leftButton=[leftButton retain];
    
    _leftButton.frame=CGRectMake(5, (int)(self.frame.size.height-leftButton.frame.size.height)/2, leftButton.frame.size.width, leftButton.frame.size.height);
    [_contentView addSubview:_leftButton];
}

-(void)setRightButton:(UIButton *)rightButton
{
    [_rightButton removeFromSuperview];
    [_rightButton release];
    _rightButton=[rightButton retain];
    
    _rightButton.frame=CGRectMake(self.frame.size.width-(5+rightButton.frame.size.width), (int)(self.frame.size.height-rightButton.frame.size.height)/2, rightButton.frame.size.width, rightButton.frame.size.height);
    [_contentView addSubview:_rightButton];
}

-(void)setTitle:(NSString *)title
{
    [_title release];
    _title = [title retain];
    
    _titleLabel.text = title;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

@end
