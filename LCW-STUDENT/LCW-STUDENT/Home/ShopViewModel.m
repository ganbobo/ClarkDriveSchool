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
 *  @param cityId     城市ID
 *  @param toDate     升序 asc 降序desc
 *  @param startPrice 其实金额
 *  @param endPrice   结束金额
 *  @param controller 控制器
 *  @param callBack   回调
 */

- (void)getShopListFromServer:(NSString *)cityId
                         date:(NSString *)toDate
                   startPrice:(CGFloat)startPrice
                     endPrice:(CGFloat)endPrice
                   controller:(BaseViewController *)controller
                     callBack:(void (^)(BOOL success))callBack {
    NSDictionary *dic = @{
                          @"userId": (hasUser() ? getUser().id : @"123"),
                          @"toDate": toDate,
                          @"startPrice": @(startPrice),
                          @"endPrice": @(endPrice),
                          @"c_id": cityId
                          };
    if (cityId.length <= 0) {
        dic = @{
              @"userId": (hasUser() ? getUser().id : @"123"),
              @"toDate": toDate,
              @"startPrice": @(startPrice),
              @"endPrice": @(endPrice)
              };
    }

    
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
