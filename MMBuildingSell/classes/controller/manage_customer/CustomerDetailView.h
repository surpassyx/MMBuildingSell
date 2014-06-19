//
//  CustomerDetailView.h
//  MMBuildingSell
//
//  Created by 3G组 on 13-11-11.
//  Copyright (c) 2013年 Y.X. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMRatingControl.h"

@interface CustomerDetailView : UIView<UITableViewDataSource,UITableViewDelegate>{
//    UIView *view;
    AMRatingControl *simpleRatingControl;
}

//@property (nonatomic, retain) IBOutlet UIView *view;

@property (nonatomic, retain) NSMutableArray *dataDetailList;


@property (strong, nonatomic) IBOutlet UILabel *fname;
@property (weak, nonatomic) IBOutlet UILabel *tel;
@property (weak, nonatomic) IBOutlet UILabel *wantType;
@property (weak, nonatomic) IBOutlet UILabel *getWay;
@property (weak, nonatomic) IBOutlet UILabel *mudi;
@property (weak, nonatomic) IBOutlet UILabel *workSpace;
@property (weak, nonatomic) IBOutlet UILabel *age;
@property (weak, nonatomic) IBOutlet UITableView *tableJIlu;
@property (weak, nonatomic) IBOutlet UILabel *yixiangdengji;
@property (weak, nonatomic) IBOutlet UILabel *gongzuodanwei;
@property (weak, nonatomic) IBOutlet UILabel *juzhuquyu;
@property (weak, nonatomic) IBOutlet UILabel *car;
@property (weak, nonatomic) IBOutlet UILabel *nianshouru;
@property (weak, nonatomic) IBOutlet UILabel *jiatingjiegou;
@property (weak, nonatomic) IBOutlet UILabel *xianyoufangchan;
@property (weak, nonatomic) IBOutlet UITextField *remarkTextField;
- (IBAction)addRemark:(id)sender;

@end
