//
//  MapViewController.m
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/24.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import "MapViewController.h"

#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI_Map/BMKPinAnnotationView.h>
#import "ShopAnnotation.h"
#import "LocationManager.h"
@interface MapViewController ()<BMKMapViewDelegate> {
    BMKMapView *_mapView;
}

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [PMCommon setNavigationTitle:self withTitle:@"地图"];
    [self loadMapView];
    [self addAnnotaion];
    // Do any additional setup after loading the view.
    [self getLocation];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _mapView.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    _mapView.delegate = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadMapView {
    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - NavBarHeight - StatusBarHeight)];
    [_mapView setMapType:BMKMapTypeStandard];
    _mapView.showsUserLocation = YES;
    _mapView.zoomEnabled= YES;
    _mapView.scrollEnabled = YES;
    _mapView.zoomLevel = 12;
    [self.view addSubview:_mapView];
}

- (void)addAnnotaion {
    ShopAnnotation *annotation = [[ShopAnnotation alloc]init];
    annotation.shopInfo = _shopInfo;
    [_mapView addAnnotation:annotation];
    [_mapView selectAnnotation:annotation animated:YES];
    
//    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(_shopInfo.latitude.doubleValue, _shopInfo.longitude.doubleValue) animated:YES];
}
// 根据anntation生成对应的View
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    //普通annotation
    if ([annotation isKindOfClass:[ShopAnnotation class]]) {
        NSString *AnnotationViewID = @"renameMark";
        BMKPinAnnotationView *annotationView = (BMKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
        if (annotationView == nil) {
            annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
            // 设置颜色
            annotationView.pinColor = BMKPinAnnotationColorPurple;
            // 从天上掉下效果
            annotationView.animatesDrop = YES;
            // 设置可拖拽
            annotationView.draggable = YES;
        }
        return annotationView;
    }
    
    return nil;
}

- (void)getLocation {
    if ([LocationManager sharedLocationManager].location) {
        [_mapView updateLocationData:[LocationManager sharedLocationManager].location];
        if (_mapView) {
            [_mapView setCenterCoordinate:[LocationManager sharedLocationManager].location.location.coordinate animated:YES];
        }
    } else {
        [[LocationManager sharedLocationManager] startLocation:^(NSString *city) {
            if (city == nil) {
                [self showMiddleToastWithContent:@"定位失败"];
            } else {
                [_mapView updateLocationData:[LocationManager sharedLocationManager].location];
                if (_mapView) {
                    [_mapView setCenterCoordinate:[LocationManager sharedLocationManager].location.location.coordinate animated:YES];
                }            }
        }];
    }
}


@end
