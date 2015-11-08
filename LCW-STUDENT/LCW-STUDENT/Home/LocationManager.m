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
    
    void(^_callBack)(NSString *city);
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
        
        _searcher =[[BMKGeoCodeSearch alloc]init];
        _searcher.delegate = self;
    }
    return self;
}

- (void)startLocation:(void(^)(NSString *city))city {
    _callBack = city;
    [_locationService startUserLocationService];
}

- (void)stopLocation {
    [_locationService stopUserLocationService];
}

- (void)didFailToLocateUserWithError:(NSError *)error {
    if (_callBack) {
        _callBack(nil);
        _callBack = nil;
    }
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
        if (_callBack) {
            _callBack(nil);
            _callBack = nil;
        }
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
      if (_callBack) {
          NSString *city = result.addressDetail.city;
          _callBack(city);
          [self getCityInfoFromServer:city];
          _callBack = nil;
      }
  }
  else {
      if (_callBack) {
          _callBack(nil);
          _callBack = nil;
      }
  }
}

- (void)getCityInfoFromServer:(NSString *)city {
    AddressViewModel *viewModel = [[AddressViewModel alloc] init];
    [viewModel getAddressDicFromServer:nil callBack:^(BOOL success) {
        if (success) {
            for (AddressModel *model in viewModel.arrayDataSource) {
                if ([model.c_name rangeOfString:city].location != NSNotFound || [city rangeOfString:model.c_name].location != NSNotFound) {
                    _addressInfo = model;
                    break;
                }
            }
        }
    }];
}

@end
