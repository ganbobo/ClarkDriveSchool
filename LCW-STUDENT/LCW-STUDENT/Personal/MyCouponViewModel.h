//
//  MyCouponViewModel.h
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/3.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BaseViewController.h"

@interface MyCouponViewModel : NSObject

@property(nonatomic, retain)NSMutableArray *dataSource;

/**
 *  获取我的优惠券
 *
 *  @param controller 控制器
 *  @param callback   回调
 */
- (void)getMyCouponListFromServer:(BaseViewController *)controller callback:(void(^)(BOOL success))callback;

@end
