//
//  CalculatorViewController.h
//  MMBuildingSell
//
//  Created by 3G组 on 14-1-7.
//  Copyright (c) 2014年 Y.X. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomButton.h"

@interface CalculatorViewController : UIViewController
{
    CustomButton *_button1;
	CustomButton *_button2;
	CustomButton *_button3;
	CustomButton *_button4;
	CustomButton *_button5;
	CustomButton *_button6;
	CustomButton *_button7;
	CustomButton *_button8;
	CustomButton *_button9;
	CustomButton *_button0;
	CustomButton *_buttonPoint;
	
	CustomButton *_buttonPlus;
	CustomButton *_buttonMinus;
	CustomButton *_buttonDivide;
	CustomButton *_buttonMultiply;
	CustomButton *_buttonClear;
	CustomButton *_buttonEquals;
	CustomButton *_buttonPlusminus;
    
    NSMutableArray *_buttons;
    
    int nSum;//存放运算符左边的数
    NSMutableString * strShow;//存放字符串
    int number;//存放运算符右边数
    
    UILabel *showLabel;
    
    
//    int number;
    BOOL function;
    BOOL isFlage;
    BOOL isResult;
    BOOL isAgain;
    BOOL isPress;
    NSString *num;
    NSString *nums;
    int TEMP;
    
}

- (void)plus:(id)sender Num:(NSString *)value;
- (void)minus:(id)sender Num:(NSString *)value;
- (void)multiple:(id)sender Num:(NSString *)value;
- (void)divide:(id)sender Num:(NSString *)value;
- (void)clearshow:(id)sender Num:(int)value;

@property int nSum;
@property int number;
@property(strong,nonatomic) NSMutableString * strShow;

@property (retain) CustomButton *button1;
@property (retain) CustomButton *button2;
@property (retain) CustomButton *button3;
@property (retain) CustomButton *button4;
@property (retain) CustomButton *button5;
@property (retain) CustomButton *button6;
@property (retain) CustomButton *button7;
@property (retain) CustomButton *button8;
@property (retain) CustomButton *button9;
@property (retain) CustomButton *button0;
@property (retain) CustomButton *buttonPoint;

@property (retain) CustomButton *buttonPlus;
@property (retain) CustomButton *buttonMinus;
@property (retain) CustomButton *buttonDivide;
@property (retain) CustomButton *buttonMultiply;
@property (retain) CustomButton *buttonEquals;
@property (retain) CustomButton *buttonClear;
@property (retain) CustomButton *buttonPlusminus;

@property (retain) NSMutableArray *buttons;

@end
