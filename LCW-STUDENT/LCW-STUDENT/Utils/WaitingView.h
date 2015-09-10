//
//  WaitingView.h
//  Gtwy
//
//  Created by St.Pons.Mr.G on 15/8/20.
//  Copyright (c) 2015年 lion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaitingView : UIView

/**
 *  显示等待视图
 *
 *  @param tips 文字
 */
- (void)showWaitinViewWithTips:(NSString *)tips;
/**
 *  隐藏视图，显示提示
 *
 *  @param tips 提示
 *  @param type 提示类型
 */
- (void)hiddenWaitingViewWithTips:(NSString *)tips messageType:(MessageType)type;
/**
 *  直接隐藏等待视图
 */
- (void)hiddenWaitingView;

@end
