//
//  WaitingView.m
//  Gtwy
//
//  Created by St.Pons.Mr.G on 15/8/20.
//  Copyright (c) 2015年 lion. All rights reserved.
//

#import "WaitingView.h"

#import "MMMaterialDesignSpinner.h"

@interface WaitingView () {
    UIView *_coverView;
    UIImageView *_resultView;
    UILabel *_lblTip;
    MMMaterialDesignSpinner *_spinnerView;
    
}

@end

@implementation WaitingView

- (instancetype)init {
    self = [super initWithFrame:appDelegate.window.bounds];
    if (self) {
        [self initViews];
    }
    
    return self;
}

- (void)initViews {
    _coverView = [[UIView alloc] initWithFrame:CGRectMake((ScreenWidth - 150) / 2.0, (ScreenHeight - 150) / 2.0, 150, 150)];
    _coverView.backgroundColor = [UIColor whiteColor];
    _coverView.layer.borderColor = RGBA(0xcc, 0xcc, 0xcc, 1).CGColor;
    _coverView.layer.borderWidth = 0.5;
    _coverView.layer.cornerRadius = 5;
    [self addSubview:_coverView];
    
    _spinnerView = [[MMMaterialDesignSpinner alloc] initWithFrame:CGRectMake((_coverView.width - 45) / 2.0, 30, 45, 45)];
    _spinnerView.backgroundColor = [UIColor clearColor];
    _spinnerView.tintColor = RGBA(0x01, 0xc7, 0xff, 1);
    [_spinnerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_coverView addSubview:_spinnerView];
    
    _resultView = [[UIImageView alloc] initWithFrame:_spinnerView.frame];
    _resultView.hidden = YES;
    [_coverView addSubview:_resultView];
    
    
    _lblTip = [[UILabel alloc] initWithFrame:CGRectMake(10, _coverView.height - 50, _coverView.width - 20, 35)];
    _lblTip.backgroundColor = [UIColor clearColor];
    _lblTip.textColor = RGBA(0x32, 0x32, 0x32, 1);
    _lblTip.textAlignment = NSTextAlignmentCenter;
    _lblTip.numberOfLines = 0;
    _lblTip.font = [UIFont systemFontOfSize:14];
    [_coverView addSubview:_lblTip];
}

/**
 *  显示等待视图
 *
 *  @param tips 文字
 */
- (void)showWaitinViewWithTips:(NSString *)tips {
    _coverView.alpha = 1;
    [_spinnerView startAnimating];
    _lblTip.text = tips;
    _resultView.hidden = YES;
    
    [appDelegate.window addSubview:self];
}

/**
 *  隐藏视图，显示提示
 *
 *  @param tips 提示
 *  @param type 提示类型
 */
- (void)hiddenWaitingViewWithTips:(NSString *)tips messageType:(MessageType)type {
    _resultView.hidden = NO;
    _lblTip.text = tips;
    [_spinnerView stopAnimating];
    switch (type) {
        case MessageSuccess: {
            _resultView.image = [UIImage imageNamed:@"com_success"];
            [self performSelector:@selector(hiddenWaitingViewAnimation) withObject:nil afterDelay:1];
        }
            break;
        case MessageFailed: {
            _resultView.image = [UIImage imageNamed:@"com_failed"];
            [self performSelector:@selector(hiddenWaitingViewAnimation) withObject:nil afterDelay:1];
        }
            break;
        case MessageWarning: {
            _resultView.image = [UIImage imageNamed:@"com_warning"];
            [self performSelector:@selector(hiddenWaitingViewAnimation) withObject:nil afterDelay:1];
        }
            break;
        default:
            [self hiddenWaitingView];
            break;
    }
}

/**
 *  直接隐藏等待视图
 */
- (void)hiddenWaitingView {
    [_spinnerView stopAnimating];
    [self hiddenWaitingViewWithAnimation:NO];
}

/**
 *  带动画的隐藏
 */
- (void)hiddenWaitingViewAnimation {
    [_spinnerView stopAnimating];
    [self hiddenWaitingViewWithAnimation:YES];
}

/**
 *  隐藏等待视图，是否需要动画
 *
 *  @param animation 是否开启动画
 */
- (void)hiddenWaitingViewWithAnimation:(BOOL)animation {
    if (animation) {
        [UIView animateWithDuration:0.5 animations:^{
            _coverView.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    } else {
        [self removeFromSuperview];
    }
}

@end
