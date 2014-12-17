//
//  CustomerDetailView.h
//  MMBuildingSell
//
//  Created by 3G组 on 13-11-11.
//  Copyright (c) 2013年 Y.X. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMRatingControl.h"

@interface CustomerDetailView : UIView{
//    UIView *view;
    AMRatingControl *simpleRatingControl;
}

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

@end
