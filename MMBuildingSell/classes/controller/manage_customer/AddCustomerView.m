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
    self.name.delegate = self;
    self.tel.delegate = self;
    self.wantType.delegate = self;
    self.wantLevel.delegate = self;
    self.getWay.delegate = self;
    self.mudi.delegate = self;
    self.workSpace.delegate = self;
    self.danwei.delegate = self;
    self.juzhuquyu.delegate = self;
    self.jiatingjiegou.delegate = self;
    self.nianshouru.delegate = self;
    self.car.delegate = self;
    self.age.delegate = self;
    self.xianyoufangchan.delegate = self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    self.name.delegate = self;
    self.tel.delegate = self;
    self.wantType.delegate = self;
    self.wantLevel.delegate = self;
    self.getWay.delegate = self;
    self.mudi.delegate = self;
    self.workSpace.delegate = self;
    self.danwei.delegate = self;
    self.juzhuquyu.delegate = self;
    self.jiatingjiegou.delegate = self;
    self.nianshouru.delegate = self;
    self.car.delegate = self;
    self.age.delegate = self;
    self.xianyoufangchan.delegate = self;
}




//开始编辑输入框的时候，软键盘出现，执行此事件
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [deleage moveUpView:textField];
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
    [deleage moveDownView:textField];
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
    
    [self.name setText:@"111"];
    [self.tel setText:@"13898823456"];
    [self.wantType setText:@"2123"];
    [self.wantLevel setText:@"123"];
    [self.getWay setText:@"123"];
    [self.mudi setText:@"123"];
    [self.workSpace setText:@"123"];
    [self.danwei setText:@"120-140"];
    [self.juzhuquyu setText:@"123"];
    [self.jiatingjiegou setText:@"31"];
    [self.nianshouru setText:@"3213123"];
    [self.car setText:@"123123"];
    [self.age setText:@"30"];
    [self.xianyoufangchan setText:@"2"];
    
//    http://www.ykhome.cn/myhome/setcustomers.php?name=张珊&tel=13898823456&roomtype=三室一厅&level=部门经理&getway=路过&purpose=改善&workspace=浑南&livingspace=120-140&family=大东&income=30万&car=酷路泽&age=30&havinghouse=2

    
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    NSString * strUrl = [[NSString alloc]initWithFormat:@"http://www.ykhome.cn/myhome/setcustomers.php?no=%@&enterpriseCode=%@&name=%@&tel=%@&roomtype=%@&level=%@&getway=%@&purpose=%@&workplace=%@&livingspace=%@&family=%@&income=%@&car=%@&age=%@&havinghouse=%@",[userDefaults objectForKey:@"no"],[userDefaults objectForKey:@"enterpriseCode"],self.name.text,self.tel.text,self.wantType.text,self.wantLevel.text,self.getWay.text,self.mudi.text,self.workSpace.text,self.jiatingjiegou.text,self.juzhuquyu.text,self.nianshouru.text,self.car.text,self.age.text,self.xianyoufangchan.text];
    NSString * strUrl = [[NSString alloc]initWithFormat:@"http://www.ykhome.cn/myhome/setcustomers.php?name=%@&tel=%@&roomtype=%@&level=%@&getway=%@&purpose=%@&workplace=%@&livingspace=%@&family=%@&income=%@&car=%@&age=%@&havinghouse=%@",self.name.text,self.tel.text,self.wantType.text,self.wantLevel.text,self.getWay.text,self.mudi.text,self.workSpace.text,self.juzhuquyu.text,self.jiatingjiegou.text,self.nianshouru.text,self.car.text,self.age.text,self.xianyoufangchan.text];
    NSLog(@"url: %@", strUrl);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:strUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [self analysisJson:(NSDictionary *)responseObject];
        CustomerBean * cb = [[CustomerBean alloc]init];
        [deleage addPerson:cb];
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
    [deleage removeAddPersonView];
    [self removeFromSuperview];
}

- (IBAction)okAction:(id)sender {
    
    [self addCustomerHttp];
}
@end
