//
//  CalculatorViewController.m
//  MMBuildingSell
//
//  Created by 3G组 on 14-1-7.
//  Copyright (c) 2014年 Y.X. All rights reserved.
//

#import "CalculatorViewController.h"

@interface CalculatorViewController ()

@end

@implementation CalculatorViewController
@synthesize	button1=_button1;
@synthesize	button2=_button2;
@synthesize	button3=_button3;
@synthesize	button4=_button4;
@synthesize	button5=_button5;
@synthesize	button6=_button6;
@synthesize	button7=_button7;
@synthesize	button8=_button8;
@synthesize	button9=_button9;
@synthesize	button0=_button0;
@synthesize	buttonPoint=_buttonPoint;

@synthesize	buttonPlus=_buttonPlus;
@synthesize	buttonMinus=_buttonMinus;
@synthesize	buttonDivide=_buttonDivide;
@synthesize	buttonMultiply=_buttonMultiply;
@synthesize	buttonEquals=_buttonEquals;
@synthesize	buttonClear=_buttonClear;
@synthesize	buttonPlusminus=_buttonPlusminus;

@synthesize buttons=_buttons;

@synthesize nSum,number,strShow;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGFloat height=50;
	CGFloat width=80;
	CGFloat col1=0;
	CGFloat row1=245;
	CGFloat row0=190;
	
	CGFloat spacingy=3;
	CGFloat row2=row1+height+spacingy;
	CGFloat row3=row2+height+spacingy;
	CGFloat row4=row3+height+spacingy;
	CGFloat spacingx=0;
	CGFloat col2=col1+width+spacingx;
	CGFloat col3=col2+width+spacingx;
	CGFloat col4=col3+width+spacingx;
    
    showLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width , 100)];
    showLabel.backgroundColor = [UIColor clearColor];//清空背景颜色
    showLabel.textColor = [UIColor blueColor];//字体颜色
    showLabel.textAlignment = NSTextAlignmentRight;//字体居右
    showLabel.font = [UIFont systemFontOfSize:32.4];
    [self.view addSubview:showLabel];
	
	
	self.button7 = [[CustomButton alloc] initWithText:@"7" target:self selector:@selector(buttonTapped:)];
	_button7.frame = CGRectMake(col1,row1, width, height);
	self.button8 = [[CustomButton alloc] initWithText:@"8" target:self selector:@selector(buttonTapped:)];
	_button8.frame = CGRectMake(col2,row1, width, height);
	self.button9 = [[CustomButton alloc] initWithText:@"9" target:self selector:@selector(buttonTapped:)];
	_button9.frame = CGRectMake(col3,row1, width, height);
	self.button4 = [[CustomButton alloc] initWithText:@"4" target:self selector:@selector(buttonTapped:)];
	_button4.frame = CGRectMake(col1,row2, width, height);
	self.button5 = [[CustomButton alloc] initWithText:@"5" target:self selector:@selector(buttonTapped:)];
	_button5.frame = CGRectMake(col2,row2, width, height);
	self.button6 = [[CustomButton alloc] initWithText:@"6" target:self selector:@selector(buttonTapped:)];
	_button6.frame = CGRectMake(col3,row2, width, height);
	self.button1 = [[CustomButton alloc] initWithText:@"1" target:self selector:@selector(buttonTapped:)];
	_button1.frame = CGRectMake(col1,row3, width, height);
	self.button2 = [[CustomButton alloc] initWithText:@"2" target:self selector:@selector(buttonTapped:)];
	_button2.frame = CGRectMake(col2,row3, width, height);
	self.button3 = [[CustomButton alloc] initWithText:@"3" target:self selector:@selector(buttonTapped:)];
	_button3.frame = CGRectMake(col3,row3, width, height);
	self.button0 = [[CustomButton alloc] initWithText:@"0" target:self selector:@selector(buttonTapped:)];
	_button0.frame = CGRectMake(col1,row4, width*2, height);
	self.buttonPoint = [[CustomButton alloc] initWithText:@"." target:self selector:@selector(buttonTapped:)];
	_buttonPoint.frame = CGRectMake(col3,row4, width, height);
    
	self.buttonEquals = [[CustomButton alloc] initWithTextAndHSB:@"" target:self selector:@selector(buttonTapped:) hue:0.075f saturation:0.9f brightness:0.96f];
	_buttonEquals.frame = CGRectMake(col4,row3, width, height*2);
    
	self.buttonPlus = [[CustomButton alloc] initWithTextAndHSB:@"" target:self selector:@selector(buttonTapped:) hue:0.058f saturation:0.26f brightness:0.42f];
	_buttonPlus.frame = CGRectMake(col4,row2, width, height);
	self.buttonMinus = [[CustomButton alloc] initWithTextAndHSB:@"" target:self selector:@selector(buttonTapped:) hue:0.058f saturation:0.26f brightness:0.42f];
	_buttonMinus.frame = CGRectMake(col4,row1, width, height);
	self.buttonMultiply = [[CustomButton alloc] initWithTextAndHSB:@"" target:self selector:@selector(buttonTapped:) hue:0.058f saturation:0.26f brightness:0.42f];
	_buttonMultiply.frame = CGRectMake(col4,row0, width, height);
    
	self.buttonDivide = [[CustomButton alloc] initWithTextAndHSB:@"" target:self selector:@selector(buttonTapped:) hue:0.058f saturation:0.26f brightness:0.42f];
	_buttonDivide.frame = CGRectMake(col3,row0, width, height);
	self.buttonPlusminus = [[CustomButton alloc] initWithTextAndHSB:@"" target:self selector:@selector(buttonTapped:) hue:0.058f saturation:0.26f brightness:0.42f];
	_buttonPlusminus.frame = CGRectMake(col2,row0, width, height);
	self.buttonClear = [[CustomButton alloc] initWithTextAndHSB:@"" target:self selector:@selector(buttonTapped:) hue:0.058f saturation:0.26f brightness:0.42f];
	_buttonClear.frame = CGRectMake(col1,row0, width, height);
    
	[self.buttonClear setLabelWithText:@"AC" andSize:18.0f andVerticalShift:0.0f];
	[self.buttonMinus setLabelWithText:@"−" andSize:24.0f andVerticalShift:-2.0f];
	[self.buttonMultiply setLabelWithText:@"×" andSize:24.0f andVerticalShift:-2.0f];
	[self.buttonPlus setLabelWithText:@"+" andSize:24.0f andVerticalShift:-2.0f];
	[self.buttonDivide setLabelWithText:@"/" andSize:24.0f andVerticalShift:-2.0f];
	[self.buttonPlusminus setLabelWithText:@"±" andSize:24.0f andVerticalShift:-2.0f];
    
	[self.buttonEquals setLabelWithText:@"=" andSize:24.0f andVerticalShift:22.0f];
    
	_buttonPlus.toggled=YES;
	
	self.buttons = [NSMutableArray arrayWithObjects:
                    _button1,
                    _button2,
                    _button3,
					_button4,
					_button5,
					_button6,
					_button7,
					_button8,
					_button9,
					_button0,
					_buttonPoint,
					_buttonPlus,
					_buttonEquals,
					_buttonMinus,
					_buttonMultiply,
					_buttonClear,
					_buttonPlusminus,
					_buttonDivide,
					
                    
                    nil];
	
    for (CustomButton *button in _buttons) {
        [self.view addSubview:button];
    }
    
    number=0;
    isFlage=FALSE;
//    showLabel.text=[NSString stringWithFormat:@"%d",number];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)buttonTapped:(id)sender
{
    if (!isFlage) {
//        num = [sender titleForState:UIControlStateNormal];
        CustomButton *a = sender;
        num = a.label.text;
        nums = [[NSString alloc] initWithFormat:@"%@%@",showLabel.text,num];
        showLabel.text = nums;
    }else {
        if (!isPress) {
            isFlage=FALSE;
//            num = [sender titleForState:UIControlStateNormal];
            CustomButton *a = sender;
            num = a.label.text;
            nums = [[NSString alloc] initWithFormat:@"%@",num];
            showLabel.text = nums;
        }
        
    }
    [self plus:sender Num:nums];
    [self minus:sender Num:nums];
    [self multiple:sender Num:nums];
    [self divide:sender Num:nums];
    [self clearshow:sender Num:number];
    
    if ([num isEqualToString:@"="]) {
        isPress=TRUE;
        isFlage=TRUE;
        switch (TEMP) {
            case 1:
                number=number+[nums doubleValue];
                showLabel.text=[NSString stringWithFormat:@"%d",number];
                isResult=TRUE;
                break;
            case 2:
                number=number-[nums doubleValue];
                showLabel.text=[NSString stringWithFormat:@"%d",number];
                isResult=TRUE;
                break;
            case 3:
                number=number*[nums doubleValue];
                showLabel.text=[NSString stringWithFormat:@"%d",number];
                isResult=TRUE;
                break;
            case 4:
                number=number/[nums doubleValue];
                showLabel.text=[NSString stringWithFormat:@"%d",number];
                isResult=TRUE;
                break;
            default:
                break;
        }
        
    }

}

- (void)plus:(id)sender Num:(NSString *)value{
//	num = [sender titleForState:UIControlStateNormal];
    CustomButton *a = sender;
    num = a.label.text;
	if ([num isEqualToString:@"+"]) {
		TEMP=1;
		isPress=FALSE;
		isFlage=TRUE;
		
		if (isResult) {
			function=FALSE;
		}
		if (!function) {
			number=number+[value doubleValue];
		}else{
			function=TRUE;
			isResult=FALSE;
			number=[value doubleValue];
		}
		showLabel.text=[NSString stringWithFormat:@"%d",number];
	}
}

- (void)minus:(id)sender Num:(NSString *)value
{
//    num = [sender titleForState:UIControlStateNormal];
    CustomButton *a = sender;
    num = a.label.text;
	if ([num isEqualToString:@"-"]) {
		TEMP=1;
		isPress=FALSE;
		isFlage=TRUE;
		
		if (isResult) {
			function=FALSE;
		}
		if (!function) {
			number=number-[value doubleValue];
		}else{
			function=TRUE;
			isResult=FALSE;
			number=[value doubleValue];
		}
		showLabel.text=[NSString stringWithFormat:@"%d",number];
	}

}
- (void)multiple:(id)sender Num:(NSString *)value
{
//    num = [sender titleForState:UIControlStateNormal];
    CustomButton *a = sender;
    num = a.label.text;
	if ([num isEqualToString:@"*"]) {
		TEMP=1;
		isPress=FALSE;
		isFlage=TRUE;
		
		if (isResult) {
			function=FALSE;
		}
		if (!function) {
			number=number*[value doubleValue];
		}else{
			function=TRUE;
			isResult=FALSE;
			number=[value doubleValue];
		}
		showLabel.text=[NSString stringWithFormat:@"%d",number];
	}

}
- (void)divide:(id)sender Num:(NSString *)value
{
//    num = [sender titleForState:UIControlStateNormal];
    CustomButton *a = sender;
    num = a.label.text;
	if ([num isEqualToString:@"/"] && [value intValue] != 0) {
		TEMP=1;
		isPress=FALSE;
		isFlage=TRUE;
		
		if (isResult) {
			function=FALSE;
		}
		if (!function) {
			number=number/[value doubleValue];
		}else{
			function=TRUE;
			isResult=FALSE;
			number=[value doubleValue];
		}
		showLabel.text=[NSString stringWithFormat:@"%d",number];
	}

}

- (void)clearshow:(id)sender Num:(int)value{
    CustomButton *a = sender;
    num = a.label.text;
//	num = [sender titleForState:UIControlStateNormal];
	if ([num isEqualToString:@"AC"]) {
		
		number=0;
		isFlage=FALSE;
		showLabel.text=@"0";
	}
}


@end
