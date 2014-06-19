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

@interface SelectViewController : UIViewController<MSGridViewDataSource,MSGridViewDelegate,NIDropDownDelegate,UIGestureRecognizerDelegate>{
    MSGridView *gridView;

    UIImageView  *imageView;
    
    UILabel *showLabel;
    
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
    
//    UILabel *okLabel;
//    
//    UILabel *okLabel2;

    
//    QCheckBox * check1;
//    QCheckBox * check2;
//    QCheckBox * check3;
    
//    UIButton * jisuanBtn;
    UIButton * nextBtn;
    
    UIButton * selectBtn;
    NIDropDown *dropDown;
    
    UIImageView  *imageViewLeftBk;
    UIImageView  *imageViewRightBk;
}

@property (nonatomic, retain) NSMutableArray *dataList;

@end
