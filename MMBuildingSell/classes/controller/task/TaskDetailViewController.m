//
//  TaskDetailViewController.m
//  MMBuildingSell
//
//  Created by 3G组 on 13-11-20.
//  Copyright (c) 2013年 Y.X. All rights reserved.
//

#import "TaskDetailViewController.h"

@interface TaskDetailViewController ()

@end

@implementation TaskDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.labelForPlace.text = [NSString stringWithFormat:@"%@",[self.dictForData objectForKey:@"Place"]];
//    self.labelForCountry.text = [NSString stringWithFormat:@"%@",[self.dictForData objectForKey:@"Country"]];
//    self.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[self.dictForData objectForKey:@"Image"]]];
    
    NSString * strTaskId = [self.dictForData objectForKey:@"taskid"];
    NSString * strTaskTitle =[self.dictForData objectForKey:@"tasktitle"];
    NSString * strContent = [self.dictForData objectForKey:@"content"];
    NSString * strTaskTime = [self.dictForData objectForKey:@"tasktime"];
    NSString * strFirstRelease = [self.dictForData objectForKey:@"firstrelease"];
    NSString * strHowLong = [self.dictForData objectForKey:@"howlong"];
    NSString * strUpexecute = [self.dictForData objectForKey:@"upexecute"];
    NSString * strResult = [self.dictForData objectForKey:@"result"];
    
    [self.labelForTaskid setText:strTaskId];
    [self.labelForTasktitle setText:strTaskTitle];
    [self.textviewForDetail setText:strContent];
    [self.labelForTasktime setText:strTaskTime];
    [self.labelForFirstrelease setText:strFirstRelease];
    [self.labelForUpexecute setText:strUpexecute];
    [self.labelForHowlong setText:strHowLong];
    [self.labelForResult setText:strResult];
    
    
    [self animateOnEntry];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) animateOnEntry
{
    //set initial frames
//    self.backgroundImageView.alpha = 0;
//    self.backgroundImageView.frame = CGRectMake(0, self.yOrigin + MAIN_LABEL_Y_ORIGIN, self.view.frame.size.width, self.labelForPlace.frame.size.height + self.labelForCountry.frame.size.height);
//    self.labelForPlace.frame = CGRectMake(70, self.yOrigin + MAIN_LABEL_Y_ORIGIN, self.labelForPlace.frame.size.width, self.labelForPlace.frame.size.height);
//    self.labelForCountry.frame = CGRectMake(70, self.labelForPlace.frame.origin.y + self.labelForPlace.frame.size.height, self.labelForCountry.frame.size.width, self.labelForCountry.frame.size.height);
    self.doneBtn.frame = CGRectMake(self.doneBtn.frame.origin.x, 0-self.doneBtn.frame.size.height-20, self.doneBtn.frame.size.width, self.doneBtn.frame.size.height);
    self.textviewForDetail.alpha = 0;
    self.textviewForDetail.frame = CGRectMake(self.textviewForDetail.frame.origin.x, self.textviewForDetail.frame.size.height + self.view.frame.size.height, self.textviewForDetail.frame.size.width, self.textviewForDetail.frame.size.height);
    
    //apply animation on ENTERING INTO THE VIEW
    [UIView animateWithDuration:0.4f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^(void)
     {
//         self.labelForPlace.frame = CGRectMake(35, 180, self.labelForPlace.frame.size.width, self.labelForPlace.frame.size.height);
//         self.labelForCountry.frame = CGRectMake(35, 250, self.labelForCountry.frame.size.width, self.labelForCountry.frame.size.height);
         self.doneBtn.frame = CGRectMake(self.doneBtn.frame.origin.x, 20, self.doneBtn.frame.size.width, self.doneBtn.frame.size.height);
//         self.backgroundImageView.frame = CGRectMake(0, 0, self.view.frame.size.width, 300);
//         self.backgroundImageView.alpha = 1;
         
         self.textviewForDetail.frame = CGRectMake(self.textviewForDetail.frame.origin.x, self.view.frame.size.height - self.textviewForDetail.frame.size.height, self.textviewForDetail.frame.size.width, self.textviewForDetail.frame.size.height);
         self.textviewForDetail.alpha = 1;
         
        
     }
                     completion:NULL];
}

- (IBAction)doneBtnPressed:(id)sender
{
    //animation on EXIT FROM CURRENT VIEW
    [UIView animateWithDuration:0.4f animations:^
     {
//         self.backgroundImageView.frame = CGRectMake(0, self.yOrigin + MAIN_LABEL_Y_ORIGIN, self.view.frame.size.width, self.labelForPlace.frame.size.height + self.labelForCountry.frame.size.height);
//         self.labelForPlace.frame = CGRectMake(70, self.yOrigin + MAIN_LABEL_Y_ORIGIN, self.labelForPlace.frame.size.width, self.labelForPlace.frame.size.height);
//         self.labelForCountry.frame = CGRectMake(70, self.labelForPlace.frame.origin.y + self.labelForPlace.frame.size.height, self.labelForCountry.frame.size.width, self.labelForCountry.frame.size.height);
         self.doneBtn.frame = CGRectMake(self.doneBtn.frame.origin.x, 0-self.doneBtn.frame.size.height-20, self.doneBtn.frame.size.width, self.doneBtn.frame.size.height);
         self.textviewForDetail.frame = CGRectMake(self.textviewForDetail.frame.origin.x, self.textviewForDetail.frame.size.height + self.view.frame.size.height, self.textviewForDetail.frame.size.width, self.textviewForDetail.frame.size.height);
         self.textviewForDetail.alpha = 0;
//         self.backgroundImageView.alpha = 0;
     }
                     completion:^(BOOL finished)
     {
         [self.navigationController popViewControllerAnimated:NO];
     }
     ];
}



@end
