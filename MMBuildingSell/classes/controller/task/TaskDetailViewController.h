//
//  TaskDetailViewController.h
//  MMBuildingSell
//
//  Created by 3G组 on 13-11-20.
//  Copyright (c) 2013年 Y.X. All rights reserved.
//

#import <UIKit/UIKit.h>
#define MAIN_LABEL_Y_ORIGIN 0
#define IMAGEVIEW_Y_ORIGIN 15

@interface TaskDetailViewController : UIViewController


@property (retain, nonatomic) IBOutlet UIButton *doneBtn;
@property (retain, nonatomic) IBOutlet UITextView *textviewForDetail;


@property (retain, nonatomic) IBOutlet UILabel *labelForTaskid;
@property (retain, nonatomic) IBOutlet UILabel *labelForTasktitle;
@property (retain, nonatomic) IBOutlet UILabel *labelForTasktime;
@property (retain, nonatomic) IBOutlet UILabel *labelForFirstrelease;
@property (retain, nonatomic) IBOutlet UILabel *labelForUpexecute;
@property (retain, nonatomic) IBOutlet UILabel *labelForHowlong;
@property (retain, nonatomic) IBOutlet UILabel *labelForResult;


@property (readwrite, nonatomic) int yOrigin;
@property (retain, nonatomic) NSMutableDictionary *dictForData;




- (IBAction)doneBtnPressed:(id)sender;

- (IBAction)toDoBtnPressed:(id)sender;

- (IBAction)yijianBtnPressed:(id)sender;

@end
