//
//  CommonUtils.m
//  Gtwy
//
//  Created by lion on 15/8/17.
//  Copyright (c) 2015年 lion. All rights reserved.
//

#import "CommonUtils.h"

#define RESULT   @"flag"

/**
 *  获取图片地址
 *
 *  @param imgPath 图片路径
 *
 *  @return 返回图片URL地址
 */
NSURL* getImageUrl(NSString* imgPath) {
    if ([imgPath rangeOfString:@"http"].location != NSNotFound) {
        return [NSURL URLWithString:imgPath];
    }
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", IMAGE_SERVER, imgPath]];
}

/**
 *  获取服务器返回responseCode
 *
 *  @param dic 服务器返回response
 *
 *  @return responseCode
 */
NSString* getResponseCodeFromDic(NSDictionary *dic) {
    NSString *code = @"false";
    if (dic[RESULT] && ![dic[RESULT] isKindOfClass:[NSNull class]]) {
        code = dic[RESULT];
    }
    
    return code;
}

/**
 *  呼叫客服
 */
void callService() {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@",@"18119929669"]]];
}

/**
 *  获取Document目录
 *
 *  @return 返回Document目录
 */
NSString* getAppDocumentPathEx() {
    NSArray* lpPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);//NSDocumentDirectory
    if([lpPaths count]>0)
        return [lpPaths objectAtIndex:0];
    else
        return nil;
}

/**
 *  设置用户
 *
 *  @param user 用户
 */
void setUser(UserInfo* user) {
    
    // 存入用户
    if ([UserInfo existDbObjectsWhere:[NSString stringWithFormat:@"id = '%@'", user.id]]) {
        [UserInfo removeDbObjectsWhere:[NSString stringWithFormat:@"id = '%@'", user.id]];
        [user insertToDb];
    } else {
        [user insertToDb];
    }

}

/**
 *  获取用户
 *
 *  @return 返回用户信息
 */
UserInfo* getUser() {
    NSArray *arrayLocal = [UserInfo allDbObjects];
    if (arrayLocal && arrayLocal.count > 0) {
        UserInfo *info = arrayLocal.firstObject;
        return info;
    }
    return nil;
}

/**
 *  删除用户
 */
void deleteUser() {
    UserInfo *user = getUser();
    [user removeFromDb];
}

/**
 *  是否有用户
 *
 *  @return 返回是否有用户
 */
BOOL hasUser() {
    UserInfo *user = getUser();
    if (user) {
        return YES;
    }
    
    return NO;
}

/**
 *  用户触发登录
 *
 *  @return 是否登录
 */
BOOL checkUserLogin(UIViewController *controller) {
    if (hasUser()) {
        return YES;
    }
    UIViewController *loginNav = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateInitialViewController];
    [controller presentViewController:loginNav animated:YES completion:nil];
    
    return NO;
}

/**
 *  获取当前软件版本号
 *
 *  @return 返回版本号
 */
NSString* getSystemVsersion() {
    NSString *strVersion = [NSString stringWithFormat:@"%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    
    return strVersion;
}

/**
 *  获取UUID
 *
 *  @return UUID
 */
NSString* getUUIDString() {
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    
    CFRelease(uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString*)uuid_string_ref];
    
    CFRelease(uuid_string_ref);
    return [uuid stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

/**
 *  获取设备唯一标识
 *
 *  @return UUID
 */
NSString* getDeviceIdentifier() {
    NSString *UUID = [[NSUserDefaults standardUserDefaults] valueForKey:@"UUID_GTWY"];
    if (UUID && UUID.length > 0) {
        return UUID;
    }
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    
    CFRelease(uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString*)uuid_string_ref];
    
    CFRelease(uuid_string_ref);
    UUID = [uuid stringByReplacingOccurrencesOfString:@"-" withString:@""];
    [[NSUserDefaults standardUserDefaults] setValue:UUID forKey:@"UUID_GTWY"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return UUID;
}
