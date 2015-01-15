//
//  TaskToViewController.h
//  MMBuildingSell
//
//  Created by Daisy on 15/1/15.
//  Copyright (c) 2015年 Y.X. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskToViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *upexecuteBtn;
@property (strong, nonatomic) IBOutlet UIButton *followManBtn;

@property (strong, nonatomic) IBOutlet UITextView *contentTextView;
@property (strong, nonatomic) IBOutlet UIButton *addFollowManBtn;
@property (strong, nonatomic) IBOutlet UIButton *subFollowManBtn;

@property (strong, nonatomic) IBOutlet UIButton *okBtn;
@property (strong, nonatomic) IBOutlet UIButton *cancelBtn;

@property (strong, nonatomic) IBOutlet UILabel *stateLabel;
@property (strong, nonatomic) IBOutlet UISwitch *stateSwitch;

@property (strong, nonatomic) IBOutlet UILabel *Label1;
@property (strong, nonatomic) IBOutlet UILabel *Label2;

-(void)initTaskId:(NSString *)strId;
@end
