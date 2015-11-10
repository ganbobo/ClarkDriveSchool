//
//  MySchoolViewModel.m
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/2.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import "MySchoolViewModel.h"
#import "AFNManager.h"
#import "JsonUtils.h"
#import "MySchoolInfo.h"

@implementation MySchoolViewModel


/**
 *  我的驾考
 *
 *  @param controller 控制器
 *  @param callBack   回调
 */
- (void)getSchoolDetailFromSever:(BaseViewController *)controller
                        callBack:(void(^)(BOOL success))callBack {
    NSDictionary *param = @{
                            @"userId": getUser().id
                            };
    
    [[AFNManager sharedAFNManager] getServer:MY_SCHOOL_SERVER parameters:@{PARS_KEY : [param JSONNSString]} callBack:^(NSDictionary *response, NSString *netErrorMessage) {
        if (netErrorMessage) {
            [controller finishedLodingWithTip:netErrorMessage subTip:@"点击重新加载"];
            callBack(NO);
        } else {
            NSString *responseCode = getResponseCodeFromDic(response);
            if ([responseCode isEqualToString:ResponseCodeSuccess]) {
                [controller finishedLoding];
                _mySchoolInfo = [MySchoolInfo objectWithKeyValues:response[@"data"]];
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
 *  评价驾校
 *
 *  @param drivingId      驾校ID
 *  @param scole          总分
 *  @param enScole        环境分
 *  @param prosceScole    前台服务
 *  @param drivingTrainer 教练服务
 *  @param comment        评论内容
 *  @param showName       是否匿名
 *  @param controller     控制器
 *  @param callBack       回调
 */
- (void)sendCommentToServer:(NSString *)drivingId
               drivingScole:(NSInteger)scole
                    enScole:(NSInteger)enScole
                prosceScole:(NSInteger)prosceScole
             drivingTrainer:(NSInteger)drivingTrainer
            driving_comment:(NSString *)comment
                 isShowName:(BOOL)showName
                 controller:(BaseViewController *)controller
                   callBack:(void(^)(BOOL success))callBack {
    [controller showWaitView:@"正在发送评论"];
    NSDictionary *dic = @{
                          @"driving_id": drivingId,
                          @"driving_scole": @(scole),
                          @"driving_environment":@(enScole),
                          @"driving_proscenium": @(prosceScole),
                          @"driving_trainer": @(drivingTrainer),
                          @"driving_comment": comment,
                          @"is_comm": showName ? @"1" : @"0",
                          @"userId": hasUser() ? getUser().id : @"123"
                          };
    [[AFNManager sharedAFNManager] getServer:COMMENT_SCHOOL_SERVER parameters:@{PARS_KEY: [dic JSONNSString]} callBack:^(NSDictionary *response, NSString *netErrorMessage) {
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
