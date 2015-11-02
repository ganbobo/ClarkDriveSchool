//
//  SchoolDetailController.h
//  LCW-STUDENT
//
//  Created by St.Pons.Mr.G on 15/9/7.
//  Copyright (c) 2015年 Clark. All rights reserved.
//

#import "BaseViewController.h"

#import "ShopInfo.h"

@interface SchoolDetailController : BaseViewController

@property(nonatomic, assign)BOOL hasSignUp;// 是否报名

@property(nonatomic, retain)ShopInfo *shopInfo;

@end
