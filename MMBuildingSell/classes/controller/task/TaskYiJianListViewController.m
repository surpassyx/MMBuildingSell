//
//  TaskYiJianListViewController.m
//  MMBuildingSell
//
//  Created by Daisy on 15/1/15.
//  Copyright (c) 2015年 Y.X. All rights reserved.
//

#import "TaskYiJianListViewController.h"
#import "AFNetworking.h"
#import "TaskYiJianCell.h"

@interface TaskYiJianListViewController (){
    NSString * taskIdStr;
}

@end

@implementation TaskYiJianListViewController
@synthesize dataList;

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

-(void)analysisJson:(NSDictionary *)jsonDic
{
    //    NSError *error;
    //    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:date options:NSJSONReadingMutableLeaves error:&error];
    NSString * strSign = [jsonDic objectForKey:@"sign"];
    int intString = [strSign intValue];
    if (intString == 1) {
        [self.dataList removeAllObjects];
        NSMutableArray *arrInfo = [jsonDic objectForKey:@"arr"];
        for (int i = 0; i < arrInfo.count ; i++) {
            NSDictionary *dicInfo = [arrInfo objectAtIndex:i];
            NSString * strResult = [dicInfo objectForKey:@"result"];
            NSString * strUpexecute = [dicInfo objectForKey:@"upexecute"];
            NSString * strFollowMan = [dicInfo objectForKey:@"followMan"];
            NSString * strTaskTime = [dicInfo objectForKey:@"tasktime"];
            NSString * strNotion = [dicInfo objectForKey:@"notion"];
            
            
            NSMutableDictionary *rowData = [[NSMutableDictionary alloc]init];
            [rowData setValue:strResult forKey:@"result"];
            [rowData setValue:strUpexecute forKey:@"upexecute"];
            [rowData setValue:strFollowMan forKey:@"followMan"];
            [rowData setValue:strTaskTime forKey:@"tasktime"];
            [rowData setValue:strNotion forKey:@"notion"];
            
            [self.dataList addObject:rowData];
        }
    }else{
        NSLog(@"服务端返回错误");
    }
    
}

-(void)getHttpInfo
{
    NSString * strUrl = [[NSString alloc]initWithFormat:@"action=8&taskid=%@",taskIdStr];
    NSString * hexUrl  = [Utility hexStringFromString:strUrl];
    NSLog(@"updateUrl=%@",API_BASE_URL(hexUrl));
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:API_BASE_URL(hexUrl) parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
    self.dataList = [[NSMutableArray alloc]init];
    
    self.title = @"意见";
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TaskYiJianCell *cell = (TaskYiJianCell*) [tableView dequeueReusableCellWithIdentifier:@"TaskYiJianCell"];
    if(cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TaskYiJianCell" owner:[TaskYiJianCell class] options:nil];
        cell = (TaskYiJianCell *)[nib objectAtIndex:0];
        cell.contentView.backgroundColor = [UIColor clearColor];
    }
    
    //    NSDictionary* dict = [self.arrayForPlaces objectAtIndex:indexPath.row];
    NSMutableDictionary *rowData = [self.dataList objectAtIndex:indexPath.row];
    cell.tittleTask.text = [NSString stringWithFormat:@"【%@】%@",[rowData objectForKey:@"result"],[rowData objectForKey:@"upexecute"]];
    cell.timeTask.text = [NSString stringWithFormat:@"%@",[rowData objectForKey:@"tasktime"]];
    cell.contentTask.text = [NSString stringWithFormat:@"%@",[rowData objectForKey:@"notion"]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
