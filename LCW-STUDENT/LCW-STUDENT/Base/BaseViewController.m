//
//  BaseViewController.m
//  Gtwy
//
//  Created by lion on 15/8/13.
//  Copyright (c) 2015年 lion. All rights reserved.
//

#import "BaseViewController.h"

#import "CNotificationManager.h"
#import "WaitingView.h"
#import "iToast.h"
#import "GFPlaceholderView.h"

#define DEF_SCREEN_MASK_VIEW_TAG    100111

@interface BaseViewController () {
    GFPlaceholderView *_placeholderView;
}

@end

@implementation BaseViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _isFirstIn = YES;
    
    if (self.navigationController.viewControllers.count > 1) {
        [PMCommon setNavigationBarLeftButton:self withBtnNormalImg:[UIImage imageNamed:@"back_ico"] withAction:@selector(goBack)];
    }
}

- (void)loadView {
    [super loadView];
    _placeholderView = [[GFPlaceholderView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [_placeholderView showLoadingView];
    [self.view addSubview:_placeholderView];
    [_placeholderView hide];

    self.view.backgroundColor = RGBA(0xff, 0xff, 0xff, 1);
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    _isFirstIn = NO;
}

- (void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showMessageTip:(NSString *)message type:(MessageType)type {
    [self hiddenWaitView];
    UIColor *color;
    switch (type) {
        case MessageFailed: {
            color = [UIColor colorWithRed:1.000 green:0.389 blue:0.410 alpha:1.000];//ef4136
        }
            break;
        case MessageSuccess: {
            color = [UIColor colorWithRed:0.271 green:0.769 blue:0.298 alpha:1.000];//1d953f
        }
            break;
        case MessageWarning: {
            color = RGBA(0xff, 0xc1, 0x07, 1);
        }
            break;
        default:
            break;
    }
    [CNotificationManager showMessage:message withOptions:@{CN_TEXT_COLOR_KEY:[UIColor whiteColor],CN_BACKGROUND_COLOR_KEY:color}];
}

#pragma - mark 显示等待视图

- (void)showWaitView:(NSString*)tipMessage {
    WaitingView *screenView = (WaitingView *)[appDelegate.window viewWithTag:DEF_SCREEN_MASK_VIEW_TAG];
    if (!screenView) {
        screenView = [[WaitingView alloc] init];
        screenView.backgroundColor = [UIColor clearColor];
        screenView.tag = DEF_SCREEN_MASK_VIEW_TAG;
    }
    
    [screenView showWaitinViewWithTips:tipMessage];
    
    [self performSelector:@selector(overTimeRuquest) withObject:nil afterDelay:kRequestOverTime];
}

- (void)overTimeRuquest {
    [self hiddenWaitViewWithTip:NSLocalizedStringEx(@"SeverTimeoutTip", nil) type:MessageWarning];
}

- (void)hiddenWaitView {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(overTimeRuquest) object:nil];
    WaitingView *screenView = (WaitingView *)[appDelegate.window viewWithTag:DEF_SCREEN_MASK_VIEW_TAG];
    if (screenView) {
        [screenView hiddenWaitingView];
    }
}


- (void)hiddenWaitViewWithTip:(NSString *)tip type:(MessageType)type {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(overTimeRuquest) object:nil];
    WaitingView *screenView = (WaitingView *)[appDelegate.window viewWithTag:DEF_SCREEN_MASK_VIEW_TAG];
    if (screenView) {
        [screenView hiddenWaitingViewWithTips:tip messageType:type];
    }
}

//在屏幕中间显示
- (void)showMiddleToastWithContent:(NSString*)content {
    iToast* phoneInfo = [iToast makeText:content];
    [phoneInfo setGravity:iToastGravityCenter];
    [phoneInfo show];
}

#pragma - mark 显示加载和加载失败的视图

- (void)showLoading:(void(^)(void))tapReLoading {
    _placeholderView.tapBlock = tapReLoading;
    [_placeholderView showLoadingView];
}

- (void)finishedLoding {
    [_placeholderView hide];
}

- (void)finishedLodingWithTip:(NSString *)tip subTip:(NSString *)subTip {
    [_placeholderView showViewWithTitle:tip andSubtitle:subTip];
}

- (void)finishedLodingWithTip:(NSString *)tip {
    [_placeholderView showViewWithTitle:tip andSubtitle:@""];
}


@end
