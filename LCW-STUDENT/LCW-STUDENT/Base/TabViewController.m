//
//  TabViewController.m
//  Gtwy
//
//  Created by lion on 15/8/13.
//  Copyright (c) 2015年 lion. All rights reserved.
//

#import "TabViewController.h"

#import "BaseNavController.h"

@interface TabViewController ()<UITabBarControllerDelegate>

@end

@implementation TabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView {
    [super loadView];
    self.delegate = self;
    [self loadViewControllers];
}

#pragma - mark 加载子视图控制器

// 加载子视图和tabbar按钮
- (void)loadViewControllers {
    BaseNavController *homeNav = [UIStoryboard storyboardWithName:@"Home" bundle:nil].instantiateInitialViewController;
    BaseNavController *courseNav = [UIStoryboard storyboardWithName:@"Course" bundle:nil].instantiateInitialViewController;
    BaseNavController *personalNav = [UIStoryboard storyboardWithName:@"Personal" bundle:nil].instantiateInitialViewController;
    
    [self.tabBar setTintColor:RGBA(0x11, 0xcd, 0x6e, 1)];
    [self.tabBar setBackgroundImage:[[UIImage imageNamed:@"comm_tabbar_background.jpg"] stretchableImageWithLeftCapWidth:6 / 2.0 topCapHeight:38 / 2.0]];
    // 添加底部切换
    UITabBarItem *homeItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedStringEx(@"首页", nil) image:[[UIImage imageNamed:@"tab_home_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tab_home_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    homeNav.tabBarItem = homeItem;
    
    UITabBarItem *courseItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedStringEx(@"课程", nil) image:[[UIImage imageNamed:@"tab_course_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tab_course_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    courseNav.tabBarItem = courseItem;
    
    UITabBarItem *personalItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedStringEx(@"我的", nil) image:[[UIImage imageNamed:@"tab_personal_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tab_personal_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    personalNav.tabBarItem = personalItem;
    
    self.viewControllers = @[homeNav, courseNav, personalNav];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    return YES;
}

@end
