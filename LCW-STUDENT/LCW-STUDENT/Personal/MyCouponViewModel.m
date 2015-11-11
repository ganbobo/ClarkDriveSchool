//
//  MyCouponViewModel.m
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/3.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import "MyCouponViewModel.h"

#import "AFNManager.h"
#import "JsonUtils.h"
#import "MyCouponInfo.h"

@implementation MyCouponViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return self;
}

/**
 *  获取我的优惠券
 *
 *  @param controller 控制器
 *  @param callback   回调
 */
- (void)getMyCouponListFromServer:(BaseViewController *)controller callback:(void(^)(BOOL success))callback {
    NSDictionary *param = @{
                            @"userId": (hasUser() ? getUser().id : @"123")
                            };
    
    [[AFNManager sharedAFNManager] getServer:MY_COUPON_LIST_SERVER parameters:@{PARS_KEY : [param JSONNSString]} callBack:^(NSDictionary *response, NSString *netErrorMessage) {
        if (netErrorMessage) {
            [controller finishedLodingWithTip:netErrorMessage subTip:@"点击重新加载"];
            callback(NO);
        } else {
            NSString *responseCode = getResponseCodeFromDic(response);
            if ([responseCode isEqualToString:ResponseCodeSuccess]) {
                [controller finishedLoding];
                NSArray *list = [MyCouponInfo objectArrayWithKeyValuesArray:response[@"data"]];
                [_dataSource removeAllObjects];
                [_dataSource addObjectsFromArray:list];
                callback(YES);
            } else {
                NSString *message = response[RESPONSE_MESSAGE];
                [controller finishedLodingWithTip:message subTip:@"点击重新加载"];
                callback(NO);
            }
            
        }
    }];

}

@end
