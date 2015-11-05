//
//  EditDataController.m
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/5.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import "EditDataController.h"

#import "EditViewModel.h"

@interface EditDataController () {
    
    __weak IBOutlet UILabel *_lblTip;
    __weak IBOutlet UIView *_inputBackView;
    __weak IBOutlet UITextField *_txtInput;
    __weak IBOutlet UIButton *_btnSave;
}

@end

@implementation EditDataController

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
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self loadNav];
    [self loadViews];
}
#pragma - mark 加载界面

- (void)loadNav {
    if (_isEditName) {
        [PMCommon setNavigationTitle:self withTitle:@"姓名填写"];
    } else {
        [PMCommon setNavigationTitle:self withTitle:@"绑定身份证"];
    }
}

- (void)loadViews {
    _inputBackView.layer.borderColor = RGBA(0x66, 0x66, 0x66, 1).CGColor;
    _btnSave.layer.cornerRadius = 3;
    _btnSave.layer.masksToBounds = YES;
    if (_isEditName) {
        _lblTip.text = @"请务必确保姓名准确，否则，无法正常使用!";
        _txtInput.placeholder = @"真实姓名";
        [_btnSave setTitle:@"确定" forState:UIControlStateNormal];
    } else {
        _lblTip.text = @"请务必确保身份证号准确，否则，无法正常使用!";
        _txtInput.placeholder = @"身份证号";
        [_btnSave setTitle:@"绑定" forState:UIControlStateNormal];
    }
}

- (void)blindName {
    EditViewModel *viewModel = [[EditViewModel alloc] init];
    [viewModel updateNameToServer:_txtInput.text controller:self callBacl:^(BOOL success) {
        if (success) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

- (void)blindLicense {
    EditViewModel *viewModel = [[EditViewModel alloc] init];
    [viewModel updateLicenseToServer:_txtInput.text controller:self callBacl:^(BOOL success) {
        if (success) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

- (IBAction)clickSave:(id)sender {
    [self.view endEditing:YES];
    if (_isEditName) {
        [self blindName];
    } else {
        [self blindLicense];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
