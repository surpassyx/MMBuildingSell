//
//  PanoramaViewController.h
//  MMBuildingSell
//
//  Created by 3G组 on 13-11-1.
//  Copyright (c) 2013年 Y.X. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PLView.h"
#import "PLJSONLoader.h"

@interface PanoramaViewController : UIViewController <PLViewDelegate>
{
    NSMutableArray * dataList;
@private
    PLView *plView;
}


@end
