//
//  AddCustomerView.h
//  MMBuildingSell
//
//  Created by 3G组 on 13-11-27.
//  Copyright (c) 2013年 Y.X. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerBean.h"

#import "NIDropDown.h"


@protocol AddCustomerDelegate

@optional

-(void)addPerson:(CustomerBean *)customer type:(int)type;
-(void)removeAddPersonView;

-(void)moveUpView:(UITextField *)textField;
-(void)moveDownView:(UITextField *)textField;

@end


@interface AddCustomerView : UIView<UITextFieldDelegate,NIDropDownDelegate>{
    
    id<AddCustomerDelegate> delegate;
    
    NIDropDown *dropDownLaiFang;
    NIDropDown *dropDownXuQiu;
    NIDropDown *dropDownJuZhu;
    
    NSString * strSelectIdLaiFang;
    NSString * strSelectIdXuQiu;
    NSString * strSelectIdJuZhu;
    
    int nType; //0 添加  1  编辑
    
    NSString * strCustomerNo;
    
}
@property(retain,nonatomic)id<AddCustomerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *telTextField;
@property (weak, nonatomic) IBOutlet UITextField *livingspaceTextField;
@property (weak, nonatomic) IBOutlet UITextField *bugdetTextField;

@property (weak, nonatomic) IBOutlet UISegmentedControl *sexSeg;
@property (weak, nonatomic) IBOutlet UISegmentedControl *statusSeg;
@property (weak, nonatomic) IBOutlet UISegmentedControl *ownerSeg;
//@property (weak, nonatomic) IBOutlet UISegmentedControl *callvisitSeg;
@property (weak, nonatomic) IBOutlet UISegmentedControl *intentionSeg;


@property (nonatomic, retain) NSMutableArray *laifangqudaoList;
@property (nonatomic, retain) NSMutableArray *xuqiufangxingList;
@property (nonatomic, retain) NSMutableArray *juzhuyetaiList;

@property (weak, nonatomic) IBOutlet UIButton *laifangqudaoBtn;
@property (weak, nonatomic) IBOutlet UIButton *xuqiufangxingBtn;
@property (weak, nonatomic) IBOutlet UIButton *juzhuyetaiBtn;


- (IBAction)cancelAction:(id)sender;
- (IBAction)okAction:(id)sender;


- (IBAction)dddddAction:(id)sender;

-(void)initType:(int)type;

-(void)initDataLaifangqudao:(NSMutableArray *)laifangqudao
              xuqiufangxing:(NSMutableArray *)xuqiufangxing
              juzhuyetai:(NSMutableArray *)juzhuyetai;


-(void)initCustomerDataWithNo:(NSString *)strNO
                         name:(NSString *)strName
                            sex:(NSInteger)nSex
                         status:(NSInteger )nStatus
                            tel:(NSString *)strTel
                       roomtype:(NSString *)strRoomtype
                    livingspace:(NSString *)strLivingspace
                          owner:(NSInteger )nOwner
                    producttype:(NSString *)strProducttype
                         getway:(NSString *)strGetway
                         bugdet:(NSString *)strBugdet
                      intention:(NSInteger )nIntention;

@end
