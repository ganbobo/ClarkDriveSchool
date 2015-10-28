//
//  RegisterViewModel.h
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/10/26.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BaseViewController.h"

@interface RegisterViewModel : NSObject

/**
 *  获取注册验证码
 *
 *  @param controller 控制器
 *  @param username   用户名
 *  @param callBack   返回
 */
- (void)getCheckCodeFromSeverController:(BaseViewController *)controller username:(NSString *)username callBack:(void (^)(BOOL success))callBack;

/**
 *  倒计时验证码
 *
 *  @param btn  获取验证码按钮
 *  @param time 倒计时总时间
 */
- (void)countTime:(UIButton *)btn totalTime:(NSInteger)time;

/**
 *  验证验证码
 *
 *  @param code       验证码
 *  @param controller 控制器
 *
 *  @return 返回是否验证通过
 */
- (BOOL)validateCode:(NSString *)code controller:(BaseViewController *)controller;

/**
 *  注册账户
 *
 *  @param controller 控制器
 *  @param username   用户名
 *  @param pwd        密码
 *  @param callBack   回调
 */
- (void)registerAccountController:(BaseViewController *)controller
                         username:(NSString *)username
                              pwd:(NSString *)pwd
                         callBack:(void (^)(BOOL success))callBack;


@end
