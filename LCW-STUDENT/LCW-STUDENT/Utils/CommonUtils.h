//
//  CommonUtils.h
//  Gtwy
//
//  Created by lion on 15/8/17.
//  Copyright (c) 2015年 lion. All rights reserved.
//

#import "UserInfo.h"

#import <Foundation/Foundation.h>

/**
 *  获取图片地址
 *
 *  @param imgPath 图片路径
 *
 *  @return 返回图片URL地址
 */
NSURL* getImageUrl(NSString* imgPath);


/**
 *  获取服务器返回responseCode
 *
 *  @param dic 服务器返回response
 *
 *  @return responseCode
 */
NSInteger getResponseCodeFromDic(NSDictionary *dic);

/**
 *  呼叫客服
 */
void callService();

/**
 *  获取Document目录
 *
 *  @return 返回Document目录
 */
NSString* getAppDocumentPathEx();

/**
 *  设置用户
 *
 *  @param user 用户
 */
void setUser(UserInfo* user);

/**
 *  获取用户
 *
 *  @return 返回用户信息
 */
UserInfo* getUser();

/**
 *  删除用户
 */
void deleteUser();

/**
 *  是否有用户
 *
 *  @return 返回是否有用户
 */
BOOL hasUser();

/**
 *  用户触发登录
 *
 *  @return 是否登录
 */
BOOL checkUserLogin(UIViewController *controller);

/**
 *  获取当前软件版本号
 *
 *  @return 返回版本号
 */
NSString* getSystemVsersion();

/**
 *  获取UUID
 *
 *  @return UUID
 */
NSString* getUUIDString();

/**
 *  获取设备唯一标识
 *
 *  @return UUID
 */
NSString* getDeviceIdentifier();
