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
#define LOGIN_SERVER                @"/driving/login/userLoginByMobile" // 登录
#define LOGOUT_SERVER               @"/memberinfo/loginOut" // 退出登录
#define VERIFY_CODE_SERVER          @"/driving/register/identifyingCode" // 获取验证码
#define VERIFY_VERIFY_CODE_SERVER   @"/driving/register/identifyingCode" // 验证验证码
#define REGISTER_SERVER             @"/driving/register/register" // 注册
#define FORGET_PWD_SERVER           @"/memberinfo/updateMemberPwd" // 忘记密码修改密码
#define MODIFY_PWD_SERVER           @"/memberinfo/updateMemberInfo" // 修改密码

// 约车
#define GET_SUBJECT_SERVER          @"/driving/training/getSubject" // 获取所有科目
#define GET_SUBJECT_COACH_SERVER    @"/driving/training/getTrainerBySubject" // 获取科目教练
#define GET_TIME_SERVER             @"/driving/training/getNextWeekTime" // 获取时间
#define GET_COACH_COURSE_SERVER     @"/driving/training/getCurriculum" // 获取教练课程

// 首页
#define ADS_LIST_SERVER             @"/advertimage/getAdvertImagelist" // 广告接口地址
#define ADDRESS_LIST_SERVER         @"/driving/area/getAreas" // 城市列表
#define GET_SCHOOL_LIST_SERVER      @"/driving/driving/getDrivings" // 驾校列表
#define GET_SCHOOL_COMMENT_LIST_SERVER  @"/driving/comments/getCommDriving" // 驾校评论列表
#define GET_COACH_LIST_SERVER       @"/driving/training/getTrainerBySubjects" // 教练
#define GET_SCHOOL_LIST_CITY_SERVER @"/driving/driving/queryCityToDrivings" // 根据城市获取驾校列表
#define GET_COACH_DETAIL_SERVER     @"/driving/trainer/getTrainerInfo" // 教练详情
#define BLINE_COACH_SERVER          @"/driving/trainer/bindTrainer" // 绑定教练
#define GET_SCHOOL_DETAIL_SERVER    @"/driving/driving/getDrivingDetail" // 获取驾校详情
#define GET_COUPON_SERVER           @"/driving/coupon/toCouponUser" // 生成优惠券
#define FEED_BACK_SERVER            @"/driving/area/toMessage" // 意见反馈

// 我的
#define MY_SCHOOL_SERVER            @"/driving/mydriving/getMyDriving" // 我的驾校
#define COMMENT_SCHOOL_SERVER       @"/driving/mydriving/toMyDriving" // 评价驾校
#define MY_COACH_SERVER             @"/driving/trainer/myTrainer" // 我的教练
#define BLIND_NAME_SERVER           @"/driving/user/updateCnName" // 绑定姓名
#define BLIND_LICENSE_SERVER        @"/driving/user/updateIdentification" // 绑定身份证

// JSON公用字段

#define PARS_KEY              @"pars"
#define RESPONSE_MESSAGE      @"msg"

#endif
