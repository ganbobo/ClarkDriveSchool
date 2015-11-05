//
//  RegisterController.m
//  LCW-STUDENT
//
//  Created by St.Pons.Mr.G on 15/8/31.
//  Copyright (c) 2015年 Clark. All rights reserved.
//

#import "RegisterController.h"

#import "RegisterViewModel.h"
#import "LoginViewModel.h"

@interface RegisterController () {
    
    __weak IBOutlet UITextField *_txtUsername;
    __weak IBOutlet UITextField *_txtPassword;
    __weak IBOutlet UITextField *_txtCheckCode;
    __weak IBOutlet UIButton *_btnGetCode;
    __weak IBOutlet UIButton *_btnLogin;
    
    // 数据管理
    RegisterViewModel *_registerViewModel;
}

@end

@implementation RegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView {
    [super loadView];
    _registerViewModel = [[RegisterViewModel alloc] init];
    [self loadNav];
}

#pragma - mark 加载界面

- (void)loadNav {
    [PMCommon setNavigationTitle:self withTitle:@"注册"];
}

- (IBAction)clickGoLogin:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)clickGetCode:(id)sender {
    NSString *username = _txtUsername.text;
    [_registerViewModel getCheckCodeFromSeverController:self username:username callBack:^(BOOL success) {
        if (success) {
            [_registerViewModel countTime:_btnGetCode totalTime:60];
        }
    }];
}

- (IBAction)clickRegister:(id)sender {
    __weak typeof(self) safeSelf = self;
    // 验证验证码成功发起注册请求
    if ([_registerViewModel validateCode:_txtCheckCode.text controller:self]) {
        [_registerViewModel registerAccountController:self username:_txtUsername.text pwd:_txtPassword.text callBack:^(BOOL success) {
            if (success) {
                [safeSelf loginToSever:_txtUsername.text password:_txtPassword.text];
            }
        }];
    }
}

- (void)loginToSever:(NSString *)username password:(NSString *)password {
    LoginViewModel *viewModel = [[LoginViewModel alloc] init];
    [viewModel loginToServerController:self username:username pwd:password callBack:^(BOOL success) {
        if (success) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

@end
