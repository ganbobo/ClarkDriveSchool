//
//  ShopAnnotation.m
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/9.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import "ShopAnnotation.h"

@implementation ShopAnnotation

- (void)setShopInfo:(ShopInfo *)shopInfo {
    _shopInfo = shopInfo;
    CLLocationCoordinate2D coor;
    coor.latitude = shopInfo.latitude.doubleValue;
    coor.longitude = shopInfo.longitude.doubleValue;
    self.coordinate = coor;
    self.title = shopInfo.driving_name;
}

@end
