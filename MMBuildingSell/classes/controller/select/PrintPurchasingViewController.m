//
//  PrintPurchasingViewController.m
//  MMBuildingSell
//
//  Created by 3G组 on 13-10-23.
//  Copyright (c) 2013年 Y.X. All rights reserved.
//

#import "PrintPurchasingViewController.h"
#import "AFNetworking.h"

@interface PrintPurchasingViewController ()

@end

@implementation PrintPurchasingViewController

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
    NSString * strRoomNo =@"roomNo";
    NSString * strBuyName =@"buyname";
    NSString * strBuyTel =@"buytel";
    NSString * strSex =@"sex";
    NSString * strNumTyoe =@"numtype";
    NSString * strNum =@"num";
    NSString * strBuyTyoe =@"buytype";
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * strUrl = [[NSString alloc]initWithFormat:@"http://erp.lncct.com/Mobile/Interface.aspx?no=%@&roomno=%@&enterpriseCode=%@&buyname=%@&buytel=%@&sex=%@&numtype=%@&num=%@&buytype=%@",[userDefaults objectForKey:@"no"],strRoomNo,[userDefaults objectForKey:@"enterpriseCode"],strBuyName,strBuyTel,strSex,strNumTyoe,strNum,strBuyTyoe];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:strUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [self analysisJson:(NSDictionary *)responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sexAction:(id)sender {
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"男", @"女",nil];
    NSArray * arrImage = [[NSArray alloc] init];
    arrImage = [NSArray arrayWithObjects:[UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], nil];
    if(dropDownSex == nil) {
        CGFloat f = 200;
        dropDownSex = [[NIDropDown alloc]showDropDown:sender :&f :arr :arrImage :@"down"];
        dropDownSex.delegate = self;
    }
    else {
        [dropDownSex hideDropDown:sender];
        [self rel];
    }
}

- (IBAction)typeAction:(id)sender {
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"身份证", @"军官证", @"其他",nil];
    NSArray * arrImage = [[NSArray alloc] init];
    arrImage = [NSArray arrayWithObjects:[UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], nil];
    if(dropDownType == nil) {
        CGFloat f = 200;
        dropDownType = [[NIDropDown alloc]showDropDown:sender :&f :arr :arrImage :@"down"];
        dropDownType.delegate = self;
    }
    else {
        [dropDownType hideDropDown:sender];
        [self rel];
    }
}

- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    [self rel];
}

-(void)rel{
    //    [dropDown release];
    dropDownType = nil;
    dropDownSex = nil;
}

@end
