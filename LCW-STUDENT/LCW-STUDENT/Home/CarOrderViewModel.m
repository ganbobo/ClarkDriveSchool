//
//  CarOrderViewModel.m
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/10/28.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import "CarOrderViewModel.h"

#import "JsonUtils.h"
#import "AFNManager.h"
#import "SubjectInfo.h"
#import "CarCoachInfo.h"

@interface CarOrderViewModel () {
    
}

@end

@implementation CarOrderViewModel

- (instancetype)init {
    if (self = [super init]) {
        _dataSource = [[NSMutableArray alloc] init];
        _coachList = [[NSMutableArray alloc] init];
        _timeList = [[NSMutableArray alloc] init];
    }
    
    return self;
}

/**
 *  获取科目列表
 *
 *  @param userId     用户ID
 *  @param controller 控制器
 *  @param callBack   回调
 */

- (void)getSubjectListFromServer:(NSString *)userId
                      controller:(BaseViewController *)controller
                        callBack:(void (^)(BOOL success))callBack {
    NSDictionary *dic = @{
                          @"userId": userId,
                          };
    
    
    [[AFNManager sharedAFNManager] getServer:GET_SUBJECT_SERVER parameters:@{PARS_KEY: [dic JSONNSString]} callBack:^(NSDictionary *response, NSString *netErrorMessage) {
        if (netErrorMessage) {
            if (_dataSource.count <= 0) {
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
                NSArray *array = [SubjectInfo objectArrayWithKeyValuesArray:response[@"data"]];
                [_dataSource removeAllObjects];
                [_dataSource addObjectsFromArray:array];
                callBack(YES);
            } else {
                NSString *message = response[RESPONSE_MESSAGE];
                if (_dataSource.count <= 0) {
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
 *  获取科目教练
 *
 *  @param subjectId  科目ID
 *  @param controller 控制器
 *  @param callBack   回调
 */
- (void)getCoachListFromServer:(NSString *)subjectId
                    controller:(BaseViewController *)controller
                      callBack:(void (^)(BOOL success))callBack {
    NSDictionary *dic = @{
                          @"userId": getUser().id,
                          @"subjectId": subjectId
                          };
    
    
    [[AFNManager sharedAFNManager] getServer:GET_SUBJECT_COACH_SERVER parameters:@{PARS_KEY: [dic JSONNSString]} callBack:^(NSDictionary *response, NSString *netErrorMessage) {
        if (netErrorMessage) {
            if (_dataSource.count <= 0) {
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
                callBack(YES);
            } else {
                NSString *message = response[RESPONSE_MESSAGE];
                if (_dataSource.count <= 0) {
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
 *  获取时间
 *
 *  @param controller 控制器
 *  @param callBack   回调
 */
- (void)getTimeListFromServerController:(BaseViewController *)controller
                               callBack:(void (^)(BOOL success))callBack {
    NSDictionary *dic = @{
                          @"userId": getUser().id
                          };
    
    
    [[AFNManager sharedAFNManager] getServer:GET_TIME_SERVER parameters:@{PARS_KEY: [dic JSONNSString]} callBack:^(NSDictionary *response, NSString *netErrorMessage) {
        if (netErrorMessage) {
            if (_dataSource.count <= 0) {
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
                NSArray *array = [CarCoachInfo objectArrayWithKeyValuesArray:response[@"data"][@"trainerLists"]];
                [_coachList removeAllObjects];
                [_coachList addObjectsFromArray:array];
                
                NSArray *timeArr = response[@"data"][@"numberDayLists"];
                [_timeList removeAllObjects];
                [_timeList addObjectsFromArray:timeArr];
                callBack(YES);
            } else {
                NSString *message = response[RESPONSE_MESSAGE];
                if (_dataSource.count <= 0) {
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
 *  获取简练当天发布课程
 *
 *  @param trainerId   教练ID
 *  @param publishTime 发布时间
 *  @param controller  控制器
 *  @param callBack    回调
 */
- (void)getCourseListFromServer:(NSString *)trainerId
                    publishTime:(long)time
                     controller:(BaseViewController *)controller
                       callBack:(void (^)(BOOL success))callBack {
    NSDictionary *dic = @{
                          @"userId": getUser().id,
                          @"trainerId": trainerId,
                          @"publishTime": @(time)
                          };
    
    
    [[AFNManager sharedAFNManager] getServer:GET_COACH_COURSE_SERVER parameters:@{PARS_KEY: [dic JSONNSString]} callBack:^(NSDictionary *response, NSString *netErrorMessage) {
        if (netErrorMessage) {
            if (_dataSource.count <= 0) {
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
                //                NSArray *array = [SubjectInfo objectArrayWithKeyValuesArray:response[@"data"]];
                //                [_dataSource removeAllObjects];
                //                [_dataSource addObjectsFromArray:array];
                callBack(YES);
            } else {
                NSString *message = response[RESPONSE_MESSAGE];
                if (_dataSource.count <= 0) {
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
 *  约车
 *
 *  @param trainingId 时间段ID
 *  @param controller 控制器
 *  @param callBack   回调
 */
- (void)sendOrderCar:(NSString *)trainingId
          timePeriod:(NSArray *)timePeriod
       publishedTime:(NSString *)publishedTime
          controller:(BaseViewController *)controller
            callBack:(void (^)(BOOL success))callBack {
    NSDictionary *dic = @{
                          @"trainingId": trainingId,
                          @"userId": hasUser() ? getUser().id : @"123",
                          @"timePeriod": timePeriod,
                          @"publishTime": publishedTime
                          };
    [controller showWaitView:@"正在发送约车信息"];
    [[AFNManager sharedAFNManager] getServer:ORDER_CAR_SERVER parameters:@{PARS_KEY: [dic JSONNSString]} callBack:^(NSDictionary *response, NSString *netErrorMessage) {
        if (netErrorMessage) {
            [controller hiddenWaitViewWithTip:netErrorMessage type:MessageWarning];
            callBack(NO);
        } else {
            NSString *responseCode = getResponseCodeFromDic(response);
            if ([responseCode isEqualToString:ResponseCodeSuccess]) {
                [controller hiddenWaitViewWithTip:@"约车成功" type:MessageSuccess];
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
