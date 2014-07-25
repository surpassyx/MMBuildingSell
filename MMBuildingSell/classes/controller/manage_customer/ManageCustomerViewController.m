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
@synthesize arrPersonInfo;


#define FrameWIDTH 812.0
#define FrameHEIGHT 748.0

#define AddBtnWIDTH 161


-(void)analysisJson:(NSDictionary *)jsonDic
{
    //    NSError *error;
    //    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:date options:NSJSONReadingMutableLeaves error:&error];
    
    //{"sign":"1","arr":[{"fcustomername":"刘文波","ftel":"1338800888","froomtype":"二室一厅","fposition":"公务员","fgetway":"旗标","fpurpose":"新居","fworkplace":"大东","farea":"80-100","ffamilyregion":"大东区","ffamilyincome":"5万","fcardetail":"福特","fage":"30","fhavehouse":"1","id":"1"},{"fcustomername":"张珊","ftel":"13898823456","froomtype":"三室一厅","fposition":"部门经理","fgetway":"路过","fpurpose":"改善","fworkplace":"浑南","farea":"120-140","ffamilyregion":"大东","ffamilyincome":"30万","fcardetail":"酷路泽","fage":"30","fhavehouse":"2","id":"1"}]}
    NSString * strSign = [jsonDic objectForKey:@"sign"];
    int intString = [strSign intValue];
    if (intString == 1) {
        NSMutableArray *arrInfo = [jsonDic objectForKey:@"arr"];
        for (int i = 0; i < arrInfo.count ; i++) {
            NSDictionary *dicInfo = [arrInfo objectAtIndex:i];
            NSString * strName = [dicInfo objectForKey:@"fcustomername"];
            NSString * strTel =[dicInfo objectForKey:@"ftel"];
            NSString * strType = [dicInfo objectForKey:@"froomtype"];
            NSString * strGetway = [dicInfo objectForKey:@"fgetway"];
            NSString * strPurpose = [dicInfo objectForKey:@"fpurpose"];
            NSString * strWorkplace =[dicInfo objectForKey:@"fworkplace"];
            NSString * strPosition = [dicInfo objectForKey:@"fposition"];
            NSString * strArea = [dicInfo objectForKey:@"farea"];
            NSString * strFamilyRegion = [dicInfo objectForKey:@"ffamilyregion"];
            NSString * strFamilyIncom = [dicInfo objectForKey:@"ffamilyincome"];
            NSString * strCarDetail = [dicInfo objectForKey:@"fcardetail"];
            NSString * strAge = [dicInfo objectForKey:@"fage"];
            NSString * strHaveHouse = [dicInfo objectForKey:@"fhavehouse"];
            NSString * strId = [dicInfo objectForKey:@"id"];
            
            
            NSMutableDictionary *rowData = [[NSMutableDictionary alloc]init];
            [rowData setValue:strId forKey:@"id"];
            [rowData setValue:strName forKey:@"fcustomername"];
            [rowData setValue:strTel forKey:@"ftel"];
            [rowData setValue:strType forKey:@"froomtype"];
            [rowData setValue:strGetway forKey:@"fgetway"];
            [rowData setValue:strPurpose forKey:@"fpurpose"];
            [rowData setValue:strWorkplace forKey:@"fworkplace"];
            [rowData setValue:strPosition forKey:@"fposition"];
            [rowData setValue:strArea forKey:@"farea"];
            [rowData setValue:strFamilyRegion forKey:@"ffamilyregion"];
            [rowData setValue:strFamilyIncom forKey:@"ffamilyincome"];
            [rowData setValue:strCarDetail forKey:@"fcardetail"];
            [rowData setValue:strAge forKey:@"fage"];
            [rowData setValue:strHaveHouse forKey:@"fhavehouse"];
            
            [self.personList addObject:strName];
            
            [self.arrPersonInfo addObject:rowData];
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
    NSString * strInstallment = @"01";
    //http://www.ykhome.cn/myhome/getcustomers.php?&fenterisecode=P00001&finstallment=01
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * strUrl = [[NSString alloc]initWithFormat:@"http://www.ykhome.cn/myhome/getcustomers.php?&no=%@&fenterpriseCode=%@&finstallment=%@",[userDefaults objectForKey:@"no"],[userDefaults objectForKey:@"enterpriseCode"],strInstallment];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:strUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
    
    NSString * strNum = [[NSString alloc]initWithFormat:@"共计%d人",4];
    //显示人数标签
    UILabel * totalPersonLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 45, AddBtnWIDTH, 40)];
    [totalPersonLabel setText:strNum];
    [totalPersonLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:totalPersonLabel];
    
    // 初始化tableView的数据
    self.personList = [NSMutableArray arrayWithObjects:@"李先生",@"刘先生",@"赵先生",@"杨先生", nil];
    
    NSMutableArray *jilulist = [NSMutableArray arrayWithObjects:@"活动记录1",@"活动记录2",@"活动记录3", nil];
    
    self.dataList = self.personList;
    self.dataDetailList = jilulist;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 85, AddBtnWIDTH, FrameHEIGHT-46 - 10 - 45) style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 设置tableView的数据源
    tableView.dataSource = self;
    // 设置tableView的委托
    tableView.delegate = self;
    // 设置tableView的背景图
    tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"name_list_bk"]];
    
    self.myTableView = tableView;
    
    //增加搜索框
    UISearchBar * searchBar = [[UISearchBar alloc] init];
    searchBar.frame = CGRectMake(0, 0, self.myTableView.bounds.size.width, 0);
    searchBar.delegate = self;
    searchBar.keyboardType = UIKeyboardTypeDefault;
    searchBar.showsCancelButton = NO;
    searchBar.showsBookmarkButton = NO;
    searchBar.placeholder = @"请输入";
    //    searchBar.barStyle = UIBarStyleBlack;
    searchBar.translucent = YES;
    searchBar.barStyle = UIBarStyleBlackTranslucent;
    //    searchBar.tintColor = [UIColor redColor];
    searchBar.prompt = @"搜索";
    [searchBar sizeToFit];
    self.myTableView.tableHeaderView = searchBar;
    
    [self.view addSubview:myTableView];
    
    //默认选中第一行
    NSIndexPath *firstPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [myTableView selectRowAtIndexPath:firstPath animated:YES scrollPosition:UITableViewScrollPositionTop];

}
-(void)initView
{
    AddCustomerView *addCustomerView = [[AddCustomerView alloc] init];  //对AddCustomerView进行初始化
    addCustomerView.delegate = self;   // 将MyUIViewController自己的实例作为委托对象
    addView = addCustomerView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self.navigationController.navigationBar setHidden:YES];
    
    [self initAddPersonView];
    
    NSMutableDictionary *rowData = [[NSMutableDictionary alloc]init];
    rowData = [self.arrPersonInfo objectAtIndex:0];
    
    [self showDeatilCustomer:[rowData objectForKey:@"ftel"] wantType:[rowData objectForKey:@"froomtype"] level:@"1" getWay:[rowData objectForKey:@"fgetway"] mudi:[rowData objectForKey:@"fpurpose"] workspace:[rowData objectForKey:@"fworkplace"] age:[rowData objectForKey:@"fage"] yixiangdengji:@"1" gongzuodanwei:[rowData objectForKey:@"fworkplace"] juzhuquyu:[rowData objectForKey:@"ffamilyregion"] car:[rowData objectForKey:@"fcardetail"] nianshouru:[rowData objectForKey:@"ffamilyincome"] jiatingjiegou:[rowData objectForKey:@"ffamilyincome"] xianyoufangchan:[rowData objectForKey:@"fhavehouse"] fname:[rowData objectForKey:@"fcustomername"]];
}

-(void)showDeatilCustomer:(NSString *)tel
                 wantType:(NSString *)wantType
                    level:(NSString *)level
                   getWay:(NSString *)getway
                     mudi:(NSString *)mudi
                workspace:(NSString *)workspace
                   age:(NSString *)age
            yixiangdengji:(NSString *)yixiangdengji
            gongzuodanwei:(NSString *)gongzuodanwei
                juzhuquyu:(NSString *)juzhuquyu
                      car:(NSString *)car
               nianshouru:(NSString *)nianshouru
            jiatingjiegou:(NSString *)jiatingjiegou
          xianyoufangchan:(NSString *)xianyoufangchan
                    fname:(NSString *)fname
{
    
    if (addView != nil) {
        [addView removeFromSuperview];
    }
    NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"CustomerDetailView" owner:self options:nil];
    myView = [array objectAtIndex:0];
    myView.frame = CGRectMake(AddBtnWIDTH, 2, FrameWIDTH - AddBtnWIDTH, FrameHEIGHT - 10);
    myView.tel.text = tel;
    myView.wantType.text = wantType;
    myView.getWay.text = getway;
    myView.mudi.text = mudi;
    myView.workSpace.text = workspace;
    myView.age.text = age;
    myView.yixiangdengji.text = yixiangdengji;
    myView.gongzuodanwei.text = gongzuodanwei;
    myView.juzhuquyu.text = juzhuquyu;
    myView.car.text = car;
    myView.nianshouru.text = nianshouru;
    myView.jiatingjiegou.text = jiatingjiegou;
    myView.xianyoufangchan.text = xianyoufangchan;
    myView.fname.text = fname;
    
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

//    NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"AddCustomerView" owner:self options:nil];
//    addView = [array objectAtIndex:0];
//    addView.frame = CGRectMake(AddBtnWIDTH, 2, FrameWIDTH - AddBtnWIDTH, FrameHEIGHT - 10);
    
    addView = [self loadNibNamed:@"AddCustomerView" ofClass:[AddCustomerView class] andOwner:self];
    addView.frame = CGRectMake(AddBtnWIDTH, 2, FrameWIDTH - AddBtnWIDTH, FrameHEIGHT - 10);
    addView.delegate = self; // Or do this in the xib file
    [self.view addSubview:addView];
    
//    [addView setDelegate:self];
//    [self.view addSubview:addView];
    
    NSLog(@"执行添加操作");
}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
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
        cell.textLabel.text = [self.dataList objectAtIndex:row];
    }else if(tableView == myView.tableJIlu){
        cell.textLabel.text = [self.dataDetailList objectAtIndex:row];
    }
    cell.backgroundColor = [UIColor clearColor];
    
   //    cell.imageView.image = [UIImage imageNamed:@"green.png"];
//    cell.detailTextLabel.text = @"详细信息";
    
    //选中背景自定义
    cell.selectedBackgroundView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"name_item_selected_bk"]];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
    if (table == myTableView) {
       return [self.dataList count];
    }else if(table == myView.tableJIlu){
        return [self.dataDetailList count];
    }else
        return 0;
    
}
//设置缩进
//- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return [indexPath row];
//}
//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
//设置cell的隔行换色
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([indexPath row] % 2 == 0) {
//        cell.backgroundColor = [UIColor blueColor];
//    } else {
//        cell.backgroundColor = [UIColor greenColor];
//    }
//}
//点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [self showDeatilCustomer];
    NSMutableDictionary *rowData = [[NSMutableDictionary alloc]init];
    rowData = [self.arrPersonInfo objectAtIndex:indexPath.row];
    
    
    [self showDeatilCustomer:[rowData objectForKey:@"ftel"] wantType:[rowData objectForKey:@"froomtype"] level:@"1" getWay:[rowData objectForKey:@"fgetway"] mudi:[rowData objectForKey:@"fpurpose"] workspace:[rowData objectForKey:@"fworkplace"] age:[rowData objectForKey:@"fage"] yixiangdengji:@"1" gongzuodanwei:[rowData objectForKey:@"fworkplace"] juzhuquyu:[rowData objectForKey:@"ffamilyregion"] car:[rowData objectForKey:@"fcardetail"] nianshouru:[rowData objectForKey:@"ffamilyincome"] jiatingjiegou:[rowData objectForKey:@"ffamilyincome"] xianyoufangchan:[rowData objectForKey:@"fhavehouse"] fname:[rowData objectForKey:@"fcustomername"]];
    
//    NSString *msg = [[NSString alloc] initWithFormat:@"你选择的是:%@",[self.dataList objectAtIndex:[indexPath row]]];
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//    [alert show];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.dataList removeAllObjects];
    for(NSString * data in self.personList)
    {
        if([data hasPrefix:searchBar.text])
        {
            [self.dataList  addObject: data];
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
        return ;
    }

    [self.dataList removeAllObjects];

    for(NSString * str in self.personList)
    {

        if([str hasPrefix:searchText])

        {

            [self.dataList addObject:str];

        }
    }

    [self.myTableView reloadData];

}



-(void)addPerson:(CustomerBean *)customer
{
    [self removeAddPersonView];
    [self.myTableView reloadData];
}

-(void)removeAddPersonView
{
    NSLog(@"执行取消操作");
    [addView removeFromSuperview];
}

-(void)moveUpView:(UITextField *)textField
{
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 32 - (addView.frame.size.height - 216.0);//键盘高度216
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
        addView.frame = CGRectMake(0.0f, -offset, addView.frame.size.width, addView.frame.size.height);
    
    [UIView commitAnimations];
}
-(void)moveDownView:(UITextField *)textField
{
    addView.frame =CGRectMake(0, 0, addView.frame.size.width, addView.frame.size.height);
}


@end
