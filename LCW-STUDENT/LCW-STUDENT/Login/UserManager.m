//
//  UserManager.m
//  LCW-STUDENT
//
//  Created by St.Pons.Mr.G on 15/9/14.
//  Copyright (c) 2015年 Clark. All rights reserved.
//

#import "UserManager.h"

#import "AFNManager.h"
#import "UserInfo.h"

@implementation UserManager

SYNTHESIZE_SINGLETON_FOR_CLASS(UserManager);

/**
 *  登录
 *
 *  @param username    用户名
 *  @param password    密码
 *  @param innerToken  Username+password经过一次MD5后的值
 *  @param picCaptcha  图片验证码
 *  @param callBack    请求回调
 */
- (void)loginToServer:(NSString *)username
             password:(NSString *)password
           innerToken:(NSString *)innerToken
           picCaptcha:(NSString *)picCaptcha
             callBack:(void (^)(NSInteger responseCode, NSString *message, NSString *netErrorMessage))callBack {
    NSDictionary *param = @{
                            @"username": username,
                            @"password": password,
                            @"innerToken": innerToken,
                            @"picCaptcha": picCaptcha
                            };
    [[AFNManager manager] postServer:LOGIN_SERVER parameters:param callBack:^(NSDictionary *response, NSString *netErrorMessage) {
        if (netErrorMessage) {
            callBack(-1, nil, netErrorMessage);
        } else {
            NSInteger responseCode = getResponseCodeFromDic(response);
            if (responseCode == ResponseCodeSuccess) {
//                UserInfo *user = [UserInfo objectWithKeyValues:response[@"data"][@"user"]];
//                user.token = response[@"data"][@"token"];
                // 存入用户
//                setUser(user);
                
                callBack(responseCode, @"登录成功", nil);
            } else {
                NSString *message = response[RESPONSE_MESSAGE];
                callBack(responseCode, message, nil);
            }
        }
    }];
}

/**
 *  账号密码登录
 *
 *  @param username      手机号
 *  @param phoneCaptcha  验证码
 *  @param innerToken    Username+password经过一次MD5后的值
 *  @param picCaptcha    图片验证码
 *  @param callBack      请求回调
 */
- (void)phoneLoginToServer:(NSString *)phoneNum
              phoneCaptcha:(NSString *)phoneCaptcha
                innerToken:(NSString *)innerToken
                picCaptcha:(NSString *)picCaptcha
                  callBack:(void (^)(NSInteger responseCode, NSString *message, NSString *netErrorMessage))callBack {
    
}

@end
