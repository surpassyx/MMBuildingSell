//
//  TaskPersonListViewController.m
//  MMBuildingSell
//
//  Created by Daisy on 14/12/23.
//  Copyright (c) 2014年 Y.X. All rights reserved.
//

#import "TaskPersonListViewController.h"

@interface TaskPersonListViewController ()

@end

@implementation TaskPersonListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.dataList = [[NSMutableArray alloc]init];
    
    self.myTable.dataSource = self;
    self.myTable.delegate = self;
    
    if (self.nType == 1) {
        self.title = @"选择责任人";
    }else{
        self.title = @"选择跟踪人";
    }
    [self getHttpInfo];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSMutableDictionary *rowData = [self.dataList objectAtIndex:indexPath.row];
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    //config the cell
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[rowData objectForKey:@"username"]];
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
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    [self close];
     NSMutableDictionary *rowData = [self.dataList objectAtIndex:indexPath.row];
    
    [self.delegate addPerson:[rowData objectForKey:@"userid"] name:[rowData objectForKey:@"username"] type:self.nType];
    [self.navigationController popViewControllerAnimated:YES];
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
            NSString * strUserId = [dicInfo objectForKey:@"userid"];
            NSString * strUserName =[dicInfo objectForKey:@"username"];
            
            
            NSMutableDictionary *rowData = [[NSMutableDictionary alloc]init];
            [rowData setValue:strUserId forKey:@"userid"];
            [rowData setValue:strUserName forKey:@"username"];
            
            [self.dataList addObject:rowData];
        }
    }else{
        NSLog(@"服务端返回错误");
    }
    
}

- (void)getInfoSuccess
{
    
}

-(void)getHttpInfo
{
    //http://218.24.45.194:9001/Action?action=5&enterisecode=SYHDMD&installment=02
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * strUrl = [[NSString alloc]initWithFormat:@"action=5&enterisecode=%@&installment=%@",[userDefaults objectForKey:@"enterpriseCode"],@"02"];
    NSLog(@"taskpersonUrl=%@",strUrl);
    NSString * hexUrl  = [Utility hexStringFromString:strUrl];
    NSLog(@"taskpersonUrl=%@",API_BASE_URL(hexUrl));
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:API_BASE_URL(hexUrl) parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [self analysisJson:(NSDictionary *)responseObject];
        [self.myTable reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}

#pragma mark close
- (void)close
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
