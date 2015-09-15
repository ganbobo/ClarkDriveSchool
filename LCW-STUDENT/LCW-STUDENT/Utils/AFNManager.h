//
//  AFNManager.h
//  Gtwy
//
//  Created by lion on 15/8/13.
//  Copyright (c) 2015年 lion. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AFHTTPRequestOperationManager.h>

/**
 *  网络请求接口管理器
 */

@interface AFNManager : NSObject

DECLARE_SINGLETON_FOR_CLASS(AFNManager);

// IP地址设置
@property(nonatomic, retain)NSString *baseServerIP;

/**
 *  获取AFNManager对象
 *
 *  @return 返回一个AFNManager对象
 */
+ (AFNManager *)manager;

/**
 *  GET请求
 *
 *  @param serverAddress 接口地址
 *  @param params        传入参数
 *  @param callBack      请求回调，reponseCode请求回调码，message请求的提示，netErrorMessage网络出错的提示
 */
- (void)getServer:(NSString *)serverAddress
       parameters:(NSDictionary *)params
         callBack:(void (^)(NSDictionary *response, NSString *netErrorMessage))callBack;

/**
 *  POST请求
 *
 *  @param serverAddress 接口地址
 *  @param params        传入参数
 *  @param callBack      请求回调，reponseCode请求回调码，message请求的提示，netErrorMessage网络出错的提示
 */
- (void)postServer:(NSString *)serverAddress
        parameters:(NSDictionary *)params
          callBack:(void (^)(NSDictionary *response, NSString *netErrorMessage))callBack;

/**
 *  GET请求，为了天气
 *
 *  @param serverAddress 接口地址
 *  @param headers       请求头
 *  @param params        传入参数
 *  @param callBack      请求回调，reponseCode请求回调码，message请求的提示，netErrorMessage网络出错的提示
 */
- (void)getServer:(NSString *)serverAddress
          headers:(NSDictionary *)headers
       parameters:(NSDictionary *)params
         callBack:(void (^)(NSDictionary *response, NSString *netErrorMessage))callBack;

/**
 *  上传图片
 *
 *  @param serverAddress 服务器地址
 *  @param imageDatas    图片数据数组
 *  @param params        请求参数
 *  @param callBack      请求回调
 */
- (void)postImageServer:(NSString *)serverAddress
              imageData:(NSArray *)imageDatas
             parameters:(NSDictionary *)params
               callBack:(void (^)(NSDictionary *response, NSString *netErrorMessage))callBack;

@end
