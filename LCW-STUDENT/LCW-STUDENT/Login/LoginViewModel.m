//
//  LoginViewModel.m
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/10/26.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import "LoginViewModel.h"

#import "AFNManager.h"
#import "NSString+MD5.h"
#import "JsonUtils.h"

@implementation LoginViewModel

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
        controller:(BaseViewController *)controller {
    if (username.length <= 0) {
        [controller showMiddleToastWithContent:@"请输入用户名"];
        return NO;
    }
    
    if (password.length <= 0) {
        [controller showMiddleToastWithContent:@"请输入密码"];
        return NO;
    }
    
    return YES;
}

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
                       callBack:(void (^)(BOOL success))callBack {
    NSDictionary *dic = @{
                          @"loginName": username,
                          @"passWord": pwd//[pwd md5HexDigest]
                          };
    [controller showWaitView:@"正在登录"];
    [[AFNManager sharedAFNManager] getServer:LOGIN_SERVER parameters:@{PARS_KEY: [dic JSONNSString]} callBack:^(NSDictionary *response, NSString *netErrorMessage) {
        if (netErrorMessage) {
            [controller hiddenWaitViewWithTip:netErrorMessage type:MessageWarning];
            callBack(NO);
        } else {
            NSString *responseCode = getResponseCodeFromDic(response);
            if ([responseCode isEqualToString:ResponseCodeSuccess]) {
                [controller hiddenWaitViewWithTip:@"登录成功" type:MessageSuccess];
                // 存储用户
                UserInfo *user = [UserInfo objectWithKeyValues:response[@"data"]];
                // 存入用户
                user.pass_word = pwd;
                setUser(user);
                callBack(YES);
            } else {
                NSString *message = response[RESPONSE_MESSAGE];
                [controller hiddenWaitViewWithTip:message type:MessageFailed];
                callBack(NO);
            }
        }
    }];
}

@end
