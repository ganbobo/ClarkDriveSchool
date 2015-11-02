//
//  FeedBackViewModel.h
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/1.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BaseViewController.h"

@interface FeedBackViewModel : NSObject

/**
 *  意见反馈
 *
 *  @param controller 控制器
 *  @param msg        反馈意见
 *  @param callBack   回调
 */
- (void)sendFeedbackToServerController:(BaseViewController *)controller
                                   msg:(NSString *)msg
                              callBack:(void (^)(BOOL success))callBack;

@end
