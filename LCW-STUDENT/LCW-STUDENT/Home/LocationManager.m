//
//  LocationManager.m
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/2.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import "LocationManager.h"

#import <BaiduMapAPI_Location/BMKLocationService.h>
#import <BaiduMapAPI_Search/BMKGeocodeSearchOption.h>
#import <BaiduMapAPI_Search/BMKGeocodeSearch.h>

@interface LocationManager ()<BMKLocationServiceDelegate, BMKGeoCodeSearchDelegate> {
    BMKLocationService *_locationService;
    BMKGeoCodeSearch *_searcher;
}

@end

@implementation LocationManager

SYNTHESIZE_SINGLETON_FOR_CLASS(LocationManager);

- (instancetype)init
{
    self = [super init];
    if (self) {
        _locationService = [[BMKLocationService alloc] init];
        _locationService.delegate = self;
        
//        _searcher =[[BMKGeoCodeSearch alloc]init];
//        _searcher.delegate = self;
    }
    return self;
}

- (void)startLocation {
    [_locationService startUserLocationService];
}

- (void)stopLocation {
    [_locationService stopUserLocationService];
}

//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [self stopLocation];
    
    //发起反向地理编码检索
    CLLocationCoordinate2D pt = userLocation.location.coordinate;
    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[
    BMKReverseGeoCodeOption alloc]init];
    reverseGeoCodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [_searcher reverseGeoCode:reverseGeoCodeSearchOption];
    
    if(flag)
    {
      NSLog(@"反geo检索发送成功");
    }
    else
    {
      NSLog(@"反geo检索发送失败");
    }
}

//接收反向地理编码结果
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher
                           result:(BMKReverseGeoCodeResult *)result
                        errorCode:(BMKSearchErrorCode)error{
    _searcher.delegate = nil;
    _searcher = nil;
  if (error == BMK_SEARCH_NO_ERROR) {
      
  }
  else {
      NSLog(@"抱歉，未找到结果");
  }
}

@end
