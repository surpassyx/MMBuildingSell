//
//  TaskSendViewController.m
//  MMBuildingSell
//
//  Created by 3G组 on 13-11-14.
//  Copyright (c) 2013年 Y.X. All rights reserved.
//

#import "TaskSendViewController.h"
#import "AFNetworking.h"
#import "TaskPersonListViewController.h"

@interface TaskSendViewController ()<AddPersonDelegate>{
    NSString * upexecuteNameStr;
    NSString * upexecuteIdStr;
    NSMutableArray * followManArr;
}

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
- (IBAction)taskTimeBtnAction:(id)sender {
    
}
- (IBAction)addFollowBtnAction:(id)sender {
    TaskPersonListViewController* listViewController = [[TaskPersonListViewController alloc] initWithNibName:@"TaskPersonListViewController" bundle:nil];
    listViewController.nType = 2;
    listViewController.delegate = self;
    [self.navigationController pushViewController:listViewController animated:NO];

}
- (IBAction)subFollowBtnAction:(id)sender {
    if ([followManArr count] > 0) {
        [followManArr removeLastObject];
    }
    [self showFollowMan];
}
- (IBAction)upexecuteBtnAction:(id)sender {
    TaskPersonListViewController* listViewController = [[TaskPersonListViewController alloc] initWithNibName:@"TaskPersonListViewController" bundle:nil];
    listViewController.nType = 1;
    listViewController.delegate = self;
    [self.navigationController pushViewController:listViewController animated:NO];

}
- (IBAction)okBtnAction:(id)sender {
    if ([self isReadyToUpdate]) {
        
        NSString * strFollowManText = @"";
        
        [self getHttpInfo:self.taskTitle.text
                  content:self.contentTextView.text
                fTaskTime:self.taskTimeBtn.titleLabel.text
               fupexecute:self.upexecuteBtn.titleLabel.text
                 fhowlong:self.howLong.text
                followMan:strFollowManText
                   notion:self.notionTextField.text];
    }else{
        
    }
}
- (IBAction)cancelBtnAction:(id)sender {
    [self close];
}

-(BOOL)isReadyToUpdate
{
    if (self.taskTitle.text.length <= 0) {
        return NO;
    }
    if (self.howLong.text.length <= 0) {
        return NO;
    }
    if (self.contentTextView.text.length <= 0) {
        return NO;
    }
    if (self.taskTimeBtn.titleLabel.text.length <= 0) {
        return NO;
    }
    if (self.upexecuteBtn.titleLabel.text.length <= 0  || [self.followManBtn.titleLabel.text isEqualToString:@"点击设置人员"]) {
        return NO;
    }
    
    return YES;
}
-(void)analysisJson:(NSDictionary *)jsonDic
{
    //    NSError *error;
    //    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:date options:NSJSONReadingMutableLeaves error:&error];
    NSString * strSign = [jsonDic objectForKey:@"sign"];
    int intString = [strSign intValue];
    if (intString == 1) {
       
        [self close];
    }else{
        NSLog(@"服务端返回错误");
    }
    
}

-(void)getHttpInfo:(NSString *)taskTitle
           content:(NSString *)strContent
         fTaskTime:(NSString *)strTime
        fupexecute:(NSString *)strUpexecute
          fhowlong:(NSString *)strHowLong
           followMan:(NSString *)strFollowMan
            notion:(NSString *)strNotion
{
    //http://218.24.45.194:9001/Action?action=6&tasktitle=加强销售管控&content=人力资源管理与物流管理内容&tasktime=2014-05-03&firstrelease=9&upexecute=203101844937&howlong=3&result=2&followMan=2,9&notion=请尽快完成该任务内容
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString * strUrl = [[NSString alloc]initWithFormat:@"action=6&tasktitle=%@&content=%@&tasktime=%@&firstrelease=%@&upexecute=%@&howlong=%@&result=2&followMan=%@&notion=%@",taskTitle,strContent,strTime,[userDefaults objectForKey:@"usercode"],strUpexecute,strHowLong,strFollowMan,strNotion];
    NSString * hexUrl  = [Utility hexStringFromString:strUrl];
    NSLog(@"tasksendUrl=%@",API_BASE_URL(hexUrl));
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:API_BASE_URL(hexUrl) parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
    [self.firstReleaseBtn setText:[[NSUserDefaults standardUserDefaults] objectForKey:@"username"]];
    
    UIButton * rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,22,22)];
    [rightButton setImage:[UIImage imageNamed:@"task_close_btn2.png"]forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(close)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem= rightItem;
    
    followManArr = [[NSMutableArray alloc]init];
    
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

-(void)addPerson:(NSString *)userId name:(NSString *)username type:(int)nType
{
    if (nType == 1) {
//        self.title = @"选择责任人";
        upexecuteNameStr = username;
        upexecuteIdStr = userId;
        [self.upexecuteBtn setTitle:username forState:UIControlStateNormal];
    }else{
//        self.title = @"选择跟踪人";
        NSMutableDictionary *rowData = [[NSMutableDictionary alloc]init];
        [rowData setValue:userId forKey:@"userid"];
        [rowData setValue:username forKey:@"username"];
        [followManArr addObject:rowData];
        [self showFollowMan];
    }
}

-(void)showFollowMan
{
    if ([followManArr count] == 0) {
        [self.followManBtn setTitle:@"暂无" forState:UIControlStateNormal];
    }else{
        NSString * strBtn = @"";
        for (NSMutableDictionary *rowData in followManArr) {
            NSString * strTemp = [rowData objectForKey:@"username"];
            strBtn = [strBtn stringByAppendingString:strTemp];
            strBtn = [strBtn stringByAppendingString:@","];
        }
        NSString *b = [strBtn substringToIndex:([strBtn length] - 1)];
        [self.followManBtn setTitle:b forState:UIControlStateNormal];
    }
    
}

@end
