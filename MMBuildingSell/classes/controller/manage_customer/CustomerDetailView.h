//
//  CustomerDetailView.h
//  MMBuildingSell
//
//  Created by 3G组 on 13-11-11.
//  Copyright (c) 2013年 Y.X. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHPickView.h"

@protocol CustomerDetailDelegate

@optional

-(void)moveUpCustomerDetailView:(UITextField *)textField;
-(void)moveDownCustomerDetailView:(UITextField *)textField;

-(void)removeCustomer;

-(void)modifyCustomer:(NSString *)strNo;

@end

@interface CustomerDetailView : UIView<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,ZHPickViewDelegate>{
    id<CustomerDetailDelegate> delegate;
    NSString * strCustomNo;
    UIActionSheet * startsheet;
}


@property(retain,nonatomic)id<CustomerDetailDelegate> delegate;

@property(nonatomic,strong)ZHPickView *pickview;
@property (strong, nonatomic) IBOutlet UILabel *noLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *telLabel;
@property (weak, nonatomic) IBOutlet UILabel *roomtypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *livingspaceLabel;
@property (weak, nonatomic) IBOutlet UILabel *ownerLabel;
@property (weak, nonatomic) IBOutlet UILabel *producttypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *callvisitLabel;
@property (weak, nonatomic) IBOutlet UILabel *getwayLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bugdetLabel;
@property (weak, nonatomic) IBOutlet UILabel *intentionLabel;

@property (strong, nonatomic) IBOutlet UIButton *setDateBtn;
@property (strong, nonatomic) IBOutlet UITextField *remarkTextField;
@property (strong, nonatomic) IBOutlet UITextField *tixingTextField;
@property (strong, nonatomic) IBOutlet UITableView *myTable;
@property (strong, nonatomic) IBOutlet UISegmentedControl *callvisitSeg;

@property (nonatomic, retain) NSMutableArray *dataList;

- (IBAction)setDateAction:(id)sender;

- (IBAction)addZhuiZongAction:(id)sender;

- (IBAction)xiugaiAction:(id)sender;


- (IBAction)deleteAction:(id)sender;

-(void)initCustomNo:(NSString *)strNo;

@end
