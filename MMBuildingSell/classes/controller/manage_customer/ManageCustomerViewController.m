//
//  ManageCustomerViewController.m
//  MMBuildingSell
//
//  Created by 3G组 on 13-10-14.
//  Copyright (c) 2013年 Y.X. All rights reserved.
//

#import "ManageCustomerViewController.h"
#import "AFNetworking.h"



@interface ManageCustomerViewController ()

@end

@implementation ManageCustomerViewController
@synthesize myTableView;
@synthesize arrPersonInfo,laifangqudaoList,juzhuyetaiList,xuqiufangxingList;


#define FrameWIDTH 812.0
#define FrameHEIGHT 748.0




-(void)analysisJson:(NSDictionary *)jsonDic
{
    NSString * strSign = [jsonDic objectForKey:@"sign"];
    int intString = [strSign intValue];
    if (intString == 1) {
        [self.personList removeAllObjects];
        [self.arrPersonInfo removeAllObjects];
        [self.dataList removeAllObjects];
        [self.personShowList removeAllObjects];
        NSMutableArray *arrInfo = [jsonDic objectForKey:@"arr"];
        for (int i = 0; i < arrInfo.count ; i++) {
            NSDictionary *dicInfo = [arrInfo objectAtIndex:i];
            NSString * strNo = [dicInfo objectForKey:@"no"];
            NSString * strName = [dicInfo objectForKey:@"name"];
            NSString * strSex = [dicInfo objectForKey:@"sex"];
            NSString * strStatus =[dicInfo objectForKey:@"status"];
            NSString * strTel =[dicInfo objectForKey:@"tel"];
            NSString * strRoomType = [dicInfo objectForKey:@"roomtype"];
            NSString * strLivingspace = [dicInfo objectForKey:@"livingspace"];
            NSString * strOwner = [dicInfo objectForKey:@"owner"];
            NSString * strProducttype = [dicInfo objectForKey:@"producttype"];
            NSString * strCallvisit =[dicInfo objectForKey:@"callvisit"];
            NSString * strGetway = [dicInfo objectForKey:@"getway"];
            NSString * strUsername = [dicInfo objectForKey:@"username"];
            NSString * strBugdet = [dicInfo objectForKey:@"bugdet"];
            NSString * strIntention = [dicInfo objectForKey:@"intention"];
            
            
            
            NSMutableDictionary *rowData = [[NSMutableDictionary alloc]init];
            [rowData setValue:strNo forKey:@"no"];
            [rowData setValue:strName forKey:@"name"];
            [rowData setValue:strSex forKey:@"sex"];
            [rowData setValue:strStatus forKey:@"status"];
            [rowData setValue:strTel forKey:@"tel"];
            [rowData setValue:strRoomType forKey:@"roomtype"];
            [rowData setValue:strLivingspace forKey:@"livingspace"];
            [rowData setValue:strOwner forKey:@"owner"];
            [rowData setValue:strProducttype forKey:@"producttype"];
            [rowData setValue:strCallvisit forKey:@"callvisit"];
            [rowData setValue:strGetway forKey:@"getway"];
            [rowData setValue:strUsername forKey:@"username"];
            [rowData setValue:strBugdet forKey:@"bugdet"];
            [rowData setValue:strIntention forKey:@"intention"];
            
            [self.personList addObject:strName];
            [self.dataList addObject:strName];
            [self.arrPersonInfo addObject:rowData];
            [self.personShowList addObject:rowData];
        }
        
    }else{
        NSLog(@"服务端返回错误");
    }
    NSString * strNum = [[NSString alloc]initWithFormat:@"共计%lu人",(unsigned long)[self.personList count]];
    [totalPersonLabel setText:strNum];
    
    
    [self.myTableView reloadData];
    if ([self.arrPersonInfo count] > 0) {
        NSUserDefaults * myDefaults = [NSUserDefaults standardUserDefaults];
        if (nType == 0) {
            
            [myDefaults setInteger:([self.arrPersonInfo count]-1) forKey:@"CustomerSelectedNum"];
            [myDefaults synchronize];
        }
        
        NSInteger nSelected = [myDefaults integerForKey:@"CustomerSelectedNum"];
        
        NSMutableDictionary *rowData = [[NSMutableDictionary alloc]init];
        rowData = [self.arrPersonInfo objectAtIndex:nSelected];
        
        [self showDeatilCustomer:[rowData objectForKey:@"no"]
                            name:[rowData objectForKey:@"name"]
                             sex:[rowData objectForKey:@"sex"]
                          status:[rowData objectForKey:@"status"]
                             tel:[rowData objectForKey:@"tel"]
                        roomtype:[rowData objectForKey:@"roomtype"]
                     livingspace:[rowData objectForKey:@"livingspace"]
                           owner:[rowData objectForKey:@"owner"]
                     producttype:[rowData objectForKey:@"producttype"]
                       callvisit:[rowData objectForKey:@"callvisit"]
                          getway:[rowData objectForKey:@"getway"]
                        username:[rowData objectForKey:@"username"]
                          bugdet:[rowData objectForKey:@"bugdet"]
                       intention:[rowData objectForKey:@"intention"]];
    }
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedPushContent:) name:@"PUSHCONTENT" object:nil];
    
    [self getHttpInfo];
    [self getXuQiuFangXing];
    [self getLaiFangQuDao];
    [self getJuZhuYeTai];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"PUSHCONTENT" object:nil];
}



-(void)getXuQiuFangXing
{
    NSString * strUrl = [[NSString alloc]initWithFormat:@"action=10&sign=2"];
//    NSLog(@"获取用户信息url: %@", strUrl);
    NSString * hexUrl  = [Utility hexStringFromString:strUrl];
    NSLog(@"需求房型hexurl: %@", API_BASE_URL(hexUrl));
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:API_BASE_URL(hexUrl) parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSString * strSign = [responseObject objectForKey:@"sign"];
        int intString = [strSign intValue];
        if (intString == 1) {
            [self.xuqiufangxingList removeAllObjects];
            NSMutableArray *arrInfo = [responseObject objectForKey:@"arr"];
            for (int i = 0; i < arrInfo.count ; i++) {
                NSDictionary *dicInfo = [arrInfo objectAtIndex:i];
                NSString * strId = [dicInfo objectForKey:@"id"];
                NSString * strName = [dicInfo objectForKey:@"name"];
                
                NSMutableDictionary *rowData = [[NSMutableDictionary alloc]init];
                [rowData setValue:strId forKey:@"id"];
                [rowData setValue:strName forKey:@"name"];
                
                [self.xuqiufangxingList addObject:rowData];
            }
            
        }else{
            NSLog(@"服务端返回错误");
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}

-(void)getJuZhuYeTai
{
    NSString * strUrl = [[NSString alloc]initWithFormat:@"action=10&sign=3"];
    //    NSLog(@"获取用户信息url: %@", strUrl);
    NSString * hexUrl  = [Utility hexStringFromString:strUrl];
    NSLog(@"居住业态hexurl: %@", API_BASE_URL(hexUrl));
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:API_BASE_URL(hexUrl) parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSString * strSign = [responseObject objectForKey:@"sign"];
        int intString = [strSign intValue];
        if (intString == 1) {
            [self.juzhuyetaiList removeAllObjects];
            NSMutableArray *arrInfo = [responseObject objectForKey:@"arr"];
            for (int i = 0; i < arrInfo.count ; i++) {
                NSDictionary *dicInfo = [arrInfo objectAtIndex:i];
                NSString * strId = [dicInfo objectForKey:@"id"];
                NSString * strName = [dicInfo objectForKey:@"name"];
                
                NSMutableDictionary *rowData = [[NSMutableDictionary alloc]init];
                [rowData setValue:strId forKey:@"id"];
                [rowData setValue:strName forKey:@"name"];
                
                [self.juzhuyetaiList addObject:rowData];
            }
            
        }else{
            NSLog(@"服务端返回错误");
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}

-(void)getLaiFangQuDao
{
    NSString * strUrl = [[NSString alloc]initWithFormat:@"action=10&sign=11"];
    //    NSLog(@"获取用户信息url: %@", strUrl);
    NSString * hexUrl  = [Utility hexStringFromString:strUrl];
    NSLog(@"来访渠道hexurl: %@", API_BASE_URL(hexUrl));
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:API_BASE_URL(hexUrl) parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSString * strSign = [responseObject objectForKey:@"sign"];
        int intString = [strSign intValue];
        if (intString == 1) {
            [self.laifangqudaoList removeAllObjects];
            NSMutableArray *arrInfo = [responseObject objectForKey:@"arr"];
            for (int i = 0; i < arrInfo.count ; i++) {
                NSDictionary *dicInfo = [arrInfo objectAtIndex:i];
                NSString * strId = [dicInfo objectForKey:@"id"];
                NSString * strName = [dicInfo objectForKey:@"name"];
                
                NSMutableDictionary *rowData = [[NSMutableDictionary alloc]init];
                [rowData setValue:strId forKey:@"id"];
                [rowData setValue:strName forKey:@"name"];
                
                [self.laifangqudaoList addObject:rowData];
            }
            
        }else{
            NSLog(@"服务端返回错误");
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}

-(void)getHttpInfo
{
//    NSString * strInstallment = @"02";
    //http://www.ykhome.cn/myhome/getcustomers.php?&fenterisecode=P00001&finstallment=01
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * strUrl = [[NSString alloc]initWithFormat:@"action=13&enterpriseCode=%@&installment=%@&userno=%@",[userDefaults objectForKey:@"enterpriseCode"],[userDefaults objectForKey:@"installment"],[userDefaults objectForKey:@"usercode"]];
    NSLog(@"获取用户信息url: %@", strUrl);
    NSString * hexUrl  = [Utility hexStringFromString:strUrl];
    NSLog(@"获取用户信息hexurl: %@", API_BASE_URL(hexUrl));
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:API_BASE_URL(hexUrl) parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [self analysisJson:(NSDictionary *)responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}


-(void)initAddPersonView
{
    UIButton *addPersonBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 2, AddBtnWIDTH, 42)];
    //button背景色
    //    addPersonBtn.backgroundColor = [UIColor greenColor];
    [addPersonBtn setBackgroundImage: [UIImage imageNamed:@"name_list_add2"] forState:UIControlStateNormal];
    [addPersonBtn setBackgroundImage: [UIImage imageNamed:@"name_list_add_selected"] forState:UIControlStateHighlighted];
    [addPersonBtn setBackgroundImage: [UIImage imageNamed:@"name_list_add_selected"] forState:UIControlStateSelected];
    addPersonBtn.showsTouchWhenHighlighted = YES;
    //    [addPersonBtn setTitle:@"添加" forState:UIControlStateNormal];
    [addPersonBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //设置button填充图片
    //[addPersonBtn setImage:[UIImage imageNamed:@"btng.png"] forState:UIControlStateNormal];
    [addPersonBtn addTarget:self action:@selector(addPersonBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:addPersonBtn];
    
   
    
    // 初始化tableView的数据
    
    
    
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, AddBtnWIDTH, FrameHEIGHT - 54) style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 设置tableView的数据源
    tableView.dataSource = self;
    // 设置tableView的委托
    tableView.delegate = self;
    // 设置tableView的背景图
    tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"name_list_bk"]];
    
    self.myTableView = tableView;
    
    NSString * strNum = [[NSString alloc]initWithFormat:@"共计%lu人",(unsigned long)[self.personList count]];
    //显示人数标签
    totalPersonLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, AddBtnWIDTH, 40)];
    UIView * tempView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, AddBtnWIDTH, 1)];
    [tempView setBackgroundColor:[UIColor blackColor]];
    [totalPersonLabel addSubview:tempView];
    [totalPersonLabel setText:strNum];
    [totalPersonLabel setTextColor:[UIColor whiteColor]];
    [totalPersonLabel setBackgroundColor:[UIColor grayColor]];
    [totalPersonLabel setTextAlignment:NSTextAlignmentCenter];
    //    [self.view addSubview:totalPersonLabel];
    self.myTableView.tableFooterView = totalPersonLabel;
    
    //增加搜索框
    mySearchBar = [[UISearchBar alloc] init];
    mySearchBar.frame = CGRectMake(0, 0, self.myTableView.bounds.size.width, 0);
    mySearchBar.delegate = self;
    mySearchBar.keyboardType = UIKeyboardTypeDefault;
    mySearchBar.showsCancelButton = NO;
    mySearchBar.showsBookmarkButton = NO;
    mySearchBar.placeholder = @"请输入";
    //    searchBar.barStyle = UIBarStyleBlack;
    mySearchBar.translucent = YES;
    mySearchBar.barStyle = UIBarStyleDefault;
    //    searchBar.tintColor = [UIColor redColor];
    mySearchBar.prompt = @"搜索";
    [mySearchBar sizeToFit];
    self.myTableView.tableHeaderView = mySearchBar;
    
    [self.view addSubview:myTableView];
    
    //默认选中第一行
    if([self.dataList count]>0){
        NSIndexPath *firstPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [myTableView selectRowAtIndexPath:firstPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    }
    
    
}
-(void)initView
{
    AddCustomerView *addCustomerView = [[AddCustomerView alloc] init];  //对AddCustomerView进行初始化
    addCustomerView.delegate = self;   // 将MyUIViewController自己的实例作为委托对象
    addView = addCustomerView;
}

//- (void)receivedPushContent:(NSNotification*)notification{
//    NSString *content = [notification object];
//    
//    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:content delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    [alter show];
//
////    [XWAlterview showmessage:@"新消息" subtitle:content cancelbutton:@"确定"];
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    nType = 0;
    
    self.laifangqudaoList = [[NSMutableArray alloc]init];
    self.xuqiufangxingList = [[NSMutableArray alloc]init];
    self.juzhuyetaiList = [[NSMutableArray alloc]init];
    
    self.personList = [NSMutableArray arrayWithObjects:@"李先生",@"刘先生",@"赵先生",@"杨先生", nil];
    self.arrPersonInfo = [[NSMutableArray alloc]init];
    self.personShowList = [[NSMutableArray alloc]init];
    self.dataList = [[NSMutableArray alloc]init];
    
    [self.navigationController.navigationBar setHidden:YES];
    
    [self initAddPersonView];
    
}

-(void)showDeatilCustomer:(NSString *)no
                     name:(NSString *)name
                      sex:(NSString *)sex
                    status:(NSString *)status
                      tel:(NSString *)tel
                 roomtype:(NSString *)roomtype
              livingspace:(NSString *)livingspace
                    owner:(NSString *)owner
              producttype:(NSString *)producttype
                callvisit:(NSString *)callvisit
                   getway:(NSString *)getway
               username:(NSString *)username
                   bugdet:(NSString *)bugdet
                intention:(NSString *)intention
{
    
    if (addView != nil) {
        [addView removeFromSuperview];
    }
    NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"CustomerDetailView" owner:self options:nil];
    myView = [array objectAtIndex:0];
    myView.frame = CGRectMake(AddBtnWIDTH, 2, FrameWIDTH - AddBtnWIDTH, FrameHEIGHT - 10);
    myView.delegate = self;
    myView.noLabel.text = no;
    myView.nameLabel.text = name;
    myView.sexLabel.text = sex;
    myView.statusLabel.text = status;
    myView.telLabel.text = tel;
    myView.roomtypeLabel.text = roomtype;
    myView.livingspaceLabel.text = livingspace;
    myView.ownerLabel.text = owner;
    myView.producttypeLabel.text = producttype;
    myView.callvisitLabel.text = callvisit;
    myView.getwayLabel.text = getway;
    myView.usernameLabel.text = username;
    myView.bugdetLabel.text = bugdet;
    myView.intentionLabel.text = intention;
    [myView initCustomNo:no];
    
    
    [self.view addSubview:myView];
}

- (id)loadNibNamed:(NSString *)nibName ofClass:(Class)objClass andOwner:(id)owner {
    if (nibName && objClass) {
        NSArray *objects = [[NSBundle mainBundle] loadNibNamed:nibName owner:owner options:nil];
        
        for (id currentObject in objects ){
            if ([currentObject isKindOfClass:objClass])
                return currentObject;
        }
    }
    
    return nil;
}

-(void)addPersonBtnPressed:(id)sender{
    //    UIButton* btn = (UIButton*)sender;
    if (myView != nil) {
        [myView removeFromSuperview];
    }
    
    addView = [self loadNibNamed:@"AddCustomerView" ofClass:[AddCustomerView class] andOwner:self];
    addView.frame = CGRectMake(AddBtnWIDTH, 2, FrameWIDTH - AddBtnWIDTH, FrameHEIGHT - 10);
    addView.delegate = self; // Or do this in the xib file
    [addView initDataLaifangqudao:self.laifangqudaoList xuqiufangxing:self.xuqiufangxingList juzhuyetai:self.juzhuyetaiList];
    [addView initType:0];
    [self.view addSubview:addView];
    
    NSLog(@"执行添加操作");
}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}
//滑动选择的行后删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dataList removeObjectAtIndex:indexPath.row];
        // Delete the row from the data source.
        [myTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellWithIdentifier];
    }
    NSUInteger row = [indexPath row];
    if (tableView == myTableView) {
//        cell.textLabel.text = [self.dataList objectAtIndex:row];
//        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
        UILabel * feelable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, AddBtnWIDTH, 40)];
        feelable.text = [self.dataList objectAtIndex:row];
        feelable.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:feelable];
        
    }
    cell.backgroundColor = [UIColor clearColor];
    
    //选中背景自定义
    cell.selectedBackgroundView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"name_item_selected_bk"]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    NSString * strNum = [[NSString alloc]initWithFormat:@"共计%lu人",(unsigned long)[self.personShowList count]];
    [totalPersonLabel setText:strNum];
    return totalPersonLabel;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
    if (table == myTableView) {
        return [self.dataList count];
    }else
        return 0;
    
}

//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

//点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    [self showDeatilCustomer];
    NSMutableDictionary *rowData = [[NSMutableDictionary alloc]init];
    rowData = [self.personShowList objectAtIndex:indexPath.row];
    
    NSUserDefaults * myDefaults = [NSUserDefaults standardUserDefaults];
    [myDefaults setInteger:indexPath.row forKey:@"CustomerSelectedNum"];
    [myDefaults synchronize];
    
    [self showDeatilCustomer:[rowData objectForKey:@"no"]
                        name:[rowData objectForKey:@"name"]
                         sex:[rowData objectForKey:@"sex"]
                      status:[rowData objectForKey:@"status"]
                         tel:[rowData objectForKey:@"tel"]
                    roomtype:[rowData objectForKey:@"roomtype"]
                 livingspace:[rowData objectForKey:@"livingspace"]
                       owner:[rowData objectForKey:@"owner"]
                 producttype:[rowData objectForKey:@"producttype"]
                   callvisit:[rowData objectForKey:@"callvisit"]
                      getway:[rowData objectForKey:@"getway"]
                    username:[rowData objectForKey:@"username"]
                      bugdet:[rowData objectForKey:@"bugdet"]
                   intention:[rowData objectForKey:@"intention"]];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.dataList removeAllObjects];
    [self.personShowList removeAllObjects];
    
    for(NSString * str in self.personList)
    {
        
        if([str hasPrefix:searchBar.text])
            
        {
            
            [self.dataList addObject:str];
            
            [self.personShowList addObject:[self.arrPersonInfo objectAtIndex:[self.personList indexOfObject:str]]];
        }
    }

    [self.myTableView reloadData];
    [searchBar resignFirstResponder];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text = @"";
    [searchBar resignFirstResponder];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if(0 == searchText.length)
        
    {
        [self.dataList removeAllObjects];
        [self.personShowList removeAllObjects];
        
        self.dataList = [self.personList mutableCopy];
        self.personShowList = [self.arrPersonInfo mutableCopy];
        [self.myTableView reloadData];
        return ;
    }
    
    [self.dataList removeAllObjects];
    [self.personShowList removeAllObjects];
    
    for(NSString * str in self.personList)
    {
        
        if([str hasPrefix:searchText])
            
        {
            
            [self.dataList addObject:str];
            
            [self.personShowList addObject:[self.arrPersonInfo objectAtIndex:[self.personList indexOfObject:str]]];
        }
    }
    
    [self.myTableView reloadData];
    
}



-(void)addPerson:(CustomerBean *)customer type:(int)type
{
    nType = type;
    [self removeAddPersonView];
//    [self.myTableView reloadData];
    [self getHttpInfo];
    [self getXuQiuFangXing];
    [self getLaiFangQuDao];
    [self getJuZhuYeTai];
    
}

-(void)removeAddPersonView
{
    NSLog(@"执行取消操作");
    [addView removeFromSuperview];
}

-(void)moveUpView:(UITextField *)textField
{
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 32 - (addView.frame.size.height - 352);//键盘高度216
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
        addView.frame = CGRectMake(AddBtnWIDTH, -offset, addView.frame.size.width, addView.frame.size.height);
    
    [UIView commitAnimations];
}
-(void)moveDownView:(UITextField *)textField
{
    addView.frame =CGRectMake(AddBtnWIDTH, 0, addView.frame.size.width, addView.frame.size.height);
}

-(void)moveUpCustomerDetailView:(UITextField *)textField
{
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 32 - (myView.frame.size.height - 352);//键盘高度216
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
        myView.frame = CGRectMake(AddBtnWIDTH, -offset, myView.frame.size.width, myView.frame.size.height);
    
    [UIView commitAnimations];

}
-(void)moveDownCustomerDetailView:(UITextField *)textField
{
    myView.frame =CGRectMake(AddBtnWIDTH, 2, myView.frame.size.width, myView.frame.size.height);
}

-(void)removeCustomer
{
    if (myView != nil) {
        [myView removeFromSuperview];
    }
    [self getHttpInfo];
}

-(void)modifyCustomer:(NSString *)strNo
{
    if (myView != nil) {
        [myView removeFromSuperview];
    }
    addView = [self loadNibNamed:@"AddCustomerView" ofClass:[AddCustomerView class] andOwner:self];
    addView.frame = CGRectMake(AddBtnWIDTH, 2, FrameWIDTH - AddBtnWIDTH, FrameHEIGHT - 10);
    addView.delegate = self; // Or do this in the xib file
    [addView initDataLaifangqudao:self.laifangqudaoList xuqiufangxing:self.xuqiufangxingList juzhuyetai:self.juzhuyetaiList];
    [addView initType:1];
    
    for (NSMutableDictionary *rowData in self.personShowList) {
        if ([strNo isEqualToString:[rowData objectForKey:@"no"]]) {
            NSString * strName = [rowData objectForKey:@"name"];
            NSString * strSex = [rowData objectForKey:@"sex"];
            NSString * strStatus = [rowData objectForKey:@"status"];
            NSString * strTel = [rowData objectForKey:@"tel"];
            NSString * strRoomtype = [rowData objectForKey:@"roomtype"];
            NSString * strLivingspace = [rowData objectForKey:@"livingspace"];
            NSString * strOwner = [rowData objectForKey:@"owner"];
            NSString * strProducttype = [rowData objectForKey:@"producttype"];
            NSString * strGetway = [rowData objectForKey:@"getway"];
            NSString * strBugdet = [rowData objectForKey:@"bugdet"];
            NSString * strIntention = [rowData objectForKey:@"intention"];

            NSInteger  nSex = 0;
            if ([@"女" isEqualToString:strSex]) {
                nSex = 1;
            }
            NSInteger   nStatus = 0;
            if ([@"来访" isEqualToString:strStatus]) {
                nStatus = 1;
            }
            NSInteger   nOwner = 0;
            if ([@"否" isEqualToString:strOwner]) {
                nOwner = 1;
            }
            NSInteger    nIntention = 0;
            if ([@"无" isEqualToString:strIntention]) {
                nIntention = 1;
            }else if([@"高" isEqualToString:strIntention]){
                nIntention = 2;
            }
            
            [addView initCustomerDataWithNo:strNo name:strName sex:nSex status:nStatus tel:strTel roomtype:strRoomtype livingspace:strLivingspace owner:nOwner producttype:strProducttype getway:strGetway bugdet:strBugdet intention:nIntention];
        }
    }
    
   
    
    
    [self.view addSubview:addView];
    
}


@end
