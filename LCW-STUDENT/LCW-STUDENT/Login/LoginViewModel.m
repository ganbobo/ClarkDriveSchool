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
#import "JSONKit.h"

@interface LoginViewModel() {
    NSInteger _totalCountTime;
    NSMutableDictionary *_dic;
}
@end

@implementation LoginViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dic = [[NSMutableDictionary alloc] init];
    }
    return self;
}

/**
*  获取注册验证码
*
*  @param controller 控制器
*  @param username   用户名
*  @param callBack   返回
*/
- (void)getCheckCodeFromSeverController:(BaseViewController *)controller username:(NSString *)username callBack:(void (^)(BOOL hasGet))callBack {
    NSDictionary *dic = @{
                          @"mobile": username
                          };
    [[AFNManager sharedAFNManager] getServer:VERIFY_CODE_SERVER parameters:@{PARS_KEY: [dic JSONString]} callBack:^(NSDictionary *response, NSString *netErrorMessage) {
        if (netErrorMessage) {
            [controller showMiddleToastWithContent:netErrorMessage];
            callBack(NO);
        } else {
            NSString* responseCode = getResponseCodeFromDic(response);
            if ([responseCode isEqualToString:ResponseCodeSuccess]) {
                NSString *code = [NSString stringWithFormat:@"%ld", [response[@"data"][@"identifyingCode"] longValue]];
                [_dic removeAllObjects];
                [_dic setValue:code forKey:username];
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
- (BOOL)validateCode:(NSString *)code username:(NSString *)username controller:(BaseViewController *)controller {
    if (code.length <= 0) {
        [controller showMiddleToastWithContent:@"请输入验证码"];
        return NO;
    }
    
    NSString *checkCode = _dic[username];
    if (![code isEqualToString:checkCode]) {
        [controller showMiddleToastWithContent:@"验证码不正确或者已失效"];
        return NO;
    }
    
    return YES;
}



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
                          @"loginName": username
                          };
    [controller showWaitView:@"正在登录"];
    [[AFNManager sharedAFNManager] getServer:LOGIN_SERVER parameters:@{PARS_KEY: [dic JSONString]} callBack:^(NSDictionary *response, NSString *netErrorMessage) {
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
