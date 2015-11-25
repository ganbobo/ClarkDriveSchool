//
//  CouponController.h
//  LCW-STUDENT
//
//  Created by St.Pons.Mr.G on 15/9/10.
//  Copyright (c) 2015年 Clark. All rights reserved.
//

#import "BaseViewController.h"

#import "MyCouponInfo.h"
#import "SchoolDetailInfo.h"

@interface CouponController : BaseViewController

@property(nonatomic, retain)MyCouponInfo *couponInfo;
@property(nonatomic, retain)DrivingInfo *drivingInfo;


+ (CouponController *)getCouponController;

@end
