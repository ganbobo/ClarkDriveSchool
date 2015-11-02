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
#define VERIFY_CODE_SERVER          @"/driving/register/identifyingCode" // 获取验证码
#define VERIFY_VERIFY_CODE_SERVER   @"/driving/register/identifyingCode" // 验证验证码
#define REGISTER_SERVER             @"/driving/register/register" // 注册
#define FORGET_PWD_SERVER           @"/memberinfo/updateMemberPwd" // 忘记密码修改密码
#define MODIFY_PWD_SERVER           @"/memberinfo/updateMemberInfo" // 修改密码

// 约车
#define GET_SUBJECT_SERVER          @"/driving/training/getSubject" // 获取所有科目
#define GET_SUBJECT_COACH_SERVER    @"/driving/training/getTrainerBySubject" // 获取科目教练
#define GET_TIME_SERVER             @"/driving/training/getNextWeekTime"

// 首页
#define ADS_LIST_SERVER             @"/advertimage/getAdvertImagelist" // 广告接口地址
#define ADDRESS_LIST_SERVER         @"/driving/area/getAreas" // 城市列表
#define GET_SCHOOL_LIST_SERVER      @"/driving/driving/getDrivings" // 驾校列表
#define FEED_BACK_SERVER            @"/driving/area/toMessage" // 意见反馈

// JSON公用字段

#define PARS_KEY              @"pars"
#define RESPONSE_MESSAGE      @"msg"

#endif
