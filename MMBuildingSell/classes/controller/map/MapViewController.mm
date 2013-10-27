//
//  MapViewController.m
//  MMBuildingSell
//
//  Created by 3G组 on 13-10-18.
//  Copyright (c) 2013年 Y.X. All rights reserved.
//

#import "MapViewController.h"
#import "SegmentView.h"


@interface MapViewController ()<SegmentViewDelegate,BMKMapViewDelegate,BMKSearchDelegate>

@end

@implementation MapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    SegmentView *segmentView = [[SegmentView alloc] init];
    _arrType = [[NSArray alloc]initWithObjects:@"超市", @"银行", @"公交站", nil];
    segmentView.titles = _arrType;
    segmentView.delegate = self;
    self.navigationItem.titleView = segmentView;
    
    _curCoord = CLLocationCoordinate2DMake(41.81414,123.44071);
    
    CGFloat width;
    CGFloat height;
    
    if ([[UIScreen mainScreen] applicationFrame].size.height==1024) {
        width = 768 - kDockMenuItemHeight;
        height = self.view.frame.size.height;
    }else{
        width = 1024 - kDockMenuItemHeight;
        height = self.view.frame.size.height;
    }
    
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    self.view = _mapView;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)segmentView:(SegmentView *)segmentView didSelectedSegmentAtIndex:(int)index
{
    NSString *strKey = [[NSString alloc]init];
    strKey = [_arrType objectAtIndex:index];
    //搜索附近
    BOOL flag = [_search poiSearchNearBy:strKey center:_curCoord radius:2000 pageIndex:0];
//    BOOL flag = [_search poiSearchInCity:@"北京" withKey:@"西单" pageIndex:0];
    if (flag) {
		NSLog(@"search %@ success.",strKey);
	}
    else{
        NSLog(@"search  %@  failed!",strKey);
    }

}

-(void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _search.delegate = self;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _search.delegate = nil;
}

#pragma mark -
#pragma mark implement BMKMapViewDelegate

/**
 *根据anntation生成对应的View
 *@param mapView 地图View
 *@param annotation 指定的标注
 *@return 生成的标注View
 */
- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
    // 生成重用标示identifier
    NSString *AnnotationViewID = @"xidanMark";
	
    // 检查是否有重用的缓存
    BMKAnnotationView* annotationView = [view dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    
    // 缓存没有命中，自己构造一个，一般首次添加annotation代码会运行到此处
    if (annotationView == nil) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
		((BMKPinAnnotationView*)annotationView).pinColor = BMKPinAnnotationColorRed;
		// 设置重天上掉下的效果(annotation)
        ((BMKPinAnnotationView*)annotationView).animatesDrop = YES;
    }
	
    // 设置位置
	annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5));
    annotationView.annotation = annotation;
    // 单击弹出泡泡，弹出泡泡前提annotation必须实现title属性
	annotationView.canShowCallout = YES;
    // 设置是否可以拖拽
    annotationView.draggable = NO;
    
    return annotationView;
}
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    [mapView bringSubviewToFront:view];
    [mapView setNeedsDisplay];
}
- (void)mapView:(BMKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    NSLog(@"didAddAnnotationViews");
}

#pragma mark -
#pragma mark implement BMKSearchDelegate

- (void)onGetPoiResult:(NSArray*)poiResultList searchType:(int)type errorCode:(int)error
{
    // 清楚屏幕中所有的annotation
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
	[_mapView removeAnnotations:array];
    
    if (error == BMKErrorOk) {
		BMKPoiResult* result = [poiResultList objectAtIndex:0];
		for (int i = 0; i < result.poiInfoList.count; i++) {
            BMKPoiInfo* poi = [result.poiInfoList objectAtIndex:i];
            BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
            item.coordinate = poi.pt;
            item.title = poi.name;
            [_mapView addAnnotation:item];
            if(i == 0)
            {
                //将第一个点的坐标移到屏幕中央
                _mapView.centerCoordinate = poi.pt;
            }
		}
	} else if (error == BMKErrorRouteAddr){
        NSLog(@"起始点有歧义");
    } else {
        // 各种情况的判断。。。
    }
}



@end
