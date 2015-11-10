//
//  MySchoolViewModel.h
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/2.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BaseViewController.h"
#import "MySchoolInfo.h"

@interface MySchoolViewModel : NSObject

@property(nonatomic, retain)MySchoolInfo *mySchoolInfo;

/**
 *  我的驾考
 *
 *  @param controller 控制器
 *  @param callBack   回调
 */
- (void)getSchoolDetailFromSever:(BaseViewController *)controller
                        callBack:(void(^)(BOOL success))callBack;

/**
 *  评价驾校
 *
 *  @param drivingId      驾校ID
 *  @param scole          总分
 *  @param enScole        环境分
 *  @param prosceScole    前台服务
 *  @param drivingTrainer 教练服务
 *  @param comment        评论内容
 *  @param showName       是否匿名
 *  @param controller     控制器
 *  @param callBack       回调
 */
- (void)sendCommentToServer:(NSString *)drivingId
               drivingScole:(NSInteger)scole
                    enScole:(NSInteger)enScole
                prosceScole:(NSInteger)prosceScole
             drivingTrainer:(NSInteger)drivingTrainer
            driving_comment:(NSString *)comment
                 isShowName:(BOOL)showName
                 controller:(BaseViewController *)controller
                   callBack:(void(^)(BOOL success))callBack;



@end
