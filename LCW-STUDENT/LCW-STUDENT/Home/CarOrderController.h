//
//  CarOrderController.h
//  LCW-STUDENT
//
//  Created by St.Pons.Mr.G on 15/9/10.
//  Copyright (c) 2015年 Clark. All rights reserved.
//

#import "BaseViewController.h"

/**
 *  约车
 */

@interface CarOrderInfo : NSObject

@property(nonatomic, assign)BOOL select;
@property(nonatomic, assign)NSInteger type;
@property(nonatomic, retain)NSString *titleName;

@end

@interface CarOrderController : BaseViewController

@end
