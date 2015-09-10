//
//  CouponController.m
//  LCW-STUDENT
//
//  Created by St.Pons.Mr.G on 15/9/10.
//  Copyright (c) 2015年 Clark. All rights reserved.
//

#import "CouponController.h"

#import "ShopController.h"

@interface CouponController ()

@end

@implementation CouponController

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
    [PMCommon setNavigationTitle:self withTitle:@"优惠码"];
}

#pragma - mark 按钮点击事件

- (IBAction)clickSeeOtherSchool:(id)sender {
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[ShopController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
            return;
        }
    }
}

@end
