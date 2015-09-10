//
//  PMCommon.h
//
//  Created by apple on 14-4-18.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PMCommon : NSObject

//自定义左边按钮
+ (void)setNavigationBarLeftButton:(UIViewController *)viewController withBtnNormalImg:(UIImage *)normalImage withAction:(SEL)action;
//自定义右边按钮
+ (void)setNavigationBarRightButton:(UIViewController *)viewController withBtnNormalImg:(UIImage *)normalImage withAction:(SEL)action;

//自定义右边按钮(两个按钮)
+ (void)setNavigationBarRightButtons:(UIViewController *)viewController
                 withBtnNormalImgOne:(UIImage *)normalImage1
                   withBtnPresImgOne:(UIImage *)pressImage1
                 withBtnNormalImgTwo:(UIImage *)normalImage2
                   withBtnPresImgTwo:(UIImage *)pressImage2
                        withTitleOne:(NSString *) title1
                        withTitleTwo:(NSString *)title2
                       withActionOne:(SEL)action1
                       withActionTwo:(SEL)action2;

//navigation 标题设置
+ (void)setNavigationTitle:(UIViewController *) viewController
                 withTitle:(NSString *) title;

//navigation 设置图片标题
+ (void)setNavigationTitle:(UIViewController *)viewController withTitle:(NSString *)title withImages:(UIImage*) image action:(SEL) action;

+ (void)setNavigationRight:(UIViewController *)viewController title:(NSString *)title  action:(SEL) action;

+ (void)setNavigationLeft:(UIViewController *)viewController title:(NSString *)title  action:(SEL) action;

@end
