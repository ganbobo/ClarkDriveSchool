//
//  CarOrderViewModel.h
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/10/28.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BaseViewController.h"

@interface CarOrderViewModel : NSObject

@property(nonatomic, retain)NSMutableArray *dataSource;
@property(nonatomic, retain)NSMutableArray *coachList;
@property(nonatomic, retain)NSMutableArray *timeList;

/**
 *  获取科目列表
 *
 *  @param userId     用户ID
 *  @param controller 控制器
 *  @param callBack   回调
 */

- (void)getSubjectListFromServer:(NSString *)userId
                      controller:(BaseViewController *)controller
                        callBack:(void (^)(BOOL success))callBack;

/**
 *  获取科目教练
 *
 *  @param subjectId  科目ID
 *  @param controller 控制器
 *  @param callBack   回调
 */
- (void)getCoachListFromServer:(NSString *)subjectId
                      controller:(BaseViewController *)controller
                        callBack:(void (^)(BOOL success))callBack;

/**
 *  获取时间
 *
 *  @param controller 控制器
 *  @param callBack   回调
 */
- (void)getTimeListFromServerController:(BaseViewController *)controller
                               callBack:(void (^)(BOOL success))callBack;

/**
 *  获取教练当天发布课程
 *
 *  @param trainerId   教练ID
 *  @param publishTime 发布时间
 *  @param controller  控制器
 *  @param callBack    回调
 */
- (void)getCourseListFromServer:(NSString *)trainerId
                    publishTime:(long)time
                     controller:(BaseViewController *)controller
                       callBack:(void (^)(BOOL success))callBack;

@end
