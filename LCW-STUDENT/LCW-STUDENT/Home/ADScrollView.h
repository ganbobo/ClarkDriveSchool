//
//  ADScrollView.h
//  
//
//  Created by St.Pons Mr.G on 14/11/20.
//  Copyright (c) 2014年 St.Pons Mr.G. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  首页广告视图类
 */

@protocol ADScrollViewDelegate <NSObject>

@optional
- (void)scrollToPageIndex:(NSInteger)pageIndex;

@end

@interface ADScrollView : UIView

@property(nonatomic, assign)id<ADScrollViewDelegate> delegate;

- (void)addViewFromList:(NSArray *)list;

- (void)setMessage:(NSString *)message;

/**
 *  跳转到第一页
 */

- (void)resetFirstPage;

@end
