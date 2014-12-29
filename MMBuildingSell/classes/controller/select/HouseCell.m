//
//  HouseCell.m
//  MMBuildingSell
//
//  Created by Daisy on 14/12/26.
//  Copyright (c) 2014年 Y.X. All rights reserved.
//

#import "HouseCell.h"

@implementation HouseCell
@synthesize roomCode,roomName,roomState,roomType,allAres;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
