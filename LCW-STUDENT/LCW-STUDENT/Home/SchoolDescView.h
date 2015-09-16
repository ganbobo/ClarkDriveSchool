//
//  SchoolDescView.h
//  LCW-STUDENT
//
//  Created by St.Pons.Mr.G on 15/9/16.
//  Copyright (c) 2015年 Clark. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kTEXT_COLOR_KEY @"textColor"
#define kTEXT_ARRAY_KEY @"textArray"

@interface SchoolDescView : UIView

/**
 *  初始化表格详情内容
 *
 *  @param width     宽度
 *  @param originalY 起始坐标
 *  @param columns   表格列数
 *
 *  @return 返回详情内容视图
 */
- (instancetype)initWithWidth:(CGFloat)width
                    originalY:(CGFloat)originalY
                      columns:(NSInteger)columns;

/**
 *  设置展示的内容
 *
 *  @param array 数组，格式为@[@[@"1", @"2"], @[@"3", @"4"]]
 */
- (void)setDataSource:(NSArray *)array title:(NSString *)title;

@end
