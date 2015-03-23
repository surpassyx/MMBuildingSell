//
//  ManageCustomerViewController.h
//  MMBuildingSell
//
//  Created by 3G组 on 13-10-14.
//  Copyright (c) 2013年 Y.X. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerDetailView.h"
#import "AddCustomerView.h"
#import "CustomerBean.h"

@interface ManageCustomerViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate,AddCustomerDelegate,CustomerDetailDelegate>{
    
    CustomerDetailView *myView;
    AddCustomerView *addView;
    
    UILabel * totalPersonLabel;
    UISearchBar * mySearchBar;
    int nType;
}
@property (nonatomic, retain) NSMutableArray *personList;
@property (nonatomic, retain) NSMutableArray *personShowList;
@property (nonatomic, retain) NSMutableArray *dataList;
@property (nonatomic, retain) UITableView *myTableView;
@property (nonatomic, retain) NSMutableArray *arrPersonInfo;

@property (nonatomic, retain) NSMutableArray *laifangqudaoList;
@property (nonatomic, retain) NSMutableArray *xuqiufangxingList;
@property (nonatomic, retain) NSMutableArray *juzhuyetaiList;


@end
