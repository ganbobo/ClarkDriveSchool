//
//  EditViewModel.h
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/5.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BaseViewController.h"

@interface EditViewModel : NSObject

/**
 *  修改昵称
 *
 *  @param name       姓名
 *  @param controller 控制器
 *  @param callBack   回调
 */
- (void)updateNameToServer:(NSString *)name
                controller:(BaseViewController *)controller
                  callBacl:(void(^)(BOOL success))callBack;

/**
 *  修改身份证
 *
 *  @param license    身份证号
 *  @param controller 控制器
 *  @param callBack   回调
 */
- (void)updateLicenseToServer:(NSString *)license
                   controller:(BaseViewController *)controller
                     callBacl:(void(^)(BOOL success))callBack;

@end
