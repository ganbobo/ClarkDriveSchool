//
//  ShopViewModel.m
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/10/26.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import "ShopViewModel.h"

#import "JSONKit.h"
#import "AFNManager.h"
#import "ShopInfo.h"
#import "LocationManager.h"
#import <CoreLocation/CoreLocation.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>

#import <BaiduMapAPI_Map/BMKMapView.h>

@interface ShopViewModel () {
    NSMutableArray *_dataSource;
}

@end

@implementation ShopViewModel

- (instancetype)init {
    if (self = [super init]) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    
    return self;
}

/**
 *  获取驾校列表
 *
 *  @param cityId     城市ID
 *  @param toDate     升序 asc 降序desc
 *  @param startPrice 其实金额
 *  @param endPrice   结束金额
 *  @param controller 控制器
 *  @param callBack   回调
 */

- (void)getShopListFromServer:(NSString *)cityId
                         date:(NSString *)toDate
                   startPrice:(CGFloat)startPrice
                     endPrice:(CGFloat)endPrice
                   controller:(BaseViewController *)controller
                     callBack:(void (^)(BOOL success))callBack {
    NSDictionary *dic = @{
                          @"userId": (hasUser() ? getUser().id : @"123"),
                          @"toDate": toDate,
                          @"startPrice": @(startPrice),
                          @"endPrice": @(endPrice),
                          @"c_id": cityId
                          };
    if (cityId.length <= 0) {
        dic = @{
              @"userId": (hasUser() ? getUser().id : @"123"),
              @"toDate": toDate,
              @"startPrice": @(startPrice),
              @"endPrice": @(endPrice)
              };
    }

    
    [[AFNManager sharedAFNManager] getServer:GET_SCHOOL_LIST_SERVER parameters:@{PARS_KEY: [dic JSONString]} callBack:^(NSDictionary *response, NSString *netErrorMessage) {
        if (netErrorMessage) {
            if (_dataSource.count <= 0) {
                [controller finishedLodingWithTip:netErrorMessage subTip:@"点击重新加载"];
            } else {
                [controller finishedLoding];
                [controller showMiddleToastWithContent:netErrorMessage];
            }
            callBack(NO);
        } else {
            NSString *responseCode = getResponseCodeFromDic(response);
            if ([responseCode isEqualToString:ResponseCodeSuccess]) {
                [controller finishedLoding];
                NSArray *array = [ShopInfo objectArrayWithKeyValuesArray:response[@"data"][@"listDriving"]];
                [_dataSource removeAllObjects];
                for (ShopInfo *info in array) {
                    if ([LocationManager sharedLocationManager].location.location.coordinate.latitude == 0 && [LocationManager sharedLocationManager].location.location.coordinate.longitude == 0) {
                        info.distance = 0;
                    } else {
                        CLLocationCoordinate2D coor1 = [LocationManager sharedLocationManager].location.location.coordinate;
                        CLLocationCoordinate2D coor = CLLocationCoordinate2DMake(info.latitude.doubleValue, info.longitude.doubleValue);
                        BMKMapPoint pHome = BMKMapPointForCoordinate(coor1);
                        BMKMapPoint pDes = BMKMapPointForCoordinate(coor);
                        info.distance = BMKMetersBetweenMapPoints(pHome,pDes);
                    }
                    [_dataSource addObject:info];
                }
                callBack(YES);
            } else {
                NSString *message = response[RESPONSE_MESSAGE];
                if (_dataSource.count <= 0) {
                    [controller finishedLodingWithTip:message subTip:@"点击重新加载"];
                } else {
                    [controller finishedLoding];
                    [controller showMiddleToastWithContent:message];
                }
                callBack(NO);
            }
        }
    }];

}

- (void)rankByString:(NSString *)key {
//    [_dataSource sortedArrayUsingComparator:^NSComparisonResult(ShopInfo *s1, ShopInfo *s2) {
//        if ([key isEqualToString:@"distance"]) {
//            return [@(s1.distance) compare:@(s2.distance)];
//        }
//    }];
}

/**
 *  搜索数据
 *
 *  @param keyword  关键字
 *  @param callBack 回调
 */
- (void)getSearchList:(NSString *)keyword callBack:(void (^)(NSArray *dataList))callBack {
    NSMutableArray *list = [NSMutableArray array];
    for (ShopInfo *info in _dataSource) {
        if ([info.driving_name rangeOfString:keyword].location != NSNotFound) {
            [list addObject:info];
        }
    }
    
    callBack(list);
}

@end
