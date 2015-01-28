//
//  MessageListViewController.m
//  MMBuildingSell
//
//  Created by Daisy on 15/1/28.
//  Copyright (c) 2015年 Y.X. All rights reserved.
//

#import "MessageListViewController.h"
#import "MessageCell.h"

@interface MessageListViewController ()

@end

@implementation MessageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.dataList = [[NSMutableArray alloc]init];
    
    self.myTable.dataSource = self;
    self.myTable.delegate = self;
    
    self.title = @"消息列表";
    
    UIButton * rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,22,22)];
    [rightButton setImage:[UIImage imageNamed:@"task_close_btn2.png"]forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(close)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem= rightItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    MessageCell *cell = (MessageCell*) [tableView dequeueReusableCellWithIdentifier:@"MessageCell"];
    if(cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MessageCell" owner:[MessageCell class] options:nil];
        cell = (MessageCell *)[nib objectAtIndex:0];
        cell.contentView.backgroundColor = [UIColor clearColor];
    }
    
    NSMutableDictionary *rowData = [self.dataList objectAtIndex:indexPath.row];
    cell.messageTitle.text = [NSString stringWithFormat:@"%@",[rowData objectForKey:@"title"]];
    cell.messageContent.text = [NSString stringWithFormat:@"%@",[rowData objectForKey:@"content"]];
    cell.messageSendManCn.text = [NSString stringWithFormat:@"%@",[rowData objectForKey:@"sendManCn"]];
    cell.messageSendTime.text = [NSString stringWithFormat:@"%@",[rowData objectForKey:@"sendTime"]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    CGRect cellFrameInTableView = [tableView rectForRowAtIndexPath:indexPath];
    //    CGRect cellFrameInSuperview = [tableView convertRect:cellFrameInTableView toView:[tableView superview]];
    //
    //    TaskDetailViewController* detailViewController = [[TaskDetailViewController alloc] initWithNibName:@"TaskDetailViewController" bundle:nil];
    //
    //    NSMutableDictionary* dict = [self.dataList objectAtIndex:indexPath.row];
    //    detailViewController.dictForData = dict;
    //    detailViewController.yOrigin = cellFrameInSuperview.origin.y;
    //    [self.navigationController pushViewController:detailViewController animated:NO];
    //
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //    [self close];

}

-(void)analysisJson:(NSDictionary *)jsonDic
{
    NSString * strSign = [jsonDic objectForKey:@"sign"];
    int intString = [strSign intValue];
    if (intString == 1) {
        [self.dataList removeAllObjects];
        NSMutableArray *arrInfo = [jsonDic objectForKey:@"arr"];
        for (int i = 0; i < arrInfo.count ; i++) {
            NSDictionary *dicInfo = [arrInfo objectAtIndex:i];
            NSString * strTitle = [dicInfo objectForKey:@"title"];
            NSString * strContent =[dicInfo objectForKey:@"content"];
            NSString * strSendTime =[dicInfo objectForKey:@"sendTime"];
            NSString * strSendManCn =[dicInfo objectForKey:@"sendManCn"];
            
            
            NSMutableDictionary *rowData = [[NSMutableDictionary alloc]init];
            [rowData setValue:strTitle forKey:@"title"];
            [rowData setValue:strContent forKey:@"content"];
            [rowData setValue:strSendTime forKey:@"sendTime"];
            [rowData setValue:strSendManCn forKey:@"sendManCn"];
            
            [self.dataList addObject:rowData];
        }
    }else{
        NSLog(@"服务端返回错误");
    }
    
}

-(void)getHttpInfo
{
    //http://218.24.45.194:9001/Action?action=5&enterisecode=SYHDMD&installment=02
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * strUrl = [[NSString alloc]initWithFormat:@"action=17&userNo=%@",[userDefaults objectForKey:@"usercode"]];
    NSLog(@"messageUrl=%@",strUrl);
    NSString * hexUrl  = [Utility hexStringFromString:strUrl];
    NSLog(@"messageUrl=%@",API_BASE_URL(hexUrl));
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:API_BASE_URL(hexUrl) parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [self analysisJson:(NSDictionary *)responseObject];
        [self.myTable reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}


@end
