//
//  AFNManager.m
//  Gtwy
//
//  Created by lion on 15/8/13.
//  Copyright (c) 2015年 lion. All rights reserved.
//

#import "AFNManager.h"

#import "JSONKit.h"

@implementation AFNManager

SYNTHESIZE_SINGLETON_FOR_CLASS(AFNManager);

- (instancetype)init
{
    self = [super init];
    if (self) {
        _baseServerIP = SERVER_ADDRESS;
    }
    return self;
}

/**
 *  获取AFNManager对象
 *
 *  @return 返回一个AFNManager对象
 */
+ (AFNManager *)manager {
    return [AFNManager sharedAFNManager];
}

/**
 *  GET请求
 *
 *  @param serverAddress 接口地址
 *  @param params        传入参数
 *  @param callBack      请求回调，reponseCode请求回调码，message请求的提示，netErrorMessage网络出错的提示
 */
- (void)getServer:(NSString *)serverAddress
       parameters:(NSDictionary *)params
         callBack:(void (^)(NSDictionary *response, NSString *netErrorMessage))callBack {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [manager GET:[self _getServerAddress:serverAddress] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        CLog(@"request url is %@ \n params is %@ \n reponse is %@", serverAddress, params, [(NSDictionary *)responseObject JSONString]);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (callBack) {
            callBack((NSDictionary *)responseObject, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (callBack) {
            callBack(nil, [self _getErrorMessage:error.code]);
        }
    }];
}

/**
 *  POST请求
 *
 *  @param serverAddress 接口地址
 *  @param params        传入参数
 *  @param callBack      请求回调，reponseCode请求回调码，message请求的提示，netErrorMessage网络出错的提示
 */
- (void)postServer:(NSString *)serverAddress
        parameters:(NSDictionary *)params
          callBack:(void (^)(NSDictionary *response, NSString *netErrorMessage))callBack {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [manager POST:[self _getServerAddress:serverAddress] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        CLog(@"request url is %@ \n params is %@ \n reponse is %@", serverAddress, params, [(NSDictionary *)responseObject JSONString]);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (callBack) {
            callBack((NSDictionary *)responseObject, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (callBack) {
            callBack(nil, [self _getErrorMessage:error.code]);
        }
    }];
}

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
         callBack:(void (^)(NSDictionary *response, NSString *netErrorMessage))callBack {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    for (NSString *key in headers.allKeys) {
        [manager.requestSerializer setValue:headers[key] forHTTPHeaderField:key];
    }
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [manager GET:[self _getServerAddress:serverAddress] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        CLog(@"request url is %@ \n params is %@ \n reponse is %@", serverAddress, params, [(NSDictionary *)responseObject JSONString]);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (callBack) {
            callBack((NSDictionary *)responseObject, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (callBack) {
            callBack(nil, [self _getErrorMessage:error.code]);
        }
    }];
}

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
               callBack:(void (^)(NSDictionary *response, NSString *netErrorMessage))callBack {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [manager POST:[self _getServerAddress:serverAddress] parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (NSData *data in imageDatas) {
            [formData appendPartWithFileData:data name:@"img" fileName:[NSString stringWithFormat:@"%@.jpg", getUUIDString()] mimeType:@"image/jpg"];
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        CLog(@"request url is %@ \n params is %@ \n reponse is %@", serverAddress, params, [(NSDictionary *)responseObject JSONString]);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (callBack) {
            callBack((NSDictionary *)responseObject, nil);
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (callBack) {
            callBack(nil, [self _getErrorMessage:error.code]);
        }
    }];
}


#pragma - mark 私有方法

/**
 *  获取请求接口地址
 *
 *  @param serverAddress 设置的地址
 *
 *  @return 返回请求的接口地址
 */
- (NSString *)_getServerAddress:(NSString *)serverAddress {
    if ([serverAddress rangeOfString:@"http://"].location != NSNotFound || [serverAddress rangeOfString:@"https://"].location != NSNotFound) {
        return serverAddress;
    }
    
    NSString *serverAddressa = [NSString stringWithFormat:@"%@%@", _baseServerIP, serverAddress];
    return serverAddressa;
}

#pragma - mark 解析服务器错误

- (NSString *)_getErrorMessage:(NSInteger)code {
    NSString *errorMsg = @"";
    switch (code) {
        case ErrorCodeOverTime:
            errorMsg = NSLocalizedStringEx(@"SeverTimeoutTip", nil);
            break;
            
        case ErrorCodeInterrupt:// 连接中断
            errorMsg = NSLocalizedStringEx(@"SeverNetErrorTip", nil);
            break;
            
        case ErrorCodeNetWork:// 网络断开连接
            errorMsg = NSLocalizedStringEx(@"SeverNetErrorTip", nil);
            break;
            
        case ErrorCodeNotConnectServer: // 未能连接到服务器
            errorMsg = NSLocalizedStringEx(@"SeverCannotConnectNetTip", nil);
            break;
            
        default:
            errorMsg = NSLocalizedStringEx(@"SeverErrorTip", nil);
            break;
    }
    
    return errorMsg;
}

@end
