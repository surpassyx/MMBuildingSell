//
//  TaskSendViewController.h
//  MMBuildingSell
//
//  Created by 3G组 on 13-11-14.
//  Copyright (c) 2013年 Y.X. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskSendViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *taskTitle;
@property (strong, nonatomic) IBOutlet UIButton *taskTimeBtn;
@property (strong, nonatomic) IBOutlet UITextField *howLong;
@property (strong, nonatomic) IBOutlet UIButton *upexecuteBtn;
@property (strong, nonatomic) IBOutlet UIButton *followManBtn;
@property (strong, nonatomic) IBOutlet UILabel *firstReleaseBtn;
@property (strong, nonatomic) IBOutlet UITextField *notionTextField;
@property (strong, nonatomic) IBOutlet UITextView *contentTextView;
@property (strong, nonatomic) IBOutlet UIButton *addFollowManBtn;
@property (strong, nonatomic) IBOutlet UIButton *subFollowManBtn;

@end
