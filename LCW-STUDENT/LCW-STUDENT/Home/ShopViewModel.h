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
                     callBack:(void (^)(BOOL success))callBack;

/**
 *  搜索数据
 *
 *  @param keyword  关键字
 *  @param callBack 回调
 */
- (void)getSearchList:(NSString *)keyword callBack:(void (^)(NSArray *dataList))callBack;

@end
