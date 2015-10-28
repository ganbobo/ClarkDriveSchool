//
//  BaseViewController.h
//  Gtwy
//
//  Created by lion on 15/8/13.
//  Copyright (c) 2015年 lion. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PMCommon.h"

@interface BaseViewController : UIViewController

@property(nonatomic, assign)BOOL isFirstIn;// 是否是第一次进入

- (void)showMessageTip:(NSString *)message type:(MessageType)type;

- (void)showWaitView:(NSString*)tipMessage;
- (void)hiddenWaitView;
- (void)hiddenWaitViewWithTip:(NSString *)tip type:(MessageType)type;

//在屏幕中间显示
- (void)showMiddleToastWithContent:(NSString*)content;

@end
