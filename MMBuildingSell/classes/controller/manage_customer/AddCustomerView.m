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
@synthesize laifangqudaoList,xuqiufangxingList,juzhuyetaiList;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.laifangqudaoList = [[NSMutableArray alloc]init];
        self.xuqiufangxingList = [[NSMutableArray alloc]init];
        self.juzhuyetaiList = [[NSMutableArray alloc]init];
        
    }
    return self;
}

-(void)initDataLaifangqudao:(NSMutableArray *)laifangqudao
              xuqiufangxing:(NSMutableArray *)xuqiufangxing
                 juzhuyetai:(NSMutableArray *)juzhuyetai
{
    self.laifangqudaoList = laifangqudao;
    self.xuqiufangxingList = xuqiufangxing;
    self.juzhuyetaiList = juzhuyetai;
}

-(void)initType:(int)type
{
    nType = type;
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

-(void)initCustomerDataWithNo:(NSString *)strNO
                         name:(NSString *)strName
                          sex:(NSInteger )nSex
                       status:(NSInteger )nStatus
                          tel:(NSString *)strTel
                     roomtype:(NSString *)strRoomtype
                  livingspace:(NSString *)strLivingspace
                        owner:(NSInteger )nOwner
                  producttype:(NSString *)strProducttype
                       getway:(NSString *)strGetway
                       bugdet:(NSString *)strBugdet
                    intention:(NSInteger )nIntention
{
    strCustomerNo = strNO;
    self.nameTextField.text = strName;
    [self.sexSeg setSelectedSegmentIndex:nSex];
    [self.statusSeg setSelectedSegmentIndex:nStatus];
    self.telTextField.text = strTel;
    

    for (NSMutableDictionary *rowData in self.xuqiufangxingList) {
        if ([[rowData objectForKey:@"name"] isEqualToString:strRoomtype]) {
            strSelectIdXuQiu = [[self.xuqiufangxingList objectAtIndex:[self.xuqiufangxingList indexOfObject:rowData]] objectForKey:@"id"];
        }
    }
    [self.xuqiufangxingBtn setTitle:strRoomtype forState:UIControlStateNormal];
    
    self.livingspaceTextField.text = strLivingspace;
    [self.ownerSeg setSelectedSegmentIndex:nOwner];
    
//    strSelectIdJuZhu = strProducttype;
    for (NSMutableDictionary *rowData in self.juzhuyetaiList) {
        if ([[rowData objectForKey:@"name"] isEqualToString:strProducttype]) {
            strSelectIdJuZhu = [[self.juzhuyetaiList objectAtIndex:[self.juzhuyetaiList indexOfObject:rowData]] objectForKey:@"id"];
        }
    }
    [self.juzhuyetaiBtn setTitle:strProducttype forState:UIControlStateNormal];
    
//    strSelectIdLaiFang = strGetway;
    for (NSMutableDictionary *rowData in self.laifangqudaoList) {
        if ([[rowData objectForKey:@"name"] isEqualToString:strGetway]) {
            strSelectIdLaiFang = [[self.laifangqudaoList objectAtIndex:[self.laifangqudaoList indexOfObject:rowData]] objectForKey:@"id"];
        }
    }
    [self.laifangqudaoBtn setTitle:strGetway forState:UIControlStateNormal];
    
    self.bugdetTextField.text = strBugdet;
    [self.intentionSeg setSelectedSegmentIndex:nIntention];
}


-(void)addCustomerHttp
{
    NSString * nameStr =self.nameTextField.text;
    NSString * sexStr =[self.sexSeg titleForSegmentAtIndex:[self.sexSeg selectedSegmentIndex]];
    NSString * statusStr =[self.statusSeg titleForSegmentAtIndex:[self.statusSeg selectedSegmentIndex]];
    NSString * telStr =self.telTextField.text;
    NSString * roomtypeStr =strSelectIdXuQiu;
    NSString * livingspaceStr =self.livingspaceTextField.text;
    NSString * ownerStr =[self.ownerSeg titleForSegmentAtIndex:[self.ownerSeg selectedSegmentIndex]];
    NSString * producttypeStr =strSelectIdJuZhu;
//    NSString * callvisitStr =[self.callvisitSeg titleForSegmentAtIndex:[self.callvisitSeg selectedSegmentIndex]];
    NSString * getwayStr =strSelectIdLaiFang;
    NSString * bugdetStr =self.bugdetTextField.text;
    NSString * intentionStr = [self.intentionSeg titleForSegmentAtIndex:[self.intentionSeg selectedSegmentIndex]];
    
    if ([nameStr length] > 0 &&  [sexStr length] > 0 &&  [statusStr length] > 0 &&  [telStr length] > 0 &&  [roomtypeStr length] > 0 &&  [livingspaceStr length] > 0 &&  [ownerStr length] > 0 &&  [producttypeStr length] > 0 &&  [getwayStr length] > 0&&  [bugdetStr length] > 0&&  [intentionStr length] > 0) {
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        NSString * strUrl = [[NSString alloc]initWithFormat:@"action=12&enterpriseCode=%@&installment=%@&no=%@&name=%@&sex=%@&status=%@&tel=%@&roomtype=%@&livingspace=%@&owner=%@&producttype=%@&getway=%@&userno=%@&bugdet=%@&intention=%@",[userDefaults objectForKey:@"enterpriseCode"],[userDefaults objectForKey:@"installment"],strCustomerNo,nameStr,sexStr,statusStr,telStr,roomtypeStr,livingspaceStr,ownerStr,producttypeStr,getwayStr,[userDefaults objectForKey:@"usercode"],bugdetStr,intentionStr];
        
        if (nType == 0) {
            strUrl = [[NSString alloc]initWithFormat:@"action=11&enterpriseCode=%@&installment=%@&name=%@&sex=%@&status=%@&tel=%@&roomtype=%@&livingspace=%@&owner=%@&producttype=%@&getway=%@&userno=%@&bugdet=%@&intention=%@",[userDefaults objectForKey:@"enterpriseCode"],[userDefaults objectForKey:@"installment"],nameStr,sexStr,statusStr,telStr,roomtypeStr,livingspaceStr,ownerStr,producttypeStr,getwayStr,[userDefaults objectForKey:@"usercode"],bugdetStr,intentionStr];
            NSLog(@"add url: %@", strUrl);
        }
        
        NSString * hexUrl  = [Utility hexStringFromString:strUrl];
        
        NSLog(@"ADD or XIU gai url: %@", API_BASE_URL(hexUrl));
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:API_BASE_URL(hexUrl) parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"JSON: %@", responseObject);
            [self analysisJson:(NSDictionary *)responseObject];
            CustomerBean * cb = [[CustomerBean alloc]init];
            [delegate addPerson:cb type:nType];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];

    }else{
        [XWAlterview showmessage:@"提示" subtitle:@"数据填写不全" cancelbutton:@"确定"];
    }
    
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

- (IBAction)dddddAction:(id)sender
{
    [self selectClicked:sender];
}


- (void)selectClicked:(id)sender {

    if (sender == self.laifangqudaoBtn) {
        //Laifang
        NSMutableArray *laifangArr = [[NSMutableArray alloc]init];;
        for (NSMutableDictionary *rowData in self.laifangqudaoList) {
            [laifangArr addObject:[rowData objectForKey:@"name"]];
        }
        if(dropDownLaiFang == nil) {
            CGFloat f = 200;
            dropDownLaiFang = [[NIDropDown alloc]showDropDown:sender :&f :laifangArr :nil :@"down"];
            dropDownLaiFang.delegate = self;
        }
        else {
            [dropDownLaiFang hideDropDown:sender];
            [self rel];
        }

    }else if (sender == self.xuqiufangxingBtn){
        //XuQiu
        NSMutableArray *xuqiuArr = [[NSMutableArray alloc]init];;
        for (NSMutableDictionary *rowData in self.xuqiufangxingList) {
            [xuqiuArr addObject:[rowData objectForKey:@"name"]];
        }
        if(dropDownXuQiu == nil) {
            CGFloat f = 200;
            dropDownXuQiu = [[NIDropDown alloc]showDropDown:sender :&f :xuqiuArr :nil :@"down"];
            dropDownXuQiu.delegate = self;
        }
        else {
            [dropDownXuQiu hideDropDown:sender];
            [self rel];
        }
    }else if (sender == self.juzhuyetaiBtn){
        //JuZhu
        NSMutableArray *juzhuArr = [[NSMutableArray alloc]init];;
        for (NSMutableDictionary *rowData in self.juzhuyetaiList) {
            [juzhuArr addObject:[rowData objectForKey:@"name"]];
        }
        if(dropDownJuZhu == nil) {
            CGFloat f = 200;
            dropDownJuZhu = [[NIDropDown alloc]showDropDown:sender :&f :juzhuArr :nil :@"down"];
            dropDownJuZhu.delegate = self;
        }
        else {
            [dropDownJuZhu hideDropDown:sender];
            [self rel];
        }
    }
    
    
}

- (void) niDropDownDelegateMethod: (NIDropDown *) sender selectPos:(int)nPos
{
    if (sender == dropDownLaiFang) {
        strSelectIdLaiFang = [[self.laifangqudaoList objectAtIndex:nPos] objectForKey:@"id"];
    } else if(sender == dropDownXuQiu){
        strSelectIdXuQiu = [[self.xuqiufangxingList objectAtIndex:nPos] objectForKey:@"id"];
    }else if(sender == dropDownJuZhu){
        strSelectIdJuZhu = [[self.juzhuyetaiList objectAtIndex:nPos] objectForKey:@"id"];
    }
    
    [self rel];
}

-(void)rel
{
    //    [dropDown release];
    dropDownLaiFang = nil;
    dropDownXuQiu = nil;
    dropDownJuZhu = nil;
}
@end
