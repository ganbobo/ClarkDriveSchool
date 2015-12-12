//
//  SchoolCommentViewModel.m
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/10.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import "SchoolCommentViewModel.h"

#import "AFNManager.h"
#import "JSONKit.h"

@implementation SchoolCommentViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _commentList = [[NSMutableArray alloc] init];
    }
    return self;
}

/**
 *  获取评论列表
 *
 *  @param drivingId  驾校ID
 *  @param controller 控制器
 *  @param callBack   回调
 */
- (void)getCommentListFromServer:(NSString *)drivingId
                      controller:(BaseViewController *)controller
                        callBack:(void(^)(BOOL success))callBack {
    NSDictionary *param = @{
                            @"userId": (hasUser() ? getUser().id : @"123"),
                            @"drivingId": drivingId
                            };
    [[AFNManager sharedAFNManager] getServer:GET_SCHOOL_COMMENT_LIST_SERVER parameters:@{PARS_KEY: [param JSONString]} callBack:^(NSDictionary *response, NSString *netErrorMessage) {
        if (netErrorMessage) {
            if (_commentList.count <= 0) {
                if (controller) {
                    [controller finishedLodingWithTip:netErrorMessage subTip:@"点击重新加载"];
                }
                
            } else {
                if (controller) {
                    [controller finishedLoding];
                    [controller finishedLodingWithTip:netErrorMessage subTip:@"点击重新加载"];
                }
                
            }
            callBack(NO);
        } else {
            NSString *responseCode = getResponseCodeFromDic(response);
            if ([responseCode isEqualToString:ResponseCodeSuccess]) {
                [controller finishedLoding];
                NSArray *array = [ShopCommentInfo objectArrayWithKeyValuesArray:response[@"data"]];
                [_commentList removeAllObjects];
                [_commentList addObjectsFromArray:array];

                callBack(YES);
            } else {
                NSString *message = response[RESPONSE_MESSAGE];
                if (_commentList.count <= 0) {
                    if (controller) {
                        [controller finishedLodingWithTip:message subTip:@"点击重新加载"];
                    }
                } else {
                    if (controller) {
                        [controller finishedLoding];
                        [controller showMiddleToastWithContent:message];
                    }
                }
                callBack(NO);
            }
        }
    }];

}

/**
 *  获取教练评论列表
 *
 *  @param trainerId  教练ID
 *  @param controller 控制器
 *  @param callBack   回调
 */
- (void)getCoachCommentListFromServer:(NSString *)trainerId
                           controller:(BaseViewController *)controller
                             callBack:(void(^)(BOOL success))callBack {
    NSDictionary *param = @{
                            @"userId": (hasUser() ? getUser().id : @"123"),
                            @"trainerId": trainerId
                            };
    [[AFNManager sharedAFNManager] getServer:GET_COACH_COMMENT_LIST_SERVER parameters:@{PARS_KEY: [param JSONString]} callBack:^(NSDictionary *response, NSString *netErrorMessage) {
        if (netErrorMessage) {
            if (_commentList.count <= 0) {
                if (controller) {
                    [controller finishedLodingWithTip:netErrorMessage subTip:@"点击重新加载"];
                }
                
            } else {
                if (controller) {
                    [controller finishedLoding];
                    [controller finishedLodingWithTip:netErrorMessage subTip:@"点击重新加载"];
                }
                
            }
            callBack(NO);
        } else {
            NSString *responseCode = getResponseCodeFromDic(response);
            if ([responseCode isEqualToString:ResponseCodeSuccess]) {
                [controller finishedLoding];
                NSArray *array = [ShopCommentInfo objectArrayWithKeyValuesArray:response[@"data"]];
                [_commentList removeAllObjects];
                [_commentList addObjectsFromArray:array];
                
                callBack(YES);
            } else {
                NSString *message = response[RESPONSE_MESSAGE];
                if (_commentList.count <= 0) {
                    if (controller) {
                        [controller finishedLodingWithTip:message subTip:@"点击重新加载"];
                    }
                } else {
                    if (controller) {
                        [controller finishedLoding];
                        [controller showMiddleToastWithContent:message];
                    }
                }
                callBack(NO);
            }
        }
    }];
    
}

@end
