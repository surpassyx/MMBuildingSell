//
//  ProfileViewController.m
//  QQ空间-HD
//
//  Created by apple on 13-9-12.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "ProfileViewController.h"
#import "AFNetworking.h"
#import "ProfileCell.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"楼盘期别选择";
    
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 720, 700)];
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    
    [self.view addSubview:self.myTableView];
    
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
            NSString * strName = [dicInfo objectForKey:@"name"];
            NSString * strTel =[dicInfo objectForKey:@"tel"];
            NSString * strType = [dicInfo objectForKey:@"type"];
            NSString * strGetway = [dicInfo objectForKey:@"getway"];
            NSString * strPurpose = [dicInfo objectForKey:@"purpose"];
            NSString * strWorkplace =[dicInfo objectForKey:@"workplace"];
            NSString * strTrade = [dicInfo objectForKey:@"trade"];
            
            NSMutableArray *arrRemarkTemp = [dicInfo objectForKey:@"arr"];
            
            NSMutableArray *arrRemark = [[NSMutableArray alloc]init];
            for (int j = 0; j < arrRemarkTemp.count; j++) {
                NSMutableDictionary *arrRemarkDic = [[NSMutableDictionary alloc]init];
                NSDictionary *dicInfo = [arrRemarkTemp objectAtIndex:i];
                NSString * strRemark = [dicInfo objectForKey:@"remark"];
                NSString * strDate =[dicInfo objectForKey:@"date"];
                [arrRemarkDic setValue:strRemark forKey:@"remark"];
                [arrRemarkDic setValue:strDate forKey:@"date"];
                [arrRemark addObject:arrRemarkDic];
            }
            
            NSMutableDictionary *rowData = [[NSMutableDictionary alloc]init];
            [rowData setValue:strName forKey:@"name"];
            [rowData setValue:strTel forKey:@"tel"];
            [rowData setValue:strType forKey:@"type"];
            [rowData setValue:strGetway forKey:@"getway"];
            [rowData setValue:strPurpose forKey:@"purpose"];
            [rowData setValue:strWorkplace forKey:@"workplace"];
            [rowData setValue:strTrade forKey:@"trade"];
            [rowData setValue:arrRemark forKey:@"remark"];
            
            //            [arrAd addObject:rowData];
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
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * strUrl = [[NSString alloc]initWithFormat:@"http://erp.lncct.com/Mobile/Interface.aspx?no=%@&enterpriseCode=%@",[userDefaults objectForKey:@"no"],[userDefaults objectForKey:@"enterpriseCode"]];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:strUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [self analysisJson:(NSDictionary *)responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ProfileCell *cell = (ProfileCell*) [tableView dequeueReusableCellWithIdentifier:@"ProfileCell"];
    if(cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ProfileCell" owner:[ProfileCell class] options:nil];
        cell = (ProfileCell *)[nib objectAtIndex:0];
        cell.contentView.backgroundColor = [UIColor clearColor];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%d期",[indexPath row]];
    
    //    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[dict objectForKey:@"Image"]]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:@"Nib name" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    delegate.nPhase = indexPath.row;
    
}

@end
