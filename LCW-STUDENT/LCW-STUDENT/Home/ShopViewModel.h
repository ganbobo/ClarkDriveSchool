//
//  ShopViewModel.h
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/10/26.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BaseViewController.h"

@interface ShopViewModel : NSObject

@property(nonatomic, retain)NSMutableArray *dataSource;

/**
 *  获取驾校列表
 *
 *  @param userId     用户ID
 *  @param controller 控制器
 *  @param callBack   回调
 */

- (void)getShopListFromServer:(NSString *)userId controller:(BaseViewController *)controller callBack:(void (^)(BOOL success))callBack;

@end
