//
//  ShopInfo.h
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/10/26.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopInfo : NSObject


@property (nonatomic, copy) NSString *driving_name;

@property (nonatomic, copy) NSString *longitude;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, assign) NSInteger driving_price;

@property (nonatomic, assign) NSInteger level;

@property (nonatomic, copy) NSString *driving_addr;

@property (nonatomic, copy) NSString *latitude;

@property (nonatomic, assign) NSInteger coupon_price;

@property (nonatomic, copy) NSString *tel;

@property (nonatomic, assign) NSInteger scole;

@property (nonatomic, copy) NSString *resource_url;

@property (nonatomic, assign) double distance;


@end
