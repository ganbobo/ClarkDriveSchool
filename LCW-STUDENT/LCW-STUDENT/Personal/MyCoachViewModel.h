//
//  MyCoachViewModel.h
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/2.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BaseViewController.h"

@interface MyCoachViewModel : NSObject

@property(nonatomic, retain)NSMutableArray *coachList;

/**
 *  我的教练
 *
 *  @param controller 控制器
 *  @param callBack   回调
 */
- (void)getMyCoachFromSever:(BaseViewController *)controller
                   callBack:(void(^)(BOOL success))callBack;


@end
