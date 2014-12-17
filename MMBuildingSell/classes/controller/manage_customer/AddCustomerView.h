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

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *telTextField;
@property (weak, nonatomic) IBOutlet UITextField *livingspaceTextField;
@property (weak, nonatomic) IBOutlet UITextField *bugdetTextField;

@property (weak, nonatomic) IBOutlet UISegmentedControl *sexSeg;
@property (weak, nonatomic) IBOutlet UISegmentedControl *statusSeg;
@property (weak, nonatomic) IBOutlet UISegmentedControl *ownerSeg;
@property (weak, nonatomic) IBOutlet UISegmentedControl *callvisitSeg;
@property (weak, nonatomic) IBOutlet UISegmentedControl *intentionSeg;


- (IBAction)cancelAction:(id)sender;
- (IBAction)okAction:(id)sender;


@end
