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
//#define SERVER_ADDRESS    @"http://gty.gt278.com:8888"
//#define IMAGE_SERVER      @"http://gty.gt278.com:8088"

//#define SERVER_ADDRESS    @"http://1.1.1.46:9999"
#define SERVER_ADDRESS    @"http://1.1.1.239:8888"
#define IMAGE_SERVER      @"http://1.1.1.239:8088"

// 登录注册
#define NEW_VERSION_SERVER          @"/version/checkVersion" // 版本检测
#define LOGIN_SERVER                @"/memberinfo/login" // 登录
#define LOGOUT_SERVER               @"/memberinfo/loginOut" // 退出登录
#define VERIFY_CODE_SERVER          @"/memberinfo/validateByMobile" // 获取验证码
#define VERIFY_VERIFY_CODE_SERVER   @"/memberinfo/validateCode" // 验证验证码
#define REGISTER_SERVER             @"/memberinfo/saveMemberInfo" // 注册
#define FORGET_PWD_SERVER           @"/memberinfo/updateMemberPwd" // 忘记密码修改密码
#define MODIFY_PWD_SERVER           @"/memberinfo/updateMemberInfo" // 修改密码


// 首页
#define ADS_LIST_SERVER             @"/advertimage/getAdvertImagelist" // 广告接口地址

#define LUSHU_DOWNLOAD_SERVER       @"/roadBook/getRoadBookSeller" // 路书下载

#define STRATEGY_SERVER             @"/strategy/getStrategyDisLabelList" // 自驾游攻略
#define ROAD_LIST_SERVER            @"/roadBook/getRoadBookDisLabelList" // 自驾游路书
#define RECOMMEND_SERVER            @"/recommend/getRecommendList" // 商家、巨划算、美食接口
#define HOT_RECOMMENT_SERVER        @"/reconinfo/getRecinfo" // 热门推荐

#define PRAISE_SERVER               @"/pracisecon/savePraise" // 赞

// 主题
#define GET_SUBJECT_LIST_SERVER            @"/theme/queryThemeList" // 主题列表
#define GET_SUBJECT_DETAIL_INFO_SERVER     @"/theme/queryThemeId" // 主题列表

// 个人中心
#define UPDATE_USER_INFO_SERVER            @"/memberinfo/updateMember" // 修改用户信息

// JSON公用字段

#define RESPONSE_MESSAGE      @"msg"

#endif
