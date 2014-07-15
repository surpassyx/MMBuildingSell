//
//  LoginViewController.h
//  QQ空间-HD
//
//  Created by apple on 13-9-11.
//  Copyright (c) 2013年 itcast. All rights reserved.
//  登录界面

#import <UIKit/UIKit.h>
#import "NIDropDown.h"
//#import <TCBlobDownload/TCBlobDownload.h>
//#import <TCBlobDownload/TCBlobDownloadManager.h>

@interface LoginViewController : UIViewController<UIGestureRecognizerDelegate,NIDropDownDelegate>{
    NIDropDown *dropDown;
    MBProgressHUD *waitHUD;
    ZDProgressView *progressView;
    
    int nDownloadNum;
    int nDownloadAllNum;
}
//@property (nonatomic , unsafe_unretained) TCBlobDownloadManager *sharedDownloadManager;

@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;

@property (weak, nonatomic) IBOutlet UIView *loginView;
- (IBAction)login;
@property (weak, nonatomic) IBOutlet UITextField *qq;
@property (weak, nonatomic) IBOutlet UITextField *pwd;
- (IBAction)rmbPwd:(UIButton *)sender;
- (IBAction)autoLogin:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *autoLogin;
@property (weak, nonatomic) IBOutlet UIButton *rmbPwd;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
- (IBAction)settingAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *qibieBtn;

@property (weak, nonatomic) IBOutlet UIButton *gengxinBtn;

- (IBAction)updateResources;

- (IBAction)selectQiBie;
@end
