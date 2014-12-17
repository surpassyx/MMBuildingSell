//
//  CustomerDetailView.m
//  MMBuildingSell
//
//  Created by 3G组 on 13-11-11.
//  Copyright (c) 2013年 Y.X. All rights reserved.
//

#import "CustomerDetailView.h"


@implementation CustomerDetailView

@synthesize noLabel,nameLabel,sexLabel,statusLabel,telLabel,roomtypeLabel,livingspaceLabel,ownerLabel,producttypeLabel;
@synthesize callvisitLabel,getwayLabel,usernameLabel,bugdetLabel,intentionLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

//- (void) awakeFromNib
//{
//    [super awakeFromNib];
//    
//    [[NSBundle mainBundle] loadNibNamed:@"CustomerDetailView" owner:self options:nil];
//    [self addSubview:self.view];
//}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

//- (IBAction)addRemark:(id)sender {
//    if (remarkTextField.text.length > 0) {
//        [self.dataDetailList addObject:remarkTextField.text];
//        [tableJIlu reloadData];
//    }
//}
@end
