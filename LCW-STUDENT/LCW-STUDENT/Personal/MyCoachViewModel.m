//
//  MyCoachViewModel.m
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/2.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import "MyCoachViewModel.h"

#import "AFNManager.h"
#import "JsonUtils.h"
#import "MyCoachInfo.h"

@implementation MyCoachViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _coachList = [[NSMutableArray alloc] init];
    }
    return self;
}

/**
 *  我的教练
 *
 *  @param controller 控制器
 *  @param callBack   回调
 */
- (void)getMyCoachFromSever:(BaseViewController *)controller
                   callBack:(void(^)(BOOL success))callBack {
    NSDictionary *param = @{
                            @"userId": getUser().id
                            };
    
    [[AFNManager sharedAFNManager] getServer:MY_COACH_SERVER parameters:@{PARS_KEY : [param JSONNSString]} callBack:^(NSDictionary *response, NSString *netErrorMessage) {
        if (netErrorMessage) {
            [controller finishedLodingWithTip:netErrorMessage subTip:@"点击重新加载"];
            callBack(NO);
        } else {
            NSString *responseCode = getResponseCodeFromDic(response);
            if ([responseCode isEqualToString:ResponseCodeSuccess]) {
                [controller finishedLoding];
                NSArray *list = [MyCoachInfo objectArrayWithKeyValuesArray:response[@"data"]];
                [_coachList removeAllObjects];
                [_coachList addObjectsFromArray:list];
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
 *  注销登录
 *
 *  @param controller 控制器
 *  @param callBack   回调
 */
- (void)logoutToServer:(BaseViewController *)controller
              callBack:(void(^)(BOOL success))callBack {
    NSDictionary *param = @{
                            @"userId": getUser().id
                            };
    
    [controller showWaitView:@"正在退出"];
    [[AFNManager sharedAFNManager] getServer:MY_COACH_SERVER parameters:@{PARS_KEY : [param JSONNSString]} callBack:^(NSDictionary *response, NSString *netErrorMessage) {
        if (netErrorMessage) {
            [controller hiddenWaitViewWithTip:netErrorMessage type:MessageWarning];
            callBack(NO);
        } else {
            NSString *responseCode = getResponseCodeFromDic(response);
            if ([responseCode isEqualToString:ResponseCodeSuccess]) {
                [controller hiddenWaitViewWithTip:@"退出成功" type:MessageSuccess];
                deleteUser();
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
