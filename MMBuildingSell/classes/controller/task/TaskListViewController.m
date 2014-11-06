//
//  TaskListViewController.m
//  MMBuildingSell
//
//  Created by 3G组 on 13-11-20.
//  Copyright (c) 2013年 Y.X. All rights reserved.
//

#import "TaskListViewController.h"
#import "TaskCell.h"
#import "TaskDetailViewController.h"
#define TABLE_HEIGHT 80

#import "AFNetworking.h"

@interface TaskListViewController ()

@property (nonatomic, retain) NSMutableArray* arrayForPlaces;

@end

@implementation TaskListViewController

@synthesize dataList;

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
            NSMutableArray *arrInfo = [jsonDic objectForKey:@"arr"];
            for (int i = 0; i < arrInfo.count ; i++) {
                NSDictionary *dicInfo = [arrInfo objectAtIndex:i];
                NSString * strTaskId = [dicInfo objectForKey:@"ftaskid"];
                NSString * strTaskTitle =[dicInfo objectForKey:@"ftasktitle"];
                NSString * strContent = [dicInfo objectForKey:@"fcontent"];
                NSString * strTaskTime = [dicInfo objectForKey:@"ftasktime"];
                NSString * strFirstRelease = [dicInfo objectForKey:@"ffirstrelease"];
                NSString * strHowLong = [dicInfo objectForKey:@"fhowlong"];
                NSString * strUpexecute = [dicInfo objectForKey:@"fupexecute"];
                NSString * strResult = [dicInfo objectForKey:@"fresult"];
                NSString * strRoutes = [dicInfo objectForKey:@"froutes"];
                NSString * strId = [dicInfo objectForKey:@"id"];

                NSMutableDictionary *rowData = [[NSMutableDictionary alloc]init];
                [rowData setValue:strTaskId forKey:@"ftaskid"];
                [rowData setValue:strTaskTitle forKey:@"ftasktitle"];
                [rowData setValue:strContent forKey:@"fcontent"];
                [rowData setValue:strTaskTime forKey:@"ftasktime"];
                [rowData setValue:strFirstRelease forKey:@"ffirstrelease"];
                [rowData setValue:strHowLong forKey:@"fhowlong"];
                [rowData setValue:strUpexecute forKey:@"fupexecute"];
                [rowData setValue:strResult forKey:@"fresult"];
                [rowData setValue:strRoutes forKey:@"froutes"];
                [rowData setValue:strId forKey:@"id"];
                [self.dataList addObject:rowData];
            }
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

-(void)getHttpInfo
{
    //http://www.ykhome.cn/myhome/gettask.php?&fenterisecode=P0001&finstallment=01&ftask=all
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * strUrl = [[NSString alloc]initWithFormat:@"http://www.ykhome.cn/myhome/gettask.php?&fenterisecode=%@&finstallment=%@&ftask=all",[userDefaults objectForKey:@"enterpriseCode"],[userDefaults objectForKey:@"installment"]];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:strUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [self analysisJson:(NSDictionary *)responseObject];
        [self.myTable reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"SampleData" ofType:@"plist"];
    NSMutableDictionary *plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    self.arrayForPlaces = [plistDict objectForKey:@"Data"];
    
    self.title = @"任务列表";
    
    UIButton * rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,22,22)];
    [rightButton setImage:[UIImage imageNamed:@"task_close_btn2.png"]forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(close)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem= rightItem;

    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(close)];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [self getHttpInfo];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TABLE_HEIGHT;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TaskCell *cell = (TaskCell*) [tableView dequeueReusableCellWithIdentifier:@"TaskCell"];
    if(cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TaskCell" owner:[TaskCell class] options:nil];
        cell = (TaskCell *)[nib objectAtIndex:0];
        cell.contentView.backgroundColor = [UIColor clearColor];
    }
    
//    NSDictionary* dict = [self.arrayForPlaces objectAtIndex:indexPath.row];
    NSMutableDictionary *rowData = [self.dataList objectAtIndex:indexPath.row];
    cell.tittleTask.text = [NSString stringWithFormat:@"%@",[rowData objectForKey:@"ftasktitle"]];
    cell.timeTask.text = [NSString stringWithFormat:@"%@",[rowData objectForKey:@"ftasktime"]];
//    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[dict objectForKey:@"Image"]]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect cellFrameInTableView = [tableView rectForRowAtIndexPath:indexPath];
    CGRect cellFrameInSuperview = [tableView convertRect:cellFrameInTableView toView:[tableView superview]];
    
    TaskDetailViewController* detailViewController = [[TaskDetailViewController alloc] initWithNibName:@"TaskDetailViewController" bundle:nil];
    
    NSMutableDictionary* dict = [self.dataList objectAtIndex:indexPath.row];
    detailViewController.dictForData = dict;
    detailViewController.yOrigin = cellFrameInSuperview.origin.y;
    [self.navigationController pushViewController:detailViewController animated:NO];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
