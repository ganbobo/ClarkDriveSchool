//
//  FeedBackController.m
//  LCW-STUDENT
//
//  Created by St.Pons.Mr.G on 15/9/4.
//  Copyright (c) 2015年 Clark. All rights reserved.
//

#import "FeedBackController.h"

@interface FeedBackController () {
    UIView *_inputBackView;
    UIButton *_btnSubmit, *_btnService;
}

@end

@implementation FeedBackController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNav];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTintColor:RGBA(0x11, 0xcd, 0x6e, 1)];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBarTintColor:RGBA(0x40, 0x40, 0x40, 1)];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView {
    [super loadView];
    [self loadInputViews];
}

- (void)loadInputViews {
    _inputBackView = [[UIView alloc] init];
    [_inputBackView setTranslatesAutoresizingMaskIntoConstraints:NO];
    _inputBackView.layer.borderColor = RGBA(0xcc, 0xcc, 0xcc, 1).CGColor;
    _inputBackView.layer.borderWidth = 0.5;
    [self.view addSubview:_inputBackView];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[I]-10-|" options:0 metrics:nil views:@{@"I": _inputBackView}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-84-[I(150)]" options:0 metrics:nil views:@{@"I": _inputBackView}]];
    
    _btnSubmit = [UIButton new];
    [_btnSubmit setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_btnSubmit setBackgroundImage:[UIImage imageNamed:@"btn_common"] forState:UIControlStateNormal];
    [_btnSubmit setTitleColor:RGBA(0xff, 0xff, 0xff, 1) forState:UIControlStateNormal];
    [_btnSubmit setTitle:@"提交" forState:UIControlStateNormal];
    _btnSubmit.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    _btnSubmit.layer.cornerRadius = 2;
    _btnSubmit.layer.masksToBounds = YES;
    [self.view addSubview:_btnSubmit];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[S]-10-|" options:0 metrics:nil views:@{@"S": _btnSubmit}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[I]-20-[S(40)]" options:0 metrics:nil views:@{@"I": _inputBackView, @"S": _btnSubmit}]];
    
    _btnService = [UIButton new];
    [_btnService setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_btnService setBackgroundImage:[UIImage imageNamed:@"btn_common"] forState:UIControlStateNormal];
    [_btnService setTitleColor:RGBA(0xff, 0xff, 0xff, 1) forState:UIControlStateNormal];
    [_btnService setTitle:@"呼叫客服" forState:UIControlStateNormal];
    _btnService.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    _btnService.layer.cornerRadius = 2;
    _btnService.layer.masksToBounds = YES;
    [self.view addSubview:_btnService];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-90-[SV]-90-|" options:0 metrics:nil views:@{@"SV": _btnService}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[S]-60-[SV(40)]" options:0 metrics:nil views:@{@"SV": _btnService, @"S": _btnSubmit}]];
}

#pragma - mark 加载界面

- (void)loadNav {
    self.title = @"意见反馈";
    [PMCommon setNavigationBarLeftButton:self withBtnNormalImg:[UIImage imageNamed:@"nav_close"] withAction:@selector(clickClose)];
}

#pragma - mark 导航按钮点击触发

- (void)clickClose {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
