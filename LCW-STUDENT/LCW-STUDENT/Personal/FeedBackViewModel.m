//
//  FeedBackViewModel.m
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/1.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import "FeedBackViewModel.h"
#import "JSONKit.h"
#import "AFNManager.h"

@implementation FeedBackViewModel

/**
 *  意见反馈
 *
 *  @param controller 控制器
 *  @param msg        反馈意见
 *  @param callBack   回调
 */
- (void)sendFeedbackToServerController:(BaseViewController *)controller
                                   msg:(NSString *)msg
                              callBack:(void (^)(BOOL success))callBack {
    NSDictionary *dic = @{
                          @"userId": getUser().id,
                          @"message": msg
                          };
    
    [controller showWaitView:@"正在发送"];
    [[AFNManager sharedAFNManager] getServer:FEED_BACK_SERVER parameters:@{PARS_KEY: [dic JSONString]} callBack:^(NSDictionary *response, NSString *netErrorMessage) {
        if (netErrorMessage) {
            [controller hiddenWaitViewWithTip:netErrorMessage type:MessageWarning];
            callBack(NO);
        } else {
            NSString *responseCode = getResponseCodeFromDic(response);
            if ([responseCode isEqualToString:ResponseCodeSuccess]) {
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
