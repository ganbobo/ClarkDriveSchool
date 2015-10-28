//
//  LoginViewModel.h
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/10/26.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BaseViewController.h"

@interface LoginViewModel : NSObject

/**
 *  验证输入
 *
 *  @param username   用户名
 *  @param password   密码
 *  @param controller 控制器
 *
 *  @return 是否通过验证
 */
- (BOOL)checkInput:(NSString *)username
          password:(NSString *)password
        controller:(BaseViewController *)controller;

/**
 *  登录
 *
 *  @param controller 控制器
 *  @param username   用户名
 *  @param pwd        密码
 *  @param callBack   请求返回
 */
- (void)loginToServerController:(BaseViewController *)controller
                       username:(NSString *)username
                            pwd:(NSString *)pwd
                       callBack:(void (^)(BOOL success))callBack;

@end
