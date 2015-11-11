//
//  MyCouponInfo.h
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/11.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyCouponInfo : NSObject

@property (nonatomic, assign) NSInteger isUse;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, assign) long validityPeriod;

@property (nonatomic, assign) NSInteger couponPrice;

@property (nonatomic, copy) NSString *promoCode;

@property (nonatomic, copy) NSString *drivingName;

@end
