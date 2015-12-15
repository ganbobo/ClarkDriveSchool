//
//  EditViewModel.m
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/5.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import "EditViewModel.h"

#import "AFNManager.h"
#import "JSONKit.h"

@implementation EditViewModel

/**
 *  修改昵称
 *
 *  @param name       姓名
 *  @param controller 控制器
 *  @param callBack   回调
 */
- (void)updateNameToServer:(NSString *)name
                controller:(BaseViewController *)controller
                  callBacl:(void(^)(BOOL success))callBack {
    NSDictionary *param = @{
                            @"userId": getUser().id,
                            @"cnName": name
                            };
    
    [controller showWaitView:@"正在绑定"];
    [[AFNManager sharedAFNManager] postServer:BLIND_NAME_SERVER parameters:@{PARS_KEY: [param JSONString]} callBack:^(NSDictionary *response, NSString *netErrorMessage) {
        if (netErrorMessage) {
            [controller hiddenWaitViewWithTip:netErrorMessage type:MessageWarning];
            callBack(NO);
        } else {
            NSString *responseCode = getResponseCodeFromDic(response);
            if ([responseCode isEqualToString:ResponseCodeSuccess]) {
                [controller hiddenWaitViewWithTip:@"绑定成功" type:MessageSuccess];
                UserInfo *user = getUser();
                user.cn_name = name;
                [user updatetoDb];
                callBack(YES);
            } else {
                NSString *message = response[RESPONSE_MESSAGE];
                [controller hiddenWaitViewWithTip:message type:MessageFailed];
                callBack(NO);
            }
        }
    }];

}

/**
 *  修改身份证
 *
 *  @param license    身份证号
 *  @param controller 控制器
 *  @param callBack   回调
 */
- (void)updateLicenseToServer:(NSString *)license
                   controller:(BaseViewController *)controller
                     callBacl:(void(^)(BOOL success))callBack {
    NSDictionary *param = @{
                            @"userId": getUser().id,
                            @"identification": license
                            };
    
    [controller showWaitView:@"正在绑定"];
    [[AFNManager sharedAFNManager] getServer:BLIND_LICENSE_SERVER parameters:@{PARS_KEY: [param JSONString]} callBack:^(NSDictionary *response, NSString *netErrorMessage) {
        if (netErrorMessage) {
            [controller hiddenWaitViewWithTip:netErrorMessage type:MessageWarning];
            callBack(NO);
        } else {
            NSString *responseCode = getResponseCodeFromDic(response);
            if ([responseCode isEqualToString:ResponseCodeSuccess]) {
                [controller hiddenWaitViewWithTip:@"绑定成功" type:MessageSuccess];

                UserInfo *user = getUser();
                user.identification = license;
                [user updatetoDb];
                callBack(YES);
            } else {
                NSString *message = response[RESPONSE_MESSAGE];
                [controller hiddenWaitViewWithTip:message type:MessageFailed];
                callBack(NO);
            }
        }
    }];

}

@end
