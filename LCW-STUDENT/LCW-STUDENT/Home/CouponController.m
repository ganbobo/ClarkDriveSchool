//
//  CouponController.m
//  LCW-STUDENT
//
//  Created by St.Pons.Mr.G on 15/9/10.
//  Copyright (c) 2015年 Clark. All rights reserved.
//

#import "CouponController.h"

#import "ShopController.h"

@interface CouponController () {
    
    __weak IBOutlet UILabel *_lblPrice;
    __weak IBOutlet UILabel *_lblCouponId;
    __weak IBOutlet UILabel *_lblTip;
    __weak IBOutlet UIButton *_btnOther;
}

@end

@implementation CouponController

+ (CouponController *)getCouponController {
    CouponController *controller = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"CouponController"];
    
    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (_couponInfo) {
        _lblPrice.text = [NSString stringWithFormat:@"%ld元", (long)_couponInfo.couponPrice];
        _lblCouponId.text = [NSString stringWithFormat:@"券码：%@", _couponInfo.promoCode];
        _lblTip.text = [NSString stringWithFormat:@"去驾校报名时，请将优惠码直接出示给前台，立减%ld元", (long)_couponInfo.couponPrice];
        _btnOther.hidden = YES;
    } else {
        _lblPrice.text = [NSString stringWithFormat:@"%ld元", (long)_drivingInfo.couponPrice];
        _lblCouponId.text = [NSString stringWithFormat:@"券码：%@", getUser().identification];
        _lblTip.text = [NSString stringWithFormat:@"去驾校报名时，请将优惠码直接出示给前台，立减%ld元", (long)_drivingInfo.couponPrice];
        _btnOther.hidden = NO;
    }
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
