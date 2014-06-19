//
//  SuggestViewController.m
//  03-Modal
//
//  Created by apple on 13-9-9.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "SuggestViewController.h"

@interface SuggestViewController ()

@end

@implementation SuggestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.view endEditing:YES];
}

@end
