//
//  CustomerDetailView.m
//  MMBuildingSell
//
//  Created by 3G组 on 13-11-11.
//  Copyright (c) 2013年 Y.X. All rights reserved.
//

#import "CustomerDetailView.h"
#import "AFNetworking.h"


@implementation CustomerDetailView

@synthesize noLabel,nameLabel,sexLabel,statusLabel,telLabel,roomtypeLabel,livingspaceLabel,ownerLabel,producttypeLabel;
@synthesize callvisitLabel,getwayLabel,usernameLabel,bugdetLabel,intentionLabel;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


-(void)initCustomNo:(NSString *)strNo
{
    strCustomNo = strNo;
    self.myTable.dataSource = self;
    self.myTable.delegate = self;
    self.dataList = [[NSMutableArray alloc]init];
    [self getHttpInfo];
    self.remarkTextField.delegate = self;
}

//- (void) awakeFromNib
//{
//    [super awakeFromNib];
//    
//    [[NSBundle mainBundle] loadNibNamed:@"CustomerDetailView" owner:self options:nil];
//    [self addSubview:self.view];
//}

//开始编辑输入框的时候，软键盘出现，执行此事件
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [delegate moveUpCustomerDetailView:textField];
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 32 - (self.frame.size.height - 352 - 30);//键盘高度216
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
        self.frame = CGRectMake(AddBtnWIDTH, -offset, self.frame.size.width, self.frame.size.height);
    
    [UIView commitAnimations];
}

//当用户按下return键或者按回车键，keyboard消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [delegate moveDownCustomerDetailView:textField];
    self.frame =CGRectMake(AddBtnWIDTH, 2, self.frame.size.width, self.frame.size.height);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

//- (IBAction)addRemark:(id)sender {
//    if (remarkTextField.text.length > 0) {
//        [self.dataDetailList addObject:remarkTextField.text];
//        [tableJIlu reloadData];
//    }
//}
- (IBAction)setDateAction:(id)sender {
    
    
//                                       [self.setDateBtn setTitle:timestamp forState:UIControlStateNormal];
//    NSDate *date=[NSDate dateWithTimeIntervalSinceNow:9000000];
    NSDate *myDate = [NSDate date];
    _pickview=[[ZHPickView alloc] initDatePickWithDate:myDate datePickerMode:UIDatePickerModeDateAndTime isHaveNavControler:NO];
    _pickview.delegate=self;
    
    [_pickview show];
}

#pragma mark ZhpickVIewDelegate

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    NSLog(@"%@",resultString);
    [self.setDateBtn setTitle:resultString forState:UIControlStateNormal];
}


- (IBAction)deleteAction:(id)sender
{
     NSLog(@"删除");
    
    XWAlterview *alter=[[XWAlterview alloc]initWithTitle:@"提示" contentText:@"确定要删除？" leftButtonTitle:@"确定" rightButtonTitle:@"取消"];
    alter.rightBlock=^()
    {
        //        NSLog(@"右边按钮被点击");
    };
    alter.leftBlock=^()
    {
        //        NSLog(@"左边按钮被点击");
        NSString * strUrl = [[NSString alloc]initWithFormat:@"action=21&customno=%@",strCustomNo];
        
        NSString * hexUrl  = [Utility hexStringFromString:strUrl];
        NSLog(@"hexurl: %@", API_BASE_URL(hexUrl));
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:API_BASE_URL(hexUrl) parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"JSON: %@", responseObject);
            NSString * strSign = [responseObject objectForKey:@"sign"];
            int intString = [strSign intValue];
            if (intString == 1) {
                [delegate removeCustomer];
            }else{
                XWAlterview *alter=[[XWAlterview alloc]initWithTitle:@"删除失败" contentText:[responseObject objectForKey:@"error"] leftButtonTitle:@"确定" rightButtonTitle:nil];
                alter.rightBlock=^()
                {
                    //        NSLog(@"右边按钮被点击");
                };
                alter.leftBlock=^()
                {
                    //        NSLog(@"左边按钮被点击");
                };
                alter.dismissBlock=^()
                {
                    //        NSLog(@"窗口即将消失");
                };
                [alter show];
                return;
                
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            XWAlterview *alter=[[XWAlterview alloc]initWithTitle:@"删除失败" contentText:error.description leftButtonTitle:@"确定" rightButtonTitle:nil];
            alter.rightBlock=^()
            {
                //        NSLog(@"右边按钮被点击");
            };
            alter.leftBlock=^()
            {
                //        NSLog(@"左边按钮被点击");
            };
            alter.dismissBlock=^()
            {
                //        NSLog(@"窗口即将消失");
            };
            [alter show];
            return;
            
        }];

    };
    alter.dismissBlock=^()
    {
        //        NSLog(@"窗口即将消失");
    };
    [alter show];
    
    
    
    
}

-(void)addZhuiZong{
    NSString * callvisitStr =[self.callvisitSeg titleForSegmentAtIndex:[self.callvisitSeg selectedSegmentIndex]];
    //    NSString * callDateStr = self.setDateBtn.titleLabel.text;
    NSString * callNoteStr = self.remarkTextField.text;
    
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    
    NSString *  callDateStr = [dateformatter stringFromDate:senddate];
    
    if ([callvisitStr length] > 0 &&  [callDateStr length] > 0 &&  [callNoteStr length] > 0 && [callDateStr isEqualToString:@"点击设置来访日期"] == NO ) {
        
        NSString * strUrl = [[NSString alloc]initWithFormat:@"action=19&customno=%@&callvisit=%@&calldate=%@&callnote=%@",strCustomNo,callvisitStr,callDateStr,callNoteStr];
        if ([self.setDateBtn.titleLabel.text isEqualToString:@"设置提醒时间"] == NO && [self.tixingTextField.text length]>0) {
            NSString * strTemp = [[NSString alloc]initWithFormat:@"&reminddate=%@&remindcontent=%@",self.setDateBtn.titleLabel.text,self.tixingTextField.text];
            strUrl = [strUrl stringByAppendingString:strTemp];
        }
        
        NSString * hexUrl  = [Utility hexStringFromString:strUrl];
        NSLog(@"hexurl: %@", API_BASE_URL(hexUrl));
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:API_BASE_URL(hexUrl) parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"JSON: %@", responseObject);
            NSString * strSign = [responseObject objectForKey:@"sign"];
            int intString = [strSign intValue];
            if (intString == 1) {
                NSMutableDictionary *rowData = [[NSMutableDictionary alloc]init];
                [rowData setValue:callvisitStr forKey:@"callvisit"];
                [rowData setValue:callDateStr forKey:@"calldate"];
                [rowData setValue:callNoteStr forKey:@"callnote"];
                
                [self.dataList addObject:rowData];
                
                [self.myTable reloadData];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
        
    }else{
        [XWAlterview showmessage:@"提示" subtitle:@"数据填写不全" cancelbutton:@"确定"];
    }

}

- (IBAction)addZhuiZongAction:(id)sender {
    [self addZhuiZong];
    
}

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
    NSString * strTemp = [[NSString alloc]initWithFormat:@"客户来源：%@  日期：%@  说明：%@",[rowData objectForKey:@"callvisit"],[rowData objectForKey:@"calldate"],[rowData objectForKey:@"callnote"]];
    cell.textLabel.text = strTemp;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSMutableDictionary *rowData = [self.dataList objectAtIndex:indexPath.row];
        NSLog(@"---%@",[rowData objectForKey:@"customsubno"]);
        NSString * strUrl = [[NSString alloc]initWithFormat:@"action=20&customsubno=%@",[rowData objectForKey:@"customsubno"]];
        
        
        NSString * hexUrl  = [Utility hexStringFromString:strUrl];
        NSLog(@"url: %@", API_BASE_URL(hexUrl));
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:API_BASE_URL(hexUrl) parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"JSON: %@", responseObject);
            NSString * strSign = [responseObject objectForKey:@"sign"];
            int intString = [strSign intValue];
            if (intString == 1) {
                [self.dataList removeObjectAtIndex:indexPath.row];
                // Delete the row from the data source.
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            }else{
                XWAlterview *alter=[[XWAlterview alloc]initWithTitle:@"提示" contentText:[responseObject objectForKey:@"error"] leftButtonTitle:@"确定" rightButtonTitle:nil];
                alter.rightBlock=^()
                {
                    //        NSLog(@"右边按钮被点击");
                };
                alter.leftBlock=^()
                {
                    //        NSLog(@"左边按钮被点击");
                };
                alter.dismissBlock=^()
                {
                    //        NSLog(@"窗口即将消失");
                };
                [alter show];
                return;
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];

        
        
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
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
            NSString * strCustomsubno = [dicInfo objectForKey:@"customsubno"];
            NSString * strCallvisit = [dicInfo objectForKey:@"callvisit"];
            NSString * strCallDate =[dicInfo objectForKey:@"calldate"];
            NSString * strCallNote =[dicInfo objectForKey:@"callnote"];
            
            NSMutableDictionary *rowData = [[NSMutableDictionary alloc]init];
            [rowData setValue:strCustomsubno forKey:@"customsubno"];
            [rowData setValue:strCallvisit forKey:@"callvisit"];
            [rowData setValue:strCallDate forKey:@"calldate"];
            [rowData setValue:strCallNote forKey:@"callnote"];
            
            [self.dataList addObject:rowData];
        }
    }else{
        NSLog(@"服务端返回错误");
    }
    
}

-(void)getHttpInfo
{
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * strUrl = [[NSString alloc]initWithFormat:@"action=18&customNo=%@",strCustomNo];
    NSLog(@"genzongUrl=%@",strUrl);
    NSString * hexUrl  = [Utility hexStringFromString:strUrl];
    NSLog(@"genzongUrl=%@",API_BASE_URL(hexUrl));
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:API_BASE_URL(hexUrl) parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [self analysisJson:(NSDictionary *)responseObject];
        [self.myTable reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}

- (IBAction)xiugaiAction:(id)sender
{
    NSLog(@"修改");
    [delegate modifyCustomer:strCustomNo];
}



@end
