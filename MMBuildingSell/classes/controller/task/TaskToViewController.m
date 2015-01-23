//
//  TaskToViewController.m
//  MMBuildingSell
//
//  Created by Daisy on 15/1/15.
//  Copyright (c) 2015年 Y.X. All rights reserved.
//

#import "TaskToViewController.h"
#import "AFNetworking.h"
#import "TaskPersonListViewController.h"

@interface TaskToViewController ()<AddPersonDelegate>{
    NSString * upexecuteNameStr;
    NSString * upexecuteIdStr;
    NSMutableArray * followManArr;
    NSString * taskIdStr;
}


@end

@implementation TaskToViewController

-(void)initTaskId:(NSString *)strId
{
    taskIdStr = strId;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
        
        NSString * strFollowManText = [self getFollowManStr];
        NSString * strTemp = @"2";
        NSString * strTemp2 = upexecuteIdStr;
        if (self.stateSwitch.on == NO) {
            strTemp = @"3";
            strFollowManText = @"";
            strTemp2 = @"";
        }
        [self getHttpInfo:taskIdStr result:strTemp fupexecute:strTemp2 followMan:strFollowManText notion:self.contentTextView.text];

    }else{
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"数据填写不全" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alter show];
    }
}
- (IBAction)cancelBtnAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(BOOL)isReadyToUpdate
{
    if (self.contentTextView.text.length <= 0) {
        return NO;
    }
    if (self.stateSwitch.on == YES) {
        if (self.upexecuteBtn.titleLabel.text.length <= 0  || [self.followManBtn.titleLabel.text isEqualToString:@"点击设置人员"]) {
            return NO;
        }
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


-(void)getHttpInfo:(NSString *)taskId
            result:(NSString *)strResult
        fupexecute:(NSString *)strUpexecute
         followMan:(NSString *)strFollowMan
            notion:(NSString *)strNotion
{
    //http://www.gytaobao.cn:9006/FC/Action?action=9&taskid=311203608859&result=2&upexecute=203101844937&followMan=2&notion=请尽快完成该任务内容1
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * strUrl = [[NSString alloc]initWithFormat:@"action=9&taskid=%@&result=%@&firstrelease=%@&upexecute=%@&followMan=%@&notion=%@",taskId,strResult,[userDefaults objectForKey:@"usercode"],strUpexecute,strFollowMan,strNotion];
    NSString * hexUrl  = [Utility hexStringFromString:strUrl];
    NSLog(@"taskToUrl=%@",API_BASE_URL(strUrl));
    
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
    self.title = @"办理任务";
    
    [self.stateSwitch addTarget:self action:@selector(switchAction:)forControlEvents:UIControlEventValueChanged];
    
    UIButton * rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,22,22)];
    [rightButton setImage:[UIImage imageNamed:@"task_close_btn2.png"]forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(close)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem= rightItem;
    
    followManArr = [[NSMutableArray alloc]init];
    
}

-(void)switchAction:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        self.stateLabel.text = @"转办";
        [self.upexecuteBtn setHidden:NO];
        [self.followManBtn setHidden:NO];
        [self.addFollowManBtn setHidden:NO];
        [self.subFollowManBtn setHidden:NO];
        [self.Label1 setHidden:NO];
        [self.Label2 setHidden:NO];
        
    }else {
        self.stateLabel.text = @"结束";
        [self.upexecuteBtn setHidden:YES];
        [self.followManBtn setHidden:YES];
        [self.addFollowManBtn setHidden:YES];
        [self.subFollowManBtn setHidden:YES];
        [self.Label1 setHidden:YES];
        [self.Label2 setHidden:YES];
    }
}

#pragma mark close
- (void)close
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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

-(NSString *)getFollowManStr
{
    if ([followManArr count] == 0) {
        return @"";
    }else{
        NSString * strBtn = @"";
        for (NSMutableDictionary *rowData in followManArr) {
            NSString * strTemp = [rowData objectForKey:@"userid"];
            strBtn = [strBtn stringByAppendingString:strTemp];
            strBtn = [strBtn stringByAppendingString:@","];
        }
        NSString *b = [strBtn substringToIndex:([strBtn length] - 1)];
        return b;
    }
}


@end
