//
//  RegisterController.m
//  LCW-STUDENT
//
//  Created by St.Pons.Mr.G on 15/8/31.
//  Copyright (c) 2015年 Clark. All rights reserved.
//

#import "RegisterController.h"

#import "RegisterViewModel.h"

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
    
}

@end
