//
//  BlindIDController.m
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/3.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import "BlindIDController.h"

#import "SchoolViewModel.h"

@interface BlindIDController () {
    
    __weak IBOutlet UIView *_nameView;
    __weak IBOutlet UIView *_idView;
    __weak IBOutlet UITextField *_txtName;
    __weak IBOutlet UITextField *_txtId;
}

@end

@implementation BlindIDController

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
    [self loadInputViews];
}

#pragma - mark 界面加载

- (void)loadNav {
    [PMCommon setNavigationTitle:self withTitle:@"绑定身份证"];
}

- (void)loadInputViews {
    _nameView.layer.borderColor = RGBA(0xcc, 0xcc, 0xcc, 1).CGColor;
    _nameView.layer.borderWidth = 0.5;
    _idView.layer.borderColor = RGBA(0xcc, 0xcc, 0xcc, 1).CGColor;
    _idView.layer.borderWidth = 0.5;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (IBAction)clickSure:(id)sender {
    [self.view endEditing:YES];
    
    NSString *name = _txtName.text;
    NSString *identifier = _txtId.text;

    SchoolViewModel *viewModel = [[SchoolViewModel alloc] init];
    
    if ([viewModel checkUserInput:name identifier:identifier controller:self]) {
        [viewModel getCouponFromSever:self driveId:_driveId name:name identifier:identifier callBack:^(BOOL success) {
            
        }];
    }
}

@end
