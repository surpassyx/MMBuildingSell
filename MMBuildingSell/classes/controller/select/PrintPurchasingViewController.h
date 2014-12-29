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
    
    NSMutableDictionary *houseData;
}

-(void)initData:(NSMutableDictionary *)dic;

@property (weak, nonatomic) IBOutlet UIButton *sexBtn;
@property (weak, nonatomic) IBOutlet UIButton *typeBtn;
@property (weak, nonatomic) IBOutlet UIButton *fanganBtn;
- (IBAction)sexAction:(id)sender;
- (IBAction)typeAction:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *roomNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *roomTypelabel;
@property (strong, nonatomic) IBOutlet UILabel *allPriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *realPriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *allAresLabel;
@property (strong, nonatomic) IBOutlet UILabel *realAresLabel;
@property (strong, nonatomic) IBOutlet UILabel *totalLabel;

@end
