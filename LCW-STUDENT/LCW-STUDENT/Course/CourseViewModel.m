//
//  CourseViewModel.m
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/17.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import "CourseViewModel.h"
#import "AFNManager.h"
#import "JsonUtils.h"
#import "CourseInfo.h"

@implementation CourseViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return self;
}

/**
 *  获取课程列表
 *
 *  @param controller 控制器
 *  @param callBack   回调
 */
- (void)getCourseList:(BaseViewController *)controller
             callBack:(void(^)(BOOL success))callBack {
    NSDictionary *param = @{
                            @"userId": getUser().id
                            };
    
    [[AFNManager sharedAFNManager] getServer:GET_COURSE_LIST_SERVER parameters:@{PARS_KEY : [param JSONNSString]} callBack:^(NSDictionary *response, NSString *netErrorMessage) {
        if (netErrorMessage) {
            [controller finishedLodingWithTip:netErrorMessage subTip:@"点击重新加载"];
            callBack(NO);
        } else {
            NSString *responseCode = getResponseCodeFromDic(response);
            if ([responseCode isEqualToString:ResponseCodeSuccess]) {
                [controller finishedLoding];
                NSArray *list = [CourseInfo objectArrayWithKeyValuesArray:response[@"data"][@"jr"]];
                [_dataSource removeAllObjects];
                [_dataSource addObjectsFromArray:list];
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
 *  取消约车
 *
 *  @param userId     学员ID
 *  @param userDayId  约车记录ID
 *  @param recordTime 约车时间戳
 *  @param controller 控制器
 *  @param callBack   回调
 */
- (void)cancelOrderCar:(NSString *)userId
             userDayId:(NSString *)userDayId
            recordTime:(NSString *)recordTime
            controller:(BaseViewController *)controller
              callBack:(void(^)(BOOL success))callBack {
    NSDictionary *param = @{
                            @"userId": getUser().id,
                            @"userDayId": userDayId,
                            @"recordTime": recordTime
                            };
    
    [controller showWaitView:@"正在取消"];
    [[AFNManager sharedAFNManager] getServer:CANCEL_COURSE_SERVER parameters:@{PARS_KEY : [param JSONNSString]} callBack:^(NSDictionary *response, NSString *netErrorMessage) {
        if (netErrorMessage) {
            [controller hiddenWaitViewWithTip:netErrorMessage type:MessageWarning];
            callBack(NO);
        } else {
            NSString *responseCode = getResponseCodeFromDic(response);
            if ([responseCode isEqualToString:ResponseCodeSuccess]) {
                [controller hiddenWaitViewWithTip:@"取消成功" type:MessageSuccess];
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
