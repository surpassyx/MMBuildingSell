//
//  HouseInfoCell.h
//  MMBuildingSell
//
//  Created by 3G组 on 13-10-22.
//  Copyright (c) 2013年 Y.X. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIGridViewCell.h"

@interface HouseInfoCell : UIGridViewCell
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
@property (weak, nonatomic) IBOutlet UILabel *roomNo;
@property (weak, nonatomic) IBOutlet UILabel *priceSquareMeter;

@end
