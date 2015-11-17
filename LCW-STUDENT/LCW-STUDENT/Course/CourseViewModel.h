//
//  CourseViewModel.h
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/17.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BaseViewController.h"

@interface CourseViewModel : NSObject

@property(nonatomic, retain)NSMutableArray *dataSource;

/**
 *  获取课程列表
 *
 *  @param controller 控制器
 *  @param callBack   回调
 */
- (void)getCourseList:(BaseViewController *)controller
             callBack:(void(^)(BOOL success))callBack;

/**
 *  取消约车
 *
 *  @param userId     学员ID
 *  @param userDayId  约车记录ID
 *  @param recordTime 约车时间戳
 *  @param controller 控制器
 *  @param callBack   回调
 */
- (void)cancelOrderCar:(NSString *)userId
             userDayId:(NSString *)userDayId
            recordTime:(NSString *)recordTime
            controller:(BaseViewController *)controller
              callBack:(void(^)(BOOL success))callBack;

@end
