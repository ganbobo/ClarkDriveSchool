//
//  SchoolViewModel.h
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/2.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BaseViewController.h"
#import "SchoolDetailInfo.h"

@interface SchoolViewModel : NSObject


@property(nonatomic, retain)SchoolDetailInfo *schoolDetailInfo;

/**
 *  驾校详情
 *
 *  @param controller 控制器
 *  @param driveId    驾校ID
 *  @param callBack   回调
 */
- (void)getSchoolDetailFromSever:(BaseViewController *)controller
                         driveId:(NSString *)driveId
                        callBack:(void(^)(BOOL success))callBack;

/**
 *  生成优惠券
 *
 *  @param controller 控制器
 *  @param driveId    驾校ID
 *  @param name       姓名
 *  @param identifier 身份证号
 *  @param callBack   回调
 */
- (void)getCouponFromSever:(BaseViewController *)controller
                   driveId:(NSString *)driveId
                      name:(NSString *)name
                identifier:(NSString *)identifier
                  callBack:(void(^)(BOOL success))callBack;

/**
 *  验证输入姓名和身份证号
 *
 *  @param name       姓名
 *  @param identifier 身份证
 *  @param controller 控制器
 *
 *  @return 是否通过验证
 */
- (BOOL)checkUserInput:(NSString *)name
            identifier:(NSString *)identifier
            controller:(BaseViewController *)controller;

@end
