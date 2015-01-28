//
//  MessageCell.h
//  MMBuildingSell
//
//  Created by Daisy on 15/1/28.
//  Copyright (c) 2015年 Y.X. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *messageTitle;
@property (weak, nonatomic) IBOutlet UILabel *messageContent;
@property (weak, nonatomic) IBOutlet UILabel *messageSendTime;
@property (weak, nonatomic) IBOutlet UILabel *messageSendManCn;

@end
