//
//  AddCustomerView.h
//  MMBuildingSell
//
//  Created by 3G组 on 13-11-27.
//  Copyright (c) 2013年 Y.X. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerBean.h"


@protocol AddCustomerDelegate

@optional

-(void)addPerson:(CustomerBean *)customer;
-(void)removeAddPersonView;

-(void)moveUpView:(UITextField *)textField;
-(void)moveDownView:(UITextField *)textField;

@end


@interface AddCustomerView : UIView<UITextFieldDelegate>{
    
    id<AddCustomerDelegate> delegate;
    
}
@property(retain,nonatomic)id<AddCustomerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *tel;
@property (weak, nonatomic) IBOutlet UITextField *wantType;
@property (weak, nonatomic) IBOutlet UITextField *wantLevel;
@property (weak, nonatomic) IBOutlet UITextField *getWay;
@property (weak, nonatomic) IBOutlet UITextField *mudi;
@property (weak, nonatomic) IBOutlet UITextField *workSpace;
@property (weak, nonatomic) IBOutlet UITextField *danwei;
@property (weak, nonatomic) IBOutlet UITextField *juzhuquyu;
@property (weak, nonatomic) IBOutlet UITextField *jiatingjiegou;
@property (weak, nonatomic) IBOutlet UITextField *nianshouru;
@property (weak, nonatomic) IBOutlet UITextField *car;
@property (weak, nonatomic) IBOutlet UITextField *age;
@property (weak, nonatomic) IBOutlet UITextField *xianyoufangchan;
- (IBAction)cancelAction:(id)sender;
- (IBAction)okAction:(id)sender;


@end
