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
