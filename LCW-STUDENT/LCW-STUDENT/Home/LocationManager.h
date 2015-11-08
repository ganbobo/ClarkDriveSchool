//
//  LocationManager.h
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/2.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AddressModel.h"
#import "AddressViewModel.h"
#import <BaiduMapAPI_Location/BMKLocationService.h>

@interface LocationManager : NSObject

DECLARE_SINGLETON_FOR_CLASS(LocationManager);

@property(nonatomic, retain)AddressModel *addressInfo;
@property(readonly, nonatomic) BMKUserLocation *location;

- (void)startLocation:(void(^)(NSString *city))city;

@end
