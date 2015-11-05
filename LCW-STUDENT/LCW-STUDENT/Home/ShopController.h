//
//  ShopController.h
//  LCW
//
//  Created by St.Pons.Mr.G on 15/8/29.
//  Copyright (c) 2015年 Clark. All rights reserved.
//

#import "BaseViewController.h"

@interface FilterInfo : NSObject

@property(nonatomic, assign)CGFloat startPrice;
@property(nonatomic, assign)CGFloat endPrice;
@property(nonatomic, retain)NSString *cityId;
@property(nonatomic, retain)NSString *toDate;

@end

@interface ShopController : BaseViewController

@property(nonatomic, assign)BOOL hasSignUp;// 是否报名

@end
