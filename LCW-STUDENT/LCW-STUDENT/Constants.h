//
//  Constants.h
//  Gtwy
//
//  Created by lion on 15/8/13.
//  Copyright (c) 2015年 lion. All rights reserved.
//

/**
 *  常量方法与常量定义
 */


#ifndef Gtwy_Constants_h
#define Gtwy_Constants_h

// 系统日志打印屏蔽宏---控制
#ifdef DEBUG
#define CLog(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define CLog(format, ...)
#endif

//获取设备的物理高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

//获取设备的物理宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

//获取状态栏的物理高度
#define StatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height

#define NavBarHeight   44

//颜色和透明度设置
#define RGBA(r,g,b,a)  [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:a]

//ios7版本判断宏
#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

//ios4
#define IOS4 ([[[UIDevice currentDevice] systemVersion] floatValue] < 5.0)

//判断是否是IPHONE5的宏，用法是 if(IPHONE) xxxx else xxxxx
#define IPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define IPHONE6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define IPHONE6PLUS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

// 声明单件类的类方法
#define DECLARE_SINGLETON_FOR_CLASS(classname) \
+ (classname*)shared##classname;

// 获取单件实例的宏定义
#define GET_SINGLETON_FOR_CLASS(classname) \
[classname shared##classname]

// 合成单列类
#define SYNTHESIZE_SINGLETON_FOR_CLASS(classname) \
\
static classname *shared##classname = nil; \
\
+ (classname *)shared##classname \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [[self alloc] init]; \
} \
} \
\
return shared##classname; \
} \
\

//国际化资源文件名,注：不需要加后缀名
#define LocalizdFileName @"Localizable"
//新增国际化宏
#define NSLocalizedStringEx(key, comment) \
[[NSBundle mainBundle] localizedStringForKey:(key) value:@"" table:LocalizdFileName]

#define DBNAME @"database.sqlite"

#define kFirstPage  1


#endif
