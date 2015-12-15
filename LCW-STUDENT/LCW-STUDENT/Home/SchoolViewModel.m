//
//  SchoolViewModel.m
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/2.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import "SchoolViewModel.h"

#import "AFNManager.h"
#import "JSONKit.h"

@implementation SchoolViewModel

/**
 *  驾校详情
 *
 *  @param controller 控制器
 *  @param driveId    驾校ID
 *  @param callBack   回调
 */
- (void)getSchoolDetailFromSever:(BaseViewController *)controller
                         driveId:(NSString *)driveId
                        callBack:(void(^)(BOOL success))callBack {
    NSDictionary *param = @{
                            @"userId": (hasUser() ? getUser().id : @"123"),
                            @"driving_id": driveId
                            };
    
    [[AFNManager sharedAFNManager] getServer:GET_SCHOOL_DETAIL_SERVER parameters:@{PARS_KEY : [param JSONString]} callBack:^(NSDictionary *response, NSString *netErrorMessage) {
        if (netErrorMessage) {
            [controller finishedLodingWithTip:netErrorMessage subTip:@"点击重新加载"];
            callBack(NO);
        } else {
            NSString *responseCode = getResponseCodeFromDic(response);
            if ([responseCode isEqualToString:ResponseCodeSuccess]) {
                [controller finishedLoding];
                _schoolDetailInfo = [SchoolDetailInfo objectWithKeyValues:response[@"data"]];
                callBack(YES);
            } else {
                NSString *message = response[RESPONSE_MESSAGE];
                [controller finishedLodingWithTip:message subTip:@"点击重新加载"];
                callBack(NO);
            }
            
        }
    }];
}

/**
 *  生成优惠券
 *
 *  @param controller 控制器
 *  @param driveId    驾校ID
 *  @param name       姓名
 *  @param identifier 身份证号
 *  @param callBack   回调
 */
- (void)getCouponFromSever:(BaseViewController *)controller
                   driveId:(NSString *)driveId
                      name:(NSString *)name
                identifier:(NSString *)identifier
                  callBack:(void(^)(BOOL success))callBack {
    NSDictionary *param = @{
                            @"userId": getUser().id,
                            @"drivingId": driveId,
                            @"cnName": name,
                            @"identification": identifier
                            };
    [controller showWaitView:@"正在生成优惠券"];
    [[AFNManager sharedAFNManager] postServer:GET_COUPON_SERVER parameters:@{PARS_KEY : [param JSONString]} callBack:^(NSDictionary *response, NSString *netErrorMessage) {
        if (netErrorMessage) {
            [controller hiddenWaitViewWithTip:netErrorMessage type:MessageWarning];
            callBack(NO);
        } else {
            NSString *responseCode = getResponseCodeFromDic(response);
            if ([responseCode isEqualToString:ResponseCodeSuccess]) {
                [controller hiddenWaitView];
                UserInfo *user = getUser();
                user.cn_name = name;
                user.identification = identifier;
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
 *  验证输入姓名和身份证号
 *
 *  @param name       姓名
 *  @param identifier 身份证
 *  @param controller 控制器
 *
 *  @return 是否通过验证
 */
- (BOOL)checkUserInput:(NSString *)name
            identifier:(NSString *)identifier
            controller:(BaseViewController *)controller {
    if (name.length <= 0) {
        [controller showMiddleToastWithContent:@"请输入姓名"];
        return NO;
    }
    
    if (identifier.length <= 0) {
        [controller showMiddleToastWithContent:@"请输入姓名"];
        return NO;
    }
    
    return YES;
}

@end
