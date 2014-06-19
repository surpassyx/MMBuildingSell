//
//  CustomerDetailView.m
//  MMBuildingSell
//
//  Created by 3G组 on 13-11-11.
//  Copyright (c) 2013年 Y.X. All rights reserved.
//

#import "CustomerDetailView.h"


@implementation CustomerDetailView

@synthesize tel,wantType,getWay,mudi,workSpace,age,tableJIlu,yixiangdengji,gongzuodanwei,fname;
@synthesize juzhuquyu,car,nianshouru,jiatingjiegou,xianyoufangchan,remarkTextField;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化tableView的数据
        NSMutableArray *list = [NSMutableArray arrayWithObjects:@"活动记录1",@"活动记录2",@"活动记录3", nil];
        self.dataDetailList = list;
        self.tableJIlu.delegate = self;
        self.tableJIlu.dataSource = self;

        // 设置tableView的背景图
        self.tableJIlu.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"detail_down_bk"]];
        
        // Initialization code
        
//        [[NSBundle mainBundle] loadNibNamed:@"CustomerDetailView" owner:self options:nil];
//        [self addSubview:self.view];
        
        
//        simpleRatingControl = [[AMRatingControl alloc] initWithLocation:CGPointMake(90, 50)
//                                                                            andMaxRating:5];
//        
//        // Customize the current rating if needed
//        [simpleRatingControl setRating:3];
//        [simpleRatingControl setStarSpacing:10];
        
        // Define block to handle events
//        simpleRatingControl.editingChangedBlock = ^(NSUInteger rating)
//        {
//            [label setText:[NSString stringWithFormat:@"%d", rating]];
//        };
//        
//        simpleRatingControl.editingDidEndBlock = ^(NSUInteger rating)
//        {
//            [endLabel setText:[NSString stringWithFormat:@"%d", rating]];
//        };

    }
    return self;
}

//- (void) awakeFromNib
//{
//    [super awakeFromNib];
//    
//    [[NSBundle mainBundle] loadNibNamed:@"CustomerDetailView" owner:self options:nil];
//    [self addSubview:self.view];
//}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
//滑动选择的行后删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dataDetailList removeObjectAtIndex:indexPath.row];
        // Delete the row from the data source.
        [tableJIlu deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellWithIdentifier];
    }
    NSUInteger row = [indexPath row];
    cell.textLabel.text = [self.dataDetailList objectAtIndex:row];
    //    cell.imageView.image = [UIImage imageNamed:@"green.png"];
    cell.detailTextLabel.text = @"详细信息";
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
    return [self.dataDetailList count];
}
//设置缩进
//- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return [indexPath row];
//}
//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
//设置cell的隔行换色
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([indexPath row] % 2 == 0) {
//        cell.backgroundColor = [UIColor blueColor];
//    } else {
//        cell.backgroundColor = [UIColor greenColor];
//    }
//}
//点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *msg = [[NSString alloc] initWithFormat:@"你选择的是:%@",[self.dataDetailList objectAtIndex:[indexPath row]]];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}


- (IBAction)addRemark:(id)sender {
    if (remarkTextField.text.length > 0) {
        [self.dataDetailList addObject:remarkTextField.text];
        [tableJIlu reloadData];
    }
}
@end
