//
//  ShopViewModel.m
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/10/26.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import "ShopViewModel.h"

#import "JsonUtils.h"
#import "AFNManager.h"
#import "ShopInfo.h"

@interface ShopViewModel () {
    NSMutableArray *_dataSource;
}

@end

@implementation ShopViewModel

- (instancetype)init {
    if (self = [super init]) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    
    return self;
}

/**
 *  获取驾校列表
 *
 *  @param userId     用户ID
 *  @param controller 控制器
 *  @param callBack   回调
 */

- (void)getShopListFromServer:(NSString *)userId controller:(BaseViewController *)controller callBack:(void (^)(BOOL success))callBack {
    NSDictionary *dic = @{
                          @"userId": userId,
                          };

    
    [[AFNManager sharedAFNManager] getServer:GET_SCHOOL_LIST_SERVER parameters:@{PARS_KEY: [dic JSONNSString]} callBack:^(NSDictionary *response, NSString *netErrorMessage) {
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
                NSArray *array = [ShopInfo objectArrayWithKeyValuesArray:response[@"data"][@"listDriving"]];
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

@end
