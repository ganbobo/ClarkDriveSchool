//
//  UserManager.h
//  LCW-STUDENT
//
//  Created by St.Pons.Mr.G on 15/9/14.
//  Copyright (c) 2015年 Clark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserManager : NSObject

DECLARE_SINGLETON_FOR_CLASS(UserManager);

/**
 *  账号密码登录
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
             callBack:(void (^)(NSInteger responseCode, NSString *message, NSString *netErrorMessage))callBack;

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
                  callBack:(void (^)(NSInteger responseCode, NSString *message, NSString *netErrorMessage))callBack;

@end
