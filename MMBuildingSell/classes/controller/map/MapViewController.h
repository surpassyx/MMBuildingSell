//
//  MapViewController.h
//  MMBuildingSell
//
//  Created by 3G组 on 13-10-18.
//  Copyright (c) 2013年 Y.X. All rights reserved.
//http://api.map.baidu.com/place/search?&query=%E8%B6%85%E5%B8%82&location=39.915,116.404&radius=2000&output=json&key=2ec2d37497e11bca1573c82d7650fb48

#import <UIKit/UIKit.h>
#import "BMapKit.h"

@interface MapViewController : UIViewController{
    BMKMapView* _mapView;
    BMKSearch* _search;
    CLLocationCoordinate2D _curCoord;
    NSArray * _arrType;
}

@end
