//
//  EnumType.h
//  Gtwy
//
//  Created by lion on 15/8/13.
//  Copyright (c) 2015年 lion. All rights reserved.
//

/**
 *  存放枚举的类型
 */

#ifndef Gtwy_EnumType_h
#define Gtwy_EnumType_h

/**
 网络错误枚举类型
 */
typedef enum {
    ErrorCodeOverTime = -1001,// 请求超时
    ErrorCode503 = -1011,// 503 错误
    ErrorCodeNotConnectServer = -1004,// 未能连接服务器
    ErrorCodeInterrupt = -1005,// 连接中断
    ErrorCodeNetWork = -1009, // 与互联网断开连接
} ErrorCode;

#define ResponseCodeSuccess  @"true"   // 请求成功
#define ResponseCodeFailed   @"false"   // 请求失败

typedef enum {
    MessageSuccess = 0,  // 成功
    MessageFailed = 1,   // 失败
    MessageWarning = 2   // 警告
} MessageType;

typedef enum {
    AdsTypeLaunch = 1,  // 启动
    AdsTypeHome = 2   // 首页
} AdsType;

typedef enum {
    GuituTypeFood = 1,  // 目的地美食
    GuituTypeStrategy = 2,   // 攻略
    GuituTypeStore = 3, // 商家
    GuituTypeLushu = 4, // 路书
    GuituTypeConvinence = 5, // 便民信息
    GuituTypeBargain = 6 // 聚划算
} GuituType;

typedef enum {
    PraiseTypeRoadBook = 1,  // 路书
    PraiseTypeProduct = 2,   // 商品
    PraiseTypeStore = 3, // 商家
    PraiseTypeStrategy = 4, // 攻略
} PraiseType;

typedef enum {
    VerifyCodeTypeRegister = 1,  // 注册
    VerifyCodeTypeForgetPwd = 2   // 忘记密码
} VerifyCodeType;

#endif
