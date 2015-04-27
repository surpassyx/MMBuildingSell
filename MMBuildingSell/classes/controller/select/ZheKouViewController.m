//
//  ZheKouViewController.m
//  MMBuildingSell
//
//  Created by Daisy on 15/1/21.
//  Copyright (c) 2015年 Y.X. All rights reserved.
//

#import "ZheKouViewController.h"

@interface ZheKouViewController ()

@end

@implementation ZheKouViewController

@synthesize dataList,dataZheKouArr;

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *okItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(okAction)];
    [okItem setTintColor:[UIColor grayColor]];
    self.navigationItem.rightBarButtonItem = okItem;
    
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    [cancelItem setTintColor:[UIColor grayColor]];
    self.navigationItem.leftBarButtonItem = cancelItem;
    
    self.dataList = [[NSMutableArray alloc]init];
    self.dataZheKouArr = [[NSMutableArray alloc]init];
    
    self.myTable.dataSource = self;
    self.myTable.delegate = self;
    [self.myTable setEditing:YES animated:YES];
    self.myTable.allowsSelectionDuringEditing = YES;
    
    [self getHttpInfo];
    self.title = @"折扣计算";
}
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedPushContent:) name:@"PUSHCONTENT" object:nil];
//}
//
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"PUSHCONTENT" object:nil];
//}
//
//- (void)receivedPushContent:(NSNotification*)notification{
//    NSString *content = [notification object];
//    [XWAlterview showmessage:@"新消息" subtitle:content cancelbutton:@"确定"];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)okAction{
    [self.dataZheKouArr removeAllObjects];
    for (NSMutableDictionary *rowData in self.dataList) {
        if ([[rowData objectForKey:@"select"]  isEqual: @1]){
            [self.dataZheKouArr addObject:rowData];
        }
    }
    [self.delegate addZheKou:self.dataZheKouArr];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getHttpInfo
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * strUrl = [[NSString alloc]initWithFormat:@"action=15&enterpriseCode=%@&installment=%@",[userDefaults objectForKey:@"enterpriseCode"],[userDefaults objectForKey:@"installment"]];
    NSString * hexUrl  = [Utility hexStringFromString:strUrl];
    NSLog(@"zhekouUrl=%@",API_BASE_URL(hexUrl));
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:API_BASE_URL(hexUrl) parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        //{"sign":"1","arr":[{"no":"301307885102","name":"开盘优惠","calculatMethod":"1","discount":"1.00","fee":"0.00"},{"no":"301307902419","name":"老客户优惠","calculatMethod":"2","discount":"98.00","fee":"0.00"},{"no":"301307935233","name":"领导特批","calculatMethod":"3","discount":"0.00","fee":"20000.00"},{"no":"301307965784","name":"内部折扣","calculatMethod":"4","discount":"0.00","fee":"100.00"}]}
        
        NSString * strSign = [responseObject objectForKey:@"sign"];
        int intString = [strSign intValue];
        if (intString == 1) {
            [self.dataList removeAllObjects];
            NSMutableArray *arrInfo = [responseObject objectForKey:@"arr"];
            for (int i = 0; i < arrInfo.count ; i++) {
                NSDictionary *dicInfo = [arrInfo objectAtIndex:i];
                NSString * strNo = [dicInfo objectForKey:@"no"];
                NSString * strName =[dicInfo objectForKey:@"name"];
                NSString * strCalculatMethod = [dicInfo objectForKey:@"calculatMethod"];
                NSString * strDiscount =[dicInfo objectForKey:@"discount"];
                NSString * strFee =[dicInfo objectForKey:@"fee"];
                
                NSMutableDictionary *rowData = [[NSMutableDictionary alloc]init];
                [rowData setValue:strNo forKey:@"no"];
                [rowData setValue:strName forKey:@"name"];
                [rowData setValue:strCalculatMethod forKey:@"calculatMethod"];
                [rowData setValue:strDiscount forKey:@"discount"];
                [rowData setValue:strFee forKey:@"fee"];
                [rowData setValue:@0 forKey:@"select"];
                
                [self.dataList addObject:rowData];
            }
        }else{
            NSLog(@"服务端返回错误");
        }

        [self.myTable reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)
sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSUInteger fromRow = [sourceIndexPath row];
    NSUInteger toRow = [destinationIndexPath row];
    
    id object = [self.dataList objectAtIndex:fromRow];
    [self.dataList removeObjectAtIndex:fromRow];
    [self.dataList insertObject:object atIndex:toRow];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    UIView *v = nil;
    v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    [v setBackgroundColor:[UIColor clearColor]];
    
    UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 49.0f, self.view.frame.size.width, 1.0f)];
    [bgview setBackgroundColor:[UIColor blackColor]];
    [v addSubview:bgview];

    
    UILabel *namelable = [[UILabel alloc] initWithFrame:CGRectMake(50 + 30, 10, 200, 25)];
    [namelable setBackgroundColor:[UIColor clearColor]];
    namelable.textAlignment = NSTextAlignmentCenter;
    namelable.text = @"折扣名称";
    [v addSubview:namelable];
    
    UILabel *calculatMethodlable = [[UILabel alloc] initWithFrame:CGRectMake(260 + 30, 10, 100, 25)];
    [calculatMethodlable setBackgroundColor:[UIColor clearColor]];
    calculatMethodlable.textAlignment = NSTextAlignmentCenter;
    calculatMethodlable.text = @"计算方法";
    [v addSubview:calculatMethodlable];
    
    UILabel *discountlable = [[UILabel alloc] initWithFrame:CGRectMake(370 + 30, 10, 100, 25)];
    [discountlable setBackgroundColor:[UIColor clearColor]];
    discountlable.textAlignment = NSTextAlignmentCenter;
    discountlable.text = @"折扣(%)";
    [v addSubview:discountlable];
    
    UILabel *feelable = [[UILabel alloc] initWithFrame:CGRectMake(480 + 30, 10, 100, 25)];
    [feelable setBackgroundColor:[UIColor clearColor]];
    feelable.textAlignment = NSTextAlignmentCenter;
    feelable.text = @"优惠金额";
    [v addSubview:feelable];
    
    return v;

    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *rowData = [self.dataList objectAtIndex:indexPath.row];
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    //config the cell
    
    UIImageView *checkSign = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 30, 30)];
    
    if ([[rowData objectForKey:@"select"]  isEqual: @0])
    {
        checkSign.image = [UIImage imageNamed:@"unchecked.png"];
    }
    else
    {
        checkSign.image = [UIImage imageNamed:@"checked.png"];
    }
    
    [cell.contentView addSubview:checkSign];

    UILabel * namelable = [[UILabel alloc]initWithFrame:CGRectMake(50, 10, 200, 25)];
    namelable.text = [rowData objectForKey:@"name"];
    namelable.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:namelable];
    
    NSString * strTemp = [rowData objectForKey:@"calculatMethod"];
    NSString * strTemp2 = @"";
    if ([@"1" isEqualToString:strTemp] == YES) {
        strTemp2 = @"减点";
    } else if([@"2" isEqualToString:strTemp] == YES){
        strTemp2 =  @"打折";
    } else if([@"3" isEqualToString:strTemp] == YES){
        strTemp2 =  @"总价优惠";
    } else if([@"4" isEqualToString:strTemp] == YES){
        strTemp2 =  @"单价优惠";
    }

    UILabel * calculatMethodlable = [[UILabel alloc]initWithFrame:CGRectMake(260, 10, 100, 25)];
    calculatMethodlable.text = strTemp2;
    calculatMethodlable.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:calculatMethodlable];
    
    UILabel * discountlable = [[UILabel alloc]initWithFrame:CGRectMake(370, 10, 100, 25)];
    discountlable.text = [rowData objectForKey:@"discount"];
    discountlable.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:discountlable];
    
    UILabel * feelable = [[UILabel alloc]initWithFrame:CGRectMake(480, 10, 100, 25)];
    feelable.text = [rowData objectForKey:@"fee"];
    feelable.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:feelable];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *oneCell = [tableView cellForRowAtIndexPath: indexPath];
//    if (oneCell.accessoryType == UITableViewCellAccessoryNone) {
//        oneCell.accessoryType = UITableViewCellAccessoryCheckmark;
//    } else
//        oneCell.accessoryType = UITableViewCellAccessoryNone;
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSMutableDictionary *rowData = [self.dataList objectAtIndex:indexPath.row];
    
    if ([[rowData objectForKey:@"select"]  isEqual: @0])
    {
        [rowData setValue:@1 forKey:@"select"];
        
    }
    else
    {
        [rowData setValue:@0 forKey:@"select"];
        
    }
    [self.dataList replaceObjectAtIndex:indexPath.row withObject:rowData];
    [self.myTable reloadData];
}

@end
