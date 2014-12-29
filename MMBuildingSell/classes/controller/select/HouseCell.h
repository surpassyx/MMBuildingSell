//
//  HouseCell.h
//  MMBuildingSell
//
//  Created by Daisy on 14/12/26.
//  Copyright (c) 2014年 Y.X. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HouseCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *roomName;
@property (strong, nonatomic) IBOutlet UILabel *roomCode;
@property (strong, nonatomic) IBOutlet UILabel *roomType;
@property (strong, nonatomic) IBOutlet UILabel *allAres;
@property (strong, nonatomic) IBOutlet UILabel *roomState;

@end
