//
//  LoginController.m
//  LCW
//
//  Created by St.Pons.Mr.G on 15/8/29.
//  Copyright (c) 2015年 Clark. All rights reserved.
//

#import "LoginController.h"

@interface LoginController ()

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadNav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView {
    [super loadView];
    
}

#pragma - mark 加载界面

- (void)loadNav {
    [PMCommon setNavigationTitle:self withTitle:@"登录"];
    [PMCommon setNavigationBarLeftButton:self withBtnNormalImg:[UIImage imageNamed:@"back_ico"] withAction:@selector(clickCancel)];
}

- (void)clickCancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
