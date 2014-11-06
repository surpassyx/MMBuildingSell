//
//  LoginViewController.m
//  QQ空间-HD
//
//  Created by apple on 13-9-11.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "LoginViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ServiceSettingViewController.h"
#import "UIViewController+CWPopup.h"

#import "AFHTTPRequestOperationManager.h"
#import "AFURLSessionManager.h"

@interface LoginViewController ()


@property (nonatomic, strong) NSDictionary *dicDirectoryKey;


@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        self.sharedDownloadManager = [TCBlobDownloadManager sharedInstance];
    }
    
    return self;
}

/**
 * 输入文本结束后，关闭键盘，并恢复视图位置
 */
- (void)textFieldDidEndEditing:(UITextField *)textField {
	[textField resignFirstResponder];

    self.view.frame =CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
}

/**
 * 开始输入文本时，将当前视图向上移动，以显示键盘
 */
- (void)textFieldDidStartEditing:(UITextField *)textField	 {

    CGRect frame = textField.frame;
    int offset = frame.origin.y + 32 - (self.view.frame.size.height - 216.0);//键盘高度216
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
	
}

//当用户按下return键或者按回车键，keyboard消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (IBAction)updateResources
{
    
    
    waitHUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:waitHUD];
    waitHUD.dimBackground = YES;
    waitHUD.labelText = @"正在更新，请稍后";
    [waitHUD show:YES];
    
    
    [self downLoadInfo];
    
}


- (void)downLoadInfo
{
    [LocalFilePath deleteDirectoryPath:@""];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //    NSDictionary *parameter = [NSDictionary dictionaryWithObjectsAndKeys:@"20140618",@"day", nil];
    NSString *gameListUrl = @"http://www.ykhome.cn/myhome/getsysimage.php?&fenterisecode=P0001&finstallment=01&fflag=all";
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:gameListUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSArray *arr = [dic objectForKey:@"arr"];
        [waitHUD removeFromSuperview];
        waitHUD = nil;
        nDownloadAllNum = [arr count];
        nDownloadNum = 1;
        
        progressView = [[ZDProgressView alloc] initWithFrame:CGRectMake(360, 650, 320, 25)];
        progressView.progress = 0;
        progressView.text = [NSString stringWithFormat:@"%d/%d",nDownloadNum,nDownloadAllNum];
        progressView.noColor = [UIColor whiteColor];
        progressView.prsColor = self.view.tintColor;
        [self.view addSubview:progressView];

        for (NSDictionary *dicTmp in arr) {
            NSString *fileUrl = [dicTmp objectForKey:@"fimgpath"];
            // 文件完整的网络地址
            fileUrl = [NSString stringWithFormat:@"http://www.ykhome.cn/%@", fileUrl];
            NSString *fileDic = [dicTmp objectForKey:@"ftitle"];
            fileDic = [_dicDirectoryKey objectForKey:fileDic];
            NSString *saveFilePath = [LocalFilePath getSessionPath:fileDic]; //保存文件的路径
            
            NSURL *url = [NSURL URLWithString:fileUrl];
			
            NSString *fileName = [url lastPathComponent];
			NSArray *arrType = [fileName componentsSeparatedByString:@"."];
			NSString *name;
			NSString *type;
			if (arrType.count == 2) {
				name = [arrType objectAtIndex:0];
				type = [arrType objectAtIndex:1];
			}
            // mp4
            if ([type isEqualToString:@"zip"]) {
                fileName = [NSString stringWithFormat:@"%@.mp4", name];
            }
            
            NSString *saveLocalFilePath = [NSString stringWithFormat:@"%@/%@", saveFilePath, fileName];
            NSFileManager *manager = [NSFileManager defaultManager];
            // 防止重复下载
            if (![manager fileExistsAtPath:saveLocalFilePath]) {
                [self downLoadFile:fileUrl filePath:saveLocalFilePath];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [waitHUD removeFromSuperview];
        waitHUD = nil;
    }];
}


- (void)downLoadFile:(NSString *)url filePath:(NSString *)filePath
{
    if (!_manager) {
		_manager = [AFHTTPRequestOperationManager manager];
		[_manager.operationQueue setMaxConcurrentOperationCount:1];
	}
	[NSURLSessionConfiguration defaultSessionConfiguration].HTTPMaximumConnectionsPerHost = 1;
	
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSLog(@"url is %@ file path is %@", url, filePath);
    NSString *urlString = url;//@"http://www.ykhome.cn/project/P0001/01/paomiantu/201401.jpg";
    AFHTTPRequestOperation *operation = [_manager GET:urlString
                                           parameters:nil
                                              success:^(AFHTTPRequestOperation *operation, NSData *responseData)
                                         {
                                             NSLog(@"保存文件路径为%@", filePath);
                                             nDownloadNum++;
                                             [responseData writeToFile:filePath atomically:YES];
                                             if (nDownloadNum > nDownloadAllNum) {
                                                 [progressView removeFromSuperview];
                                                 progressView = nil;
                                             }
                                         }
                                              failure:^(AFHTTPRequestOperation *operation, NSError *error)
                                         {
                                             NSLog(@"Downloading error: %@", error);
                                             [progressView removeFromSuperview];
                                             progressView = nil;
                                         }];
    [NSURLSessionConfiguration defaultSessionConfiguration].HTTPMaximumConnectionsPerHost = 1;
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead)
     {
         float downloadPercentage = (float)totalBytesRead/(float)(totalBytesExpectedToRead);
         progressView.progress = downloadPercentage;
         progressView.text = [NSString stringWithFormat:@"%d/%d",nDownloadNum,nDownloadAllNum];
         NSLog(@"downloadPercentage is %f", downloadPercentage);
         //         [someProgressView setProgress:downloadPercentage animated:YES];
     }];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // ftitle和目录文件夹名称的对照
    self.dicDirectoryKey = [NSDictionary dictionaryWithObjectsAndKeys:@"wuyezhanshi",@"wuye", @"shipinzhanshi", @"shipin", @"poumiantu", @"paomian", @"fangxingzhanshi", @"fangxing", @"xiangmuzhanshi", @"project show", @"zhoubianpeitao", @"zhoubian", nil];

    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPopup)];
    tapRecognizer.numberOfTapsRequired = 1;
    tapRecognizer.delegate = self;
    [self.view addGestureRecognizer:tapRecognizer];
    self.useBlurForPopup = YES;
    
    // 设置背景颜色
    self.view.backgroundColor = kSegmentBg;
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //添加事件处理方法
    [_qq addTarget:self action:@selector(textFieldDidEndEditing:)
        forControlEvents:UIControlEventEditingDidEndOnExit];
    [_qq addTarget:self action:@selector(textFieldDidStartEditing:)
        forControlEvents:UIControlEventEditingDidBegin];
    [_pwd addTarget:self action:@selector(textFieldDidEndEditing:)
        forControlEvents:UIControlEventEditingDidEndOnExit];
    [_pwd addTarget:self action:@selector(textFieldDidStartEditing:)
        forControlEvents:UIControlEventEditingDidBegin];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    _qq.text = [userDefaults objectForKey:@"account"];
    _pwd.text = [userDefaults objectForKey:@"password"];
    NSString * strIsSelected =[userDefaults objectForKey:@"isselected"];
    if ([@"1" isEqualToString:strIsSelected]) {
        [_rmbPwd setSelected:YES];
    }else{
        [_rmbPwd setSelected:NO];
    }
}

-(void)analysisJson:(NSDictionary *)jsonDic
{
    dispatch_async(dispatch_get_main_queue(), ^{
        // 3.2.让整个登录界面停止跟用户交互
        self.view.userInteractionEnabled = NO;
        
        // 3.3.通过定时器跳到主界面
        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(loginSuccess) userInfo:nil repeats:NO];
        
        //        [self setADScrollView];
    });
    
    
    return ;
    //    NSError *error;
    //    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:date options:NSJSONReadingMutableLeaves error:&error];
    NSString * strSign = [jsonDic objectForKey:@"sign"];
    int intString = [strSign intValue];
    if (intString == 1) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setValue:[jsonDic objectForKey:@"username"] forKey:@"username"];
        [userDefaults setValue:[jsonDic objectForKey:@"usercode"] forKey:@"usercode"];
        [userDefaults setValue:[jsonDic objectForKey:@"enterpriseCode"] forKey:@"enterpriseCode"];
        [userDefaults synchronize];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // 3.2.让整个登录界面停止跟用户交互
            self.view.userInteractionEnabled = NO;
            
            // 3.3.通过定时器跳到主界面
            [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(loginSuccess) userInfo:nil repeats:NO];
            
            //        [self setADScrollView];
        });

        
    }else if (intString == 0) {
        // 3.2.让整个登录界面停止跟用户交互
        self.view.userInteractionEnabled = NO;
        
        // 3.3.通过定时器跳到主界面
        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(alertError:) userInfo:[jsonDic objectForKey:@"error"] repeats:NO];
    }else{
        NSLog(@"服务端返回错误");
        // 3.2.让整个登录界面停止跟用户交互
        self.view.userInteractionEnabled = NO;
        
        // 3.3.通过定时器跳到主界面
        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(alertError:) userInfo:@"服务端返回错误" repeats:NO];
    }
    
    
    
}


#pragma mark 弹出错误提示
- (void)alertError:(NSString *)error
{
    // 1.弹框
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登录失败" message:error delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
    
    // 2.发抖
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    anim.repeatCount = 1;
    anim.values = @[@-10, @10, @-10];
    [_loginView.layer addAnimation:anim forKey:nil];
}

- (IBAction)selectQiBie
{
    [self selectClicked:self.qibieBtn];
}


#pragma mark 登录
- (IBAction)login {
    // 1.QQ
    if (_qq.text.length == 0) {
        [self alertError:@"请输入帐号"];
        return;
    }
    
    // 2.密码
    if (_pwd.text.length == 0) {
        [self alertError:@"请输入密码"];
        return;
    }
    
    
    
    // 3.登录成功
    // 3.1.开始动画
    [_indicator startAnimating];
    
    NSUserDefaults * myDefaults = [NSUserDefaults standardUserDefaults];
    [myDefaults setObject:@"P0001" forKey:@"enterpriseCode"];
    [myDefaults setObject:@"01" forKey:@"installment"];
    [myDefaults synchronize];
    
    //http://www.ykhome.cn/myhome/getsysimage.php?&fenterisecode=P0001&finstallment=01&fflag=all
    
    NSString * strUrl = [[NSString alloc]initWithFormat:@"http://www.ykhome.cn/myhome/login.php?loginname=%@&loginpassword=%@&enterpriseCode=%@&installment=%@",_qq.text,_pwd.text,[myDefaults objectForKey:@"enterpriseCode"],[myDefaults objectForKey:@"installment"]];
    NSLog(@"loginUrl=%@",strUrl);
    
//   strUrl = @"http://www.ykhome.cn/myhome/getsysimage.php?&fenterisecode=P0001&finstallment=01&fflag=all";
//    strUrl = @"http://www.ykhome.cn/myhome/login.php?loginname=lgh&loginpassword=123&enterpriseCode=P0001&installment=01";
    strUrl = @"http://www.gytaobao.cn:9006/FC/Action?data=616374696f6e3d31266c6f67696e6e616d653db2e2cad4266c6f67696e7077643d31323326656e7465727072697365436f64653d503030303126696e7374616c6c6d656e743d303131";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:strUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Login - %@",responseObject);
        [self analysisJson:(NSDictionary *)responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        // 3.2.让整个登录界面停止跟用户交互
        self.view.userInteractionEnabled = NO;
        //
        // 3.3.通过定时器跳到主界面
        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(alertError:) userInfo:error repeats:NO];
    }];


    //http://www.ykhome.cn/myhome/login.php?loginname=lgh&loginpassword=123&enterpriseCode=P0001&installment=01
    

    
}

#pragma mark 登录成功
- (void)loginSuccess
{
    // 1.停止动画
    [_indicator stopAnimating];
    
    // 2.保存账号密码
     NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([_rmbPwd isSelected]) {
        [userDefaults setValue:@"1" forKey:@"isselected"];
        [userDefaults setValue:_qq.text forKey:@"account"];
        [userDefaults setValue:_pwd.text forKey:@"password"];
    }else{
        [userDefaults setValue:@"0" forKey:@"isselected"];
        [userDefaults setValue:@"" forKey:@"account"];
        [userDefaults setValue:@"" forKey:@"password"];
    }
    [userDefaults synchronize];

    
    // 3.让登录界面可以跟用户交互
    self.view.userInteractionEnabled = YES;
    
    // 4.跳到主界面
    [self performSegueWithIdentifier:@"home" sender:nil];
}

#pragma mark 记住密码
- (IBAction)rmbPwd:(UIButton *)sender {
    // 1.取反
    sender.selected = !sender.isSelected;
    
    // 2.取消选中自动登录
    if (!sender.isSelected) {
        _autoLogin.selected = NO;
    }
}
#pragma mark 自动登录
- (IBAction)autoLogin:(UIButton *)sender {
    // 1.取反
    sender.selected = !sender.isSelected;
    
    // 2.选中记住密码
    if (sender.isSelected) {
        _rmbPwd.selected = YES;
    }
}
- (IBAction)settingAction:(id)sender {
    
    ServiceSettingViewController *samplePopupViewController = [[ServiceSettingViewController alloc] initWithNibName:@"ServiceSettingViewController" bundle:nil];
    [self presentPopupViewController:samplePopupViewController animated:YES completion:^(void) {
        NSLog(@"popup view presented");
    }];

    
}

- (void)dismissPopup {
    if (self.popupViewController != nil) {
        [self dismissPopupViewControllerAnimated:YES completion:^{
            NSLog(@"popup view dismissed");
        }];
    }
}

#pragma mark - gesture recognizer delegate functions

// so that tapping popup view doesnt dismiss it
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return touch.view == self.view;
}

- (void)selectClicked:(id)sender {
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"1期", @"2期", @"3期", @"4期",nil];
    NSArray * arrImage = [[NSArray alloc] init];
    arrImage = [NSArray arrayWithObjects:[UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], nil];
    if(dropDown == nil) {
        CGFloat f = 200;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arr :arrImage :@"down"];
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }
}

- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    
    NSString *temp = [[NSString alloc]init];
    if([sender.animationDirection isEqualToString:@"1期"]){
        temp = @"1";
    }else if ([sender.animationDirection isEqualToString:@"2期"]){
        temp = @"2";
    }else if ([sender.animationDirection isEqualToString:@"3期"]){
        temp = @"3";
    }else if ([sender.animationDirection isEqualToString:@"4期"]){
        temp = @"4";
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:temp forKey:@"qibie"];
    [defaults synchronize];
    [self rel];
}

-(void)rel{
    //    [dropDown release];
    dropDown = nil;
}


-(void)initPicResources
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *qibie = [defaults objectForKey:@"qibie"];
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *path = [[NSString alloc]initWithFormat:@"%@%@%@%@/",documentsDirectory,@"/",@"MMBuilding/",qibie];
    
    //item文件夹
    NSString *itemPath = [[NSString alloc]initWithFormat:@"%@/%@/",path,@"item"];
    if ([self fileSizeForDir:itemPath] <= 0 ) {
        //0 - 5
        
    }
    //panorama文件夹
    NSString *panoramaPath = [[NSString alloc]initWithFormat:@"%@/%@/",path,@"panorama"];
    if ([self fileSizeForDir:panoramaPath] <= 0 ) {
        //0 - 3
        
    }
    
}

-(BOOL)copyBundleToDocuments:(NSString *)fileName filePath:(NSString *)filePath
{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSString *fileFullName = [[NSString alloc]initWithFormat:@"/%@",filePath];

    NSString *dataPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingString:fileFullName];//获取程序包中相应文件的路径
    if([fileManager copyItemAtPath:dataPath toPath:filePath error:&error]) //拷贝
    {
        NSLog(@"copy xxx.txt success");
        return YES;
    }
    else
    {
        NSLog(@"%@",error);
        return NO;
    }

}

-(long)fileSizeForDir:(NSString*)path//计算文件夹下文件的总大小
{
    long size = 0;
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    
    NSArray* array = [fileManager contentsOfDirectoryAtPath:path error:nil];
    for(int i = 0; i<[array count]; i++)
    {
        NSString *fullPath = [path stringByAppendingPathComponent:[array objectAtIndex:i]];
        
        BOOL isDir;
        if ( !([fileManager fileExistsAtPath:fullPath isDirectory:&isDir] && isDir) )
        {
            NSDictionary *fileAttributeDic=[fileManager attributesOfItemAtPath:fullPath error:nil];
            size+= fileAttributeDic.fileSize;
        }
        else
        {
            [self fileSizeForDir:fullPath];
        }
    }
    return size;
    
}
-(void)synchronizedFileInfoFromHttp
{
    NSUserDefaults * myDefaults = [NSUserDefaults standardUserDefaults];
    [myDefaults setObject:@"P0001" forKey:@"enterpriseCode"];
    [myDefaults setObject:@"01" forKey:@"installment"];
    [myDefaults synchronize];
    NSString * strUrl = [[NSString alloc]initWithFormat:@"http://erp.lncct.com/Mobile/Interface.aspx?username=%@&password=%@&enterpriseCode=%@installment=%@",_qq.text,_pwd.text,[myDefaults objectForKey:@"enterpriseCode"],[myDefaults objectForKey:@"installment"]];
    NSLog(@"loginUrl=%@",strUrl);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:strUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Login JSON: %@", responseObject);
        [self analysisFileJson:(NSDictionary *)responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
        // 3.2.让整个登录界面停止跟用户交互
        self.view.userInteractionEnabled = NO;
        
        // 3.3.通过定时器跳到主界面
        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(loginSuccess) userInfo:nil repeats:NO];
    }];

}

-(void)analysisFileJson:(NSDictionary *)jsonDic
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
        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(loginSuccess) userInfo:nil repeats:NO];
        
        //        [self setADScrollView];
    });
    
    
    
}

@end