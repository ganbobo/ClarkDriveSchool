//
//  MySchoolViewModel.h
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/2.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BaseViewController.h"

@interface MySchoolViewModel : NSObject

/**
 *  我的驾考
 *
 *  @param controller 控制器
 *  @param callBack   回调
 */
- (void)getSchoolDetailFromSever:(BaseViewController *)controller
                        callBack:(void(^)(BOOL success))callBack;

@end
