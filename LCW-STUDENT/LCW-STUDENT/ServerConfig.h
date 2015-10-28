//
//  ServerConfig.h
//  Gtwy
//
//  Created by lion on 15/8/13.
//  Copyright (c) 2015年 lion. All rights reserved.
//

/**
 *  针对服务服接口的配置文件
 */

#ifndef Gtwy_ServerConfig_h
#define Gtwy_ServerConfig_h

// 服务器超时时间设置
#define kRequestOverTime    30

// 配置服务器地址
#define SERVER_ADDRESS    @"http://121.199.70.25:8090"
#define IMAGE_SERVER      @"http://121.199.70.25:8090"

// 登录注册
#define NEW_VERSION_SERVER          @"/version/checkVersion" // 版本检测
#define LOGIN_SERVER                @"/driving/login/userLoginByPassWord" // 登录
#define LOGOUT_SERVER               @"/memberinfo/loginOut" // 退出登录
#define VERIFY_CODE_SERVER          @"/driving/login/userLoginByMobile" // 获取验证码
#define VERIFY_VERIFY_CODE_SERVER   @"/memberinfo/validateCode" // 验证验证码
#define REGISTER_SERVER             @"/memberinfo/saveMemberInfo" // 注册
#define FORGET_PWD_SERVER           @"/memberinfo/updateMemberPwd" // 忘记密码修改密码
#define MODIFY_PWD_SERVER           @"/memberinfo/updateMemberInfo" // 修改密码


// 首页
#define ADS_LIST_SERVER             @"/advertimage/getAdvertImagelist" // 广告接口地址

#define GET_SCHOOL_LIST_SERVER      @"/driving/driving/getDrivings"

// JSON公用字段

#define PARS_KEY              @"pars"
#define RESPONSE_MESSAGE      @"msg"

#endif
