//
//  RegisterController.m
//  LCW-STUDENT
//
//  Created by St.Pons.Mr.G on 15/8/31.
//  Copyright (c) 2015年 Clark. All rights reserved.
//

#import "RegisterController.h"

@interface RegisterController ()

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
    [self loadNav];
}

#pragma - mark 加载界面

- (void)loadNav {
    [PMCommon setNavigationTitle:self withTitle:@"注册"];
}

- (IBAction)clickGoLogin:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
