//
//  ShopAnnotation.h
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/9.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKPointAnnotation.h>
#import "ShopInfo.h"

@interface ShopAnnotation : BMKPointAnnotation

@property(nonatomic, retain)ShopInfo *shopInfo;

@end
