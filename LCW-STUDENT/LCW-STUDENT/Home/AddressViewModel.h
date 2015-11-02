//
//  AddressViewModel.h
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/1.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BaseViewController.h"

@interface AddressViewModel : NSObject

@property(nonatomic, retain)NSMutableDictionary *addressDic;

@property(nonatomic, retain)NSMutableArray *wordSortArray;
@property(nonatomic, retain)NSMutableArray *arrayDataSource;

/**
 *  获取地址列表
 *
 *  @param controller 控制器
 *  @param callBack   回调
 */
- (void)getAddressDicFromServer:(BaseViewController *)controller
                       callBack:(void(^)(BOOL success))callBack;

@end
