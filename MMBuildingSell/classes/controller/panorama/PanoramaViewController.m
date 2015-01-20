//
//  PanoramaViewController.m
//  MMBuildingSell
//
//  Created by 3G组 on 13-11-1.
//  Copyright (c) 2013年 Y.X. All rights reserved.
//

#import "PanoramaViewController.h"
#import "SegmentView.h"

#define kIdMin 1
#define kIdMax 1000

@interface PanoramaViewController ()<SegmentViewDelegate>

@end

@implementation PanoramaViewController

- (void)receivedPushContent:(NSNotification*)notification{
    NSString *content = [notification object];
    [XWAlterview showmessage:@"新消息" subtitle:content cancelbutton:@"确定"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedPushContent:) name:@"PUSHCONTENT" object:nil];
    
    SegmentView *segmentView = [[SegmentView alloc] init];
    segmentView.titles = @[@"全景1", @"全景2", @"全景3"];
    segmentView.delegate = self;
    self.navigationItem.titleView = segmentView;

    
    CGFloat width = 814.0;
    CGFloat height = 748.9;
    
//    if ([[UIScreen mainScreen] applicationFrame].size.height==1024) {
//        width = 768 - kDockMenuItemHeight;
//        height = self.view.frame.size.height;
//    }else{
//        width = 1024 - kDockMenuItemHeight;
//        height = self.view.frame.size.height;
//    }
    
    plView = [[PLView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
//    plView = (PLView *)self.view;
    [self.view addSubview:plView];
    plView.delegate = self;
    [self selectPanorama:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)selectPanorama:(NSInteger)index
{
    NSObject<PLIPanorama> *panorama = nil;
    //Spherical2 panorama example (supports up 2048x1024 texture)
    if(index == 0)
    {
        panorama = [PLSpherical2Panorama panorama];
        [(PLSpherical2Panorama *)panorama setImage:[PLImage imageWithPath:[[NSBundle mainBundle] pathForResource:@"pano_sphere2" ofType:@"jpg"]]];
    }
    //Spherical panorama example (supports up 1024x512 texture)
    else if(index == 1)
    {
        panorama = [PLSphericalPanorama panorama];
        [(PLSphericalPanorama *)panorama setTexture:[PLTexture textureWithImage:[PLImage imageWithPath:[[NSBundle mainBundle] pathForResource:@"pano_sphere" ofType:@"jpg"]]]];
    }
    //Cubic panorama example (supports up 1024x1024 texture per face)
    else if(index == 2)
    {
        PLCubicPanorama *cubicPanorama = [PLCubicPanorama panorama];
        [cubicPanorama setTexture:[PLTexture textureWithImage:[PLImage imageWithPath:[[NSBundle mainBundle] pathForResource:@"pano_f" ofType:@"jpg"]]] face:PLCubeFaceOrientationFront];
        [cubicPanorama setTexture:[PLTexture textureWithImage:[PLImage imageWithPath:[[NSBundle mainBundle] pathForResource:@"pano_b" ofType:@"jpg"]]] face:PLCubeFaceOrientationBack];
        [cubicPanorama setTexture:[PLTexture textureWithImage:[PLImage imageWithPath:[[NSBundle mainBundle] pathForResource:@"pano_l" ofType:@"jpg"]]] face:PLCubeFaceOrientationLeft];
        [cubicPanorama setTexture:[PLTexture textureWithImage:[PLImage imageWithPath:[[NSBundle mainBundle] pathForResource:@"pano_r" ofType:@"jpg"]]] face:PLCubeFaceOrientationRight];
        [cubicPanorama setTexture:[PLTexture textureWithImage:[PLImage imageWithPath:[[NSBundle mainBundle] pathForResource:@"pano_u" ofType:@"jpg"]]] face:PLCubeFaceOrientationUp];
        [cubicPanorama setTexture:[PLTexture textureWithImage:[PLImage imageWithPath:[[NSBundle mainBundle] pathForResource:@"pano_d" ofType:@"jpg"]]] face:PLCubeFaceOrientationDown];
        panorama = cubicPanorama;
    }
    //Cylindrical panorama example (supports up 1024x1024 texture)
    else if(index == 3)
    {
        panorama = [PLCylindricalPanorama panorama];
        ((PLCylindricalPanorama *)panorama).isHeightCalculated = NO;
        [(PLCylindricalPanorama *)panorama setTexture:[PLTexture textureWithImage:[PLImage imageWithPath:[[NSBundle mainBundle] pathForResource:@"pano_sphere" ofType:@"jpg"]]]];
    }
    //Add a hotspot
    PLTexture *hotspotTexture = [PLTexture textureWithImage:[PLImage imageWithPath:[[NSBundle mainBundle] pathForResource:@"hotspot" ofType:@"png"]]];
    PLHotspot *hotspot = [PLHotspot hotspotWithId:(kIdMin + random() % ((kIdMax + 1) - kIdMin)) texture:hotspotTexture atv:0.0f ath:0.0f width:0.08f height:0.08f];
    [panorama addHotspot:hotspot];
    [plView setPanorama:panorama];
}

//Hotspot event
-(void)view:(UIView<PLIView> *)pView didClickHotspot:(PLHotspot *)hotspot screenPoint:(CGPoint)point scene3DPoint:(PLPosition)position
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Hotspot" message:[NSString stringWithFormat:@"You select the hotspot with ID %lld", hotspot.identifier] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
//    [alertView release];
    //You can load a panorama view
    /*
     PLSpherical2Panorama *panorama = [PLSpherical2Panorama panorama];
     [panorama setImage:[PLImage imageWithPath:[[NSBundle mainBundle] pathForResource:@"pano_sphere2" ofType:@"jpg"]]];
     [pView setPanorama:panorama];
     */
}

- (void)segmentView:(SegmentView *)segmentView didSelectedSegmentAtIndex:(int)index
{
    [self selectPanorama:index];
    switch (index) {
        case 0:
            break;
        case 1:
            break;
    }
}


@end
