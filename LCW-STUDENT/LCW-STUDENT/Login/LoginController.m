//
//  LoginController.m
//  LCW
//
//  Created by St.Pons.Mr.G on 15/8/29.
//  Copyright (c) 2015年 Clark. All rights reserved.
//

#import "LoginController.h"

#import "LoginViewModel.h"

@interface LoginController () {
    
    __weak IBOutlet UIButton *_btnGetCode;
    __weak IBOutlet UITextField *_txtUsername;
    __weak IBOutlet UITextField *_txtPassword;
    
    // 数据
    LoginViewModel *_loginViewModel;
}

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
    _loginViewModel = [[LoginViewModel alloc] init];
}

#pragma - mark 加载界面

- (void)loadNav {
    [PMCommon setNavigationTitle:self withTitle:@"登录"];
    [PMCommon setNavigationBarLeftButton:self withBtnNormalImg:[UIImage imageNamed:@"back_ico"] withAction:@selector(clickCancel)];
}

- (void)clickCancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)clickGetCode:(id)sender {
    [self.view endEditing:YES];
    NSString *username = _txtPassword.text;
    [_loginViewModel getCheckCodeFromSeverController:self username:username callBack:^(BOOL success) {
        if (success) {
            [_loginViewModel countTime:_btnGetCode totalTime:60];
        }
    }];
}

- (IBAction)clickLogin:(id)sender {
    [self.view endEditing:YES];
    
    if ([_loginViewModel checkInput:_txtUsername.text password:_txtPassword.text controller:self]) {
        if ([_loginViewModel validateCode:_txtPassword.text controller:self]) {
            [_loginViewModel loginToServerController:self username:_txtUsername.text pwd:_txtPassword.text callBack:^(BOOL success) {
                if (success) {
                    [self clickCancel];
                }
            }];
        }
    }
        
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event  {
    [self.view endEditing:YES];
}

@end
