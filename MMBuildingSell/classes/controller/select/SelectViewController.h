//
//  SelectViewController.h
//  MMBuildingSell
//
//  Created by 3G组 on 13-10-14.
//  Copyright (c) 2013年 Y.X. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSGridView.h"
#import "QCheckBox.h"
#import "PrintPurchasingViewController.h"
#import "NIDropDown.h"

@interface SelectViewController : UIViewController<UIGestureRecognizerDelegate>{

    UIImageView  *imageView;
    
    UILabel *roomNameLabel;
    
    UILabel *roomSatausLabel;
    
    UILabel *roomTypeLabel;
    
    UILabel *allAresLabel;
    
    UILabel *realAresLabel;
    
    UILabel *realPriceLabel;
    
    UILabel *danjiaLabel;
    
    UILabel *totalLabel;
    
    UILabel *freeLabel;
    
    UITextField *freeFieldText;
    
    UILabel *freeLabel2;
    
    UIButton *freeJisuanBtn;
    
    UILabel *freeTotalLabel;
    
    UITextField *freeTotalFieldText;
    
    UILabel *freeTotalLabel2;
    
    UIButton *freeTotalJisuanBtn;
    
    UIButton * nextBtn;
    
//    UIButton * selectBtn;
//    NIDropDown *dropDown;
    
    UIImageView  *imageViewLeftBk;
    UIImageView  *imageViewRightBk;
    
    NSMutableDictionary *rowHouseData;
    
    NSString * strLouDongName;
}

@property (nonatomic, retain) NSMutableArray *dataList;

@end
