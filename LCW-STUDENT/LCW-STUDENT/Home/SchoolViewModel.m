//
//  SchoolViewModel.m
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/2.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import "SchoolViewModel.h"

#import "AFNManager.h"
#import "JsonUtils.h"

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
                            @"userId": getUser().id,
                            @"driving_id": driveId
                            };
    
    [[AFNManager sharedAFNManager] getServer:GET_SCHOOL_DETAIL_SERVER parameters:@{PARS_KEY : [param JSONNSString]} callBack:^(NSDictionary *response, NSString *netErrorMessage) {
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

@end
