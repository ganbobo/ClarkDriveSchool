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
                NSArray *list = [MyCoachInfo objectArrayWithKeyValuesArray:response[@"data"][@"list"]];
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

/**
 *  评价教练
 *
 *  @param trainerId      教练ID
 *  @param scole          总体评分
 *  @param attitude       教学态度
 *  @param ablility       教学能力
 *  @param environment    车内环境
 *  @param comment        评论
 *  @param showName       是否匿名
 *  @param controller     控制器
 *  @param callBack       回调
 */
- (void)sendCoachCommentToServer:(NSString *)trainerId
                           scole:(NSInteger)scole
                        attitude:(NSInteger)attitude
                        ablility:(NSInteger)ablility
                     environment:(NSInteger)environment
                         comment:(NSString *)comment
                      isShowName:(BOOL)showName
                      controller:(BaseViewController *)controller
                        callBack:(void(^)(BOOL success))callBack {
    [controller showWaitView:@"正在发送评论"];
    NSDictionary *dic = @{
                          @"trainer_id": trainerId,
                          @"trainer_scole": @(scole),
                          @"trainer_attitude":@(attitude),
                          @"trainer_ability": @(ablility),
                          @"trainer_environment": @(environment),
                          @"trainer_comment": comment,
                          @"is_comm": showName ? @"1" : @"0",
                          @"userId": hasUser() ? getUser().id : @"123"
                          };
    [[AFNManager sharedAFNManager] getServer:COMMENT_COACH_SERVER parameters:@{PARS_KEY: [dic JSONNSString]} callBack:^(NSDictionary *response, NSString *netErrorMessage) {
        if (netErrorMessage) {
            [controller hiddenWaitViewWithTip:netErrorMessage type:MessageWarning];
            callBack(NO);
        } else {
            NSString *responseCode = getResponseCodeFromDic(response);
            if ([responseCode isEqualToString:ResponseCodeSuccess]) {
                [controller hiddenWaitViewWithTip:@"评论成功" type:MessageSuccess];
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
