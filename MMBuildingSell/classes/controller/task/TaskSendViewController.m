//
//  TaskSendViewController.m
//  MMBuildingSell
//
//  Created by 3G组 on 13-11-14.
//  Copyright (c) 2013年 Y.X. All rights reserved.
//

#import "TaskSendViewController.h"
#import "AFNetworking.h"

@interface TaskSendViewController ()

@end

@implementation TaskSendViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)analysisJson:(NSDictionary *)jsonDic
{
    //    NSError *error;
    //    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:date options:NSJSONReadingMutableLeaves error:&error];
    NSString * strSign = [jsonDic objectForKey:@"sign"];
    int intString = [strSign intValue];
    if (intString == 1) {
       
    
    }else{
        NSLog(@"服务端返回错误");
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // 3.2.让整个登录界面停止跟用户交互
        self.view.userInteractionEnabled = NO;
        
        // 3.3.通过定时器跳到主界面
        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(getInfoSuccess) userInfo:nil repeats:NO];
        
        //        [self setADScrollView];
    });
}

- (void)getInfoSuccess
{
    
}

-(void)getHttpInfo:(NSString *)taskId
        fTaskTitle:(NSString *)taskTitle
           content:(NSString *)strContent
         fTaskTime:(NSString *)strTime
     ffirstrelease:(NSString *)strFirstRelease
        fupexecute:(NSString *)strUpexecute
          fhowlong:(NSString *)strHowLong
           fresult:(NSString *)strResult
{
    //指派谁
    //标题
    //时间
    //内容
    //http://www.ykhome.cn/myhome/settask.php?fenterisecode=P0001&finstallment=01&ftaskid=20140503&ftasktitle=加强销售管控&fcontent=人力资源管理与物流管理内容&ftasktime=2014-05-03&ffirstrelease=张三&fupexecute=刘五&fhowlong=3天&fresult=开始
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * strUrl = [[NSString alloc]initWithFormat:@"http://www.ykhome.cn/myhome/settask.php?fenterisecode=%@&finstallment=%@&ftaskid=%@&ftasktitle=%@&fcontent=%@&ftasktime=%@&ffirstrelease=%@&fupexecute=%@&fhowlong=%@&fresult=%@",[userDefaults objectForKey:@"enterpriseCode"],[userDefaults objectForKey:@"installment"],taskId,taskTitle,strContent,strTime,strFirstRelease,strUpexecute,strHowLong,strResult];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:strUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [self analysisJson:(NSDictionary *)responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"发布任务";
    
    
    UIButton * rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,22,22)];
    [rightButton setImage:[UIImage imageNamed:@"task_close_btn2.png"]forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(close)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem= rightItem;

    
//    UIImage *closeimage=[UIImage imageNamed:@"task_close_btn.png"];
//    
//    UIBarButtonItem *barbtn = [[UIBarButtonItem alloc] initWithTitle:@"  关  闭  " style:UIBarButtonItemStylePlain target:self action:@selector(close)];
//    
//    barbtn.image = closeimage;
//    
//    self.navigationItem.rightBarButtonItem = barbtn;
    
}

#pragma mark close
- (void)close
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
