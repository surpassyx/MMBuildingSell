//
//  PrintPurchasingViewController.h
//  MMBuildingSell
//  置业计划书填写打印
//  Created by 3G组 on 13-10-23.
//  Copyright (c) 2013年 Y.X. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"

@interface PrintPurchasingViewController : UIViewController<NIDropDownDelegate>{

    NIDropDown *dropDownType;
    NIDropDown *dropDownSex;
}
@property (weak, nonatomic) IBOutlet UIButton *sexBtn;
@property (weak, nonatomic) IBOutlet UIButton *typeBtn;
@property (weak, nonatomic) IBOutlet UIButton *fanganBtn;
- (IBAction)sexAction:(id)sender;
- (IBAction)typeAction:(id)sender;

@end
