//
//  CoachViewModel.m
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/5.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import "CoachViewModel.h"

#import "AFNManager.h"
#import "JsonUtils.h"

#import "CoachModel.h"

@implementation CoachViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _coachList = [[NSMutableArray alloc] init];
    }
    return self;
}

/**
 *  获取教练列表
 *
 *  @param subjectId       科目ID
 *  @param sex             性别
 *  @param typeName        驾照类型
 *  @param overplusTrainee 热度
 *  @param controller      控制器
 *  @param callBack        回调
 */
- (void)getCoachListFromServer:(NSString *)subjectId
                           sex:(NSString *)sex
                      typeName:(NSString *)typeName
               overplusTrainee:(NSString *)overplusTrainee
                    controller:(BaseViewController *)controller
                      callBack:(void(^)(BOOL success))callBack {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:getUser().id forKey:@"userId"];
    [param setValue:subjectId forKey:@"subjectId"];
    if (sex.length > 0) {
        [param setValue:sex forKey:@"sex"];
    }
    
    if (typeName.length > 0) {
        [param setValue:typeName forKey:@"typeName"];
    }
    
    if (overplusTrainee.length > 0) {
        [param setValue:overplusTrainee forKey:@"overplusTrainee"];
    }
    
    [[AFNManager sharedAFNManager] getServer:GET_COACH_LIST_SERVER parameters:@{PARS_KEY: [param JSONNSString]} callBack:^(NSDictionary *response, NSString *netErrorMessage) {
        if (netErrorMessage) {
            if (_coachList.count <= 0) {
                [controller finishedLodingWithTip:netErrorMessage subTip:@"点击重新加载"];
            } else {
                [controller finishedLoding];
                [controller showMiddleToastWithContent:netErrorMessage];
            }
            callBack(NO);
        } else {
            NSString *responseCode = getResponseCodeFromDic(response);
            if ([responseCode isEqualToString:ResponseCodeSuccess]) {
                [controller finishedLoding];
                NSArray *array = [CoachModel objectArrayWithKeyValuesArray:response[@"data"]];
                [_coachList removeAllObjects];
                [_coachList addObjectsFromArray:array];
                callBack(YES);
            } else {
                NSString *message = response[RESPONSE_MESSAGE];
                if (_coachList.count <= 0) {
                    [controller finishedLodingWithTip:message subTip:@"点击重新加载"];
                } else {
                    [controller finishedLoding];
                    [controller showMiddleToastWithContent:message];
                }
                callBack(NO);
            }
        }
    }];
}

/**
 *  获取教练详情
 *
 *  @param trainerId  教练ID
 *  @param controller 控制器
 *  @param callBack   回调
 */
- (void)getCoachDetailInfoFromServer:(NSString *)trainerId
                          controller:(BaseViewController *)controller
                            callBack:(void(^)(BOOL success))callBack {
    NSDictionary *param = @{
                            @"userId": hasUser() ? getUser().id : @"123",
                            @"trainerId": trainerId
                            };
    [[AFNManager sharedAFNManager] getServer:GET_COACH_DETAIL_SERVER parameters:@{PARS_KEY: [param JSONNSString]} callBack:^(NSDictionary *response, NSString *netErrorMessage) {
        if (netErrorMessage) {
            [controller finishedLodingWithTip:netErrorMessage subTip:@"点击重新加载"];
            callBack(NO);
        } else {
            NSString *responseCode = getResponseCodeFromDic(response);
            if ([responseCode isEqualToString:ResponseCodeSuccess]) {
                [controller finishedLoding];
                _coachDetailModel = [CoachDetailModel objectWithKeyValues:response[@"data"]];
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
 *  绑定教练
 *
 *  @param trainerId  教练ID
 *  @param subjectId  科目ID
 *  @param controller 控制器
 *  @param callBack   回调
 */
- (void)blindCoachToServer:(NSString *)trainerId
                 subjectId:(NSString *)subjectId
                controller:(BaseViewController *)controller
                  callBack:(void(^)(BOOL success))callBack {
    NSDictionary *param = @{
                            @"userId": getUser().id,
                            @"trainerId": trainerId,
                            @"subjectId": subjectId
                            };
    
    [controller showWaitView:@"正在绑定"];
    [[AFNManager sharedAFNManager] getServer:BLINE_COACH_SERVER parameters:@{PARS_KEY: [param JSONNSString]} callBack:^(NSDictionary *response, NSString *netErrorMessage) {
        if (netErrorMessage) {
            [controller hiddenWaitViewWithTip:netErrorMessage type:MessageWarning];
            callBack(NO);
        } else {
            NSString *responseCode = getResponseCodeFromDic(response);
            if ([responseCode isEqualToString:ResponseCodeSuccess]) {
                [controller hiddenWaitViewWithTip:@"绑定成功" type:MessageSuccess];
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
