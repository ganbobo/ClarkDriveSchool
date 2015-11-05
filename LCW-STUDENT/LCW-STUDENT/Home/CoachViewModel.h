//
//  CoachViewModel.h
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/5.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BaseViewController.h"

@interface CoachViewModel : NSObject

@property(nonatomic, retain)NSMutableArray *coachList;

/**
 *  获取教练列表
 *
 *  @param subjectId       科目ID
 *  @param sex             性别
 *  @param typeName        驾照类型
 *  @param overplusTrainee 热度
 *  @param controller      控制器
 *  @param callBack        回调
 */
- (void)getCoachListFromServer:(NSString *)subjectId
                           sex:(NSString *)sex
                      typeName:(NSString *)typeName
               overplusTrainee:(NSString *)overplusTrainee
                    controller:(BaseViewController *)controller
                      callBack:(void(^)(BOOL success))callBack;

/**
 *  获取教练详情
 *
 *  @param trainerId  教练ID
 *  @param controller 控制器
 *  @param callBack   回调
 */
- (void)getCoachDetailInfoFromServer:(NSString *)trainerId
                          controller:(BaseViewController *)controller
                            callBack:(void(^)(BOOL success))callBack;

/**
 *  绑定教练
 *
 *  @param trainerId  教练ID
 *  @param subjectId  科目ID
 *  @param controller 控制器
 *  @param callBack   回调
 */
- (void)blindCoachToServer:(NSString *)trainerId
                 subjectId:(NSString *)subjectId
                controller:(BaseViewController *)controller
                  callBack:(void(^)(BOOL success))callBack;

@end
