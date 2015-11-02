//
//  SchoolViewModel.h
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/2.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BaseViewController.h"
#import "SchoolDetailInfo.h"

@interface SchoolViewModel : NSObject


@property(nonatomic, retain)SchoolDetailInfo *schoolDetailInfo;

/**
 *  驾校详情
 *
 *  @param controller 控制器
 *  @param driveId    驾校ID
 *  @param callBack   回调
 */
- (void)getSchoolDetailFromSever:(BaseViewController *)controller
                         driveId:(NSString *)driveId
                        callBack:(void(^)(BOOL success))callBack;

@end
