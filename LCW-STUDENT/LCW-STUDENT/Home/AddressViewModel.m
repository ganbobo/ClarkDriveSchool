//
//  AddressViewModel.m
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/1.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import "AddressViewModel.h"

#import "AFNManager.h"
#import "AddressModel.h"
#import "JSONKit.h"
#import "LocationManager.h"

@interface AddressViewModel () {
    
}
@end

@implementation AddressViewModel

SYNTHESIZE_SINGLETON_FOR_CLASS(AddressViewModel);

- (instancetype)init
{
    self = [super init];
    if (self) {
        _addressDic = [[NSMutableDictionary alloc] init];
        _wordSortArray = [[NSMutableArray alloc] init];
        _arrayDataSource = [[NSMutableArray alloc] init];
    }
    return self;
}

/**
 *  获取地址列表
 *
 *  @param controller 控制器
 *  @param callBack   回调
 */
- (void)getAddressDicFromServer:(BaseViewController *)controller
                       callBack:(void(^)(BOOL success))callBack {
    NSDictionary *param = @{
                            @"userId": (hasUser() ? getUser().id : @"123"),
                            @"queryCheck": @""
                            };
    [[AFNManager sharedAFNManager] getServer:ADDRESS_LIST_SERVER parameters:@{PARS_KEY: [param JSONString]} callBack:^(NSDictionary *response, NSString *netErrorMessage) {
        if (netErrorMessage) {
            if (_addressDic.count <= 0) {
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
                NSArray *array = [AddressModel objectArrayWithKeyValuesArray:response[@"data"][@"lists"]];
                [_arrayDataSource removeAllObjects];
                [_arrayDataSource addObjectsFromArray:array];
                [self setDataSource:array];
                callBack(YES);
            } else {
                NSString *message = response[RESPONSE_MESSAGE];
                if (_addressDic.count <= 0) {
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

- (void)setDataSource:(NSArray *)list {
    [_addressDic removeAllObjects];
    [_wordSortArray removeAllObjects];
    
    NSString *key = @"#";
    [_wordSortArray addObject:key];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:[LocationManager sharedLocationManager].currentAddressInfo];
    [_addressDic setValue:array forKey:key];
    
    for (AddressModel *addressModel in list) {
        NSString *key = addressModel.c_letter;
        NSMutableArray *array = _addressDic[key];
        if (!array) {
            [_wordSortArray addObject:key];
            array = [[NSMutableArray alloc] init];
            [array addObject:addressModel];
            [_addressDic setValue:array forKey:key];
        } else {
            [array addObject:addressModel];
        }
    }
    
}

@end
