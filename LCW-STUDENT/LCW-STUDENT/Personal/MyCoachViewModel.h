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

/**
 *  注销登录
 *
 *  @param controller 控制器
 *  @param callBack   回调
 */
- (void)logoutToServer:(BaseViewController *)controller
              callBack:(void(^)(BOOL success))callBack;

/**
 *  评价教练
 *
 *  @param trainerId      教练ID
 *  @param scole          总体评分
 *  @param attitude       教学态度
 *  @param ablility       教学能力
 *  @param environment    车内环境
 *  @param comment        评论
 *  @param showName       是否匿名
 *  @param controller     控制器
 *  @param callBack       回调
 */
- (void)sendCoachCommentToServer:(NSString *)trainerId
                           scole:(NSInteger)scole
                        attitude:(NSInteger)attitude
                        ablility:(NSInteger)ablility
                     environment:(NSInteger)environment
                         comment:(NSString *)comment
                      isShowName:(BOOL)showName
                      controller:(BaseViewController *)controller
                        callBack:(void(^)(BOOL success))callBack;


@end
