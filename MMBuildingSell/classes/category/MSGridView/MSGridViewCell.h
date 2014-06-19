//
//  MSGridViewCell.h
//  Shareight
//
//  Created by Martin Saunders on 06/08/2013.
//  Copyright (c) 2013 TBC Digital. All rights reserved.
//

#import <UIKit/UIKit.h>
#define contentbuffer 12
#define contentbuffer2 2
@interface MSGridViewCell : UIView <UIGestureRecognizerDelegate>
@property (nonatomic,strong) NSString *reuseIdentifier;
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UILabel *contentLabel;
- (id)initWithFrame:(CGRect)frame
    reuseIdentifier:(NSString *)identifier
    tittleContent:(NSString *)tittle;
@end
