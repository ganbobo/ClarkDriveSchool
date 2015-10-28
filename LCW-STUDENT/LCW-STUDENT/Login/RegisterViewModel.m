//
//  RegisterViewModel.m
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/10/26.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import "RegisterViewModel.h"

#import "JsonUtils.h"
#import "AFNManager.h"
#import "NSString+MD5.h"

@interface RegisterViewModel () {
    NSInteger _totalCountTime;
}

@end

@implementation RegisterViewModel


/**
 *  获取注册验证码
 *
 *  @param controller 控制器
 *  @param username   用户名
 *  @param callBack   返回
 */
- (void)getCheckCodeFromSeverController:(BaseViewController *)controller username:(NSString *)username callBack:(void (^)(BOOL hasGet))callBack {
    NSDictionary *dic = @{
                          @"loginName": username
                          };
    [[AFNManager sharedAFNManager] getServer:VERIFY_CODE_SERVER parameters:@{PARS_KEY: [dic JSONNSString]} callBack:^(NSDictionary *response, NSString *netErrorMessage) {
        if (netErrorMessage) {
            [controller showMiddleToastWithContent:netErrorMessage];
            callBack(NO);
        } else {
            NSString* responseCode = getResponseCodeFromDic(response);
            if ([responseCode isEqualToString:ResponseCodeSuccess]) {
                callBack(YES);
            } else {
                NSString *message = response[RESPONSE_MESSAGE];
                [controller showMiddleToastWithContent:message];
                callBack(NO);
            }
        }
    }];
}

/**
 *  倒计时验证码
 *
 *  @param btn  获取验证码按钮
 *  @param time 倒计时总时间
 */
- (void)countTime:(UIButton *)btn totalTime:(NSInteger)time {
    if (_totalCountTime <= 0) {
        _totalCountTime = time;
    }
    
    [self _countTime:btn];
}

- (void)_countTime:(UIButton *)btn {
    if (_totalCountTime > 0) {
        btn.enabled = NO;
        [btn setTitle:[NSString stringWithFormat:@"已发送(%ld)", (long)_totalCountTime] forState:UIControlStateNormal];
        
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(_countTime:) object:btn];
        _totalCountTime --;
        [self performSelector:@selector(_countTime:) withObject:btn afterDelay:1];
    } else {
        btn.enabled = YES;
        [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
}

/**
 *  验证验证码
 *
 *  @param code       验证码
 *  @param controller 控制器
 *
 *  @return 返回是否验证通过
 */
- (BOOL)validateCode:(NSString *)code controller:(BaseViewController *)controller {
    if (code.length <= 0) {
        [controller showMiddleToastWithContent:@"请输入验证码"];
        return NO;
    }
    
    return YES;
}

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
                         callBack:(void (^)(BOOL success))callBack {
    [controller showWaitView:@"注册中"];
    [[AFNManager sharedAFNManager] getServer:REGISTER_SERVER parameters:@{@"username": username, @"password": [pwd md5HexDigest], @"deviceId": getUUIDString()} callBack:^(NSDictionary *response, NSString *netErrorMessage) {
        if (netErrorMessage) {
            [controller hiddenWaitViewWithTip:netErrorMessage type:MessageWarning];
            callBack(NO);
        } else {
            NSString *responseCode = getResponseCodeFromDic(response);
            if ([responseCode isEqualToString:ResponseCodeSuccess]) {
                [controller hiddenWaitViewWithTip:@"注册成功" type:MessageSuccess];
                // 存储用户
                UserInfo *user = [UserInfo objectWithKeyValues:response[@"data"][@"user"]];
                // 存入用户
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
