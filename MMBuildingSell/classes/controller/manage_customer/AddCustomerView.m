//
//  AddCustomerView.m
//  MMBuildingSell
//
//  Created by 3G组 on 13-11-27.
//  Copyright (c) 2013年 Y.X. All rights reserved.
//

#import "AddCustomerView.h"
#import "AFNetworking.h"

@implementation AddCustomerView

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
    }
    return self;
}


-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.nameTextField.delegate = self;
    self.telTextField.delegate = self;
    self.livingspaceTextField.delegate = self;
    self.bugdetTextField.delegate = self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    self.nameTextField.delegate = self;
    self.telTextField.delegate = self;
    self.livingspaceTextField.delegate = self;
    self.bugdetTextField.delegate = self;
}




//开始编辑输入框的时候，软键盘出现，执行此事件
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [delegate moveUpView:textField];
    return;
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 32 - (self.frame.size.height - 216.0);//键盘高度216
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
        self.frame = CGRectMake(0.0f, -offset, self.frame.size.width, self.frame.size.height);
    
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
    [delegate moveDownView:textField];
    return;
    self.frame =CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
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
        
        // 3.3.通过定时器跳到主界面
        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(getInfoSuccess) userInfo:nil repeats:NO];
        
        
    });
}

- (void)getInfoSuccess
{
    
}

-(void)addCustomerHttp
{
    NSString * nameStr =@"张三";
    NSString * sexStr =@"男";
    NSString * statusStr =@"问询";
    NSString * telStr =@"13898823456";
    NSString * roomtypeStr =@"6";
    NSString * livingspaceStr =@"120-140";
    NSString * ownerStr =@"是";
    NSString * producttypeStr =@"12";
    NSString * callvisitStr =@"来电";
    NSString * getwayStr =@"44";
    NSString * bugdetStr =@"100";
    NSString * intentionStr =@"一般";
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    NSString * strUrl = [[NSString alloc]initWithFormat:@"action=11&enterpriseCode=%@&installment=%@&name=%@&sex=%@&status=%@&tel=%@&roomtype=%@&livingspace=%@&owner=%@&producttype=%@&callvisit=%@&getway=%@&userno=%@&bugdet=%@&intention=%@",[userDefaults objectForKey:@"enterpriseCode"],[userDefaults objectForKey:@"installment"],nameStr,sexStr,statusStr,telStr,roomtypeStr,livingspaceStr,ownerStr,producttypeStr,callvisitStr,getwayStr,[userDefaults objectForKey:@"usercode"],bugdetStr,intentionStr];
    NSLog(@"url: %@", strUrl);
    
    NSString * hexUrl  = [Utility hexStringFromString:strUrl];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:API_BASE_URL(hexUrl) parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [self analysisJson:(NSDictionary *)responseObject];
        CustomerBean * cb = [[CustomerBean alloc]init];
        [delegate addPerson:cb];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}

-(void)addCustomerRemarkHttp
{
    NSString * strCustomerno =@"customerno";
    NSString * strRemark =@"remark";
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * strUrl = [[NSString alloc]initWithFormat:@"http://erp.lncct.com/Mobile/Interface.aspx?no=%@&enterpriseCode=%@&customerno=%@&remark=%@",[userDefaults objectForKey:@"no"],[userDefaults objectForKey:@"enterpriseCode"],strCustomerno,strRemark];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:strUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [self analysisJson:(NSDictionary *)responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}

- (IBAction)cancelAction:(id)sender {
    [delegate removeAddPersonView];
    [self removeFromSuperview];
}

- (IBAction)okAction:(id)sender {
    
    [self addCustomerHttp];
}
@end
