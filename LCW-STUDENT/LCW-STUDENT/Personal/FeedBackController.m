//
//  FeedBackController.m
//  LCW-STUDENT
//
//  Created by St.Pons.Mr.G on 15/9/4.
//  Copyright (c) 2015年 Clark. All rights reserved.
//

#import "FeedBackController.h"

#import "FeedBackViewModel.h"

@interface FeedBackController ()<UITextViewDelegate> {
    UIView *_inputBackView;
    UITextView *_txtContent;
    UILabel *_lblPlaceholder;
    UIButton *_btnSubmit, *_btnService;
    
    // 数据
    FeedBackViewModel *_feedbackViewModel;
}

@end

@implementation FeedBackController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNav];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTintColor:RGBA(0x11, 0xcd, 0x6e, 1)];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:RGBA(0x40, 0x40, 0x40, 1)] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

-(UIImage *) createImageWithColor: (UIColor *) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView {
    [super loadView];
    _feedbackViewModel = [[FeedBackViewModel alloc] init];
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
    
    _txtContent = [[UITextView alloc] init];
    [_txtContent setTranslatesAutoresizingMaskIntoConstraints:NO];
    _txtContent.delegate = self;
    [_inputBackView addSubview:_txtContent];
    
    [_inputBackView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[T]-5-|" options:0 metrics:nil views:@{@"T": _txtContent}]];
    [_inputBackView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[T]-5-|" options:0 metrics:nil views:@{@"T": _txtContent}]];
    
    _lblPlaceholder = [[UILabel alloc] init];
    [_lblPlaceholder setTranslatesAutoresizingMaskIntoConstraints:NO];
    _lblPlaceholder.textColor = RGBA(0x99, 0x99, 0x99, 1);
    _lblPlaceholder.text = @"欢迎您提供宝贵建议与意见";
    _lblPlaceholder.textAlignment = NSTextAlignmentCenter;
    _lblPlaceholder.font = [UIFont systemFontOfSize:14];
    [_inputBackView addSubview:_lblPlaceholder];
    _lblPlaceholder.userInteractionEnabled = NO;
    
    [_inputBackView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[P]-5-|" options:0 metrics:nil views:@{@"P": _lblPlaceholder}]];
    [_inputBackView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[P]-5-|" options:0 metrics:nil views:@{@"P": _lblPlaceholder}]];

    _btnSubmit = [UIButton new];
    [_btnSubmit setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_btnSubmit setBackgroundImage:[UIImage imageNamed:@"btn_common"] forState:UIControlStateNormal];
    [_btnSubmit setTitleColor:RGBA(0xff, 0xff, 0xff, 1) forState:UIControlStateNormal];
    [_btnSubmit setTitle:@"提交" forState:UIControlStateNormal];
    _btnSubmit.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    _btnSubmit.layer.cornerRadius = 2;
    _btnSubmit.layer.masksToBounds = YES;
    [_btnSubmit addTarget:self action:@selector(clickSubmit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnSubmit];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[S]-10-|" options:0 metrics:nil views:@{@"S": _btnSubmit}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[I]-20-[S(40)]" options:0 metrics:nil views:@{@"I": _inputBackView, @"S": _btnSubmit}]];
    
    _btnService = [UIButton new];
    [_btnService setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_btnService setTitleColor:[UIColor colorWithRed:0.180 green:0.639 blue:0.357 alpha:1.000] forState:UIControlStateNormal];
    [_btnService setTitle:@"投诉电话" forState:UIControlStateNormal];
    _btnService.titleLabel.font = [UIFont systemFontOfSize:15];
    _btnService.layer.cornerRadius = 2;
    _btnService.layer.borderColor = [UIColor colorWithRed:0.180 green:0.639 blue:0.357 alpha:1.000].CGColor;
    _btnService.layer.borderWidth = 0.5;
    _btnService.layer.masksToBounds = YES;
    [self.view addSubview:_btnService];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-90-[SV]-90-|" options:0 metrics:nil views:@{@"SV": _btnService}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[SV(35)]-40-|" options:0 metrics:nil views:@{@"SV": _btnService, @"S": _btnSubmit}]];
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

- (void)clickSubmit {
    [self.view endEditing:YES];
    __weak typeof(self) safeSelf = self;
    
    NSString *txt = _txtContent.text;
    if (txt.length <= 0) {
        [self showMiddleToastWithContent:@"请输入您要反馈的意见"];
        return;
    }
    [_feedbackViewModel sendFeedbackToServerController:self msg:_txtContent.text callBack:^(BOOL success) {
        if (success) {
            [safeSelf hiddenWaitView];
            [[[UIAlertView alloc] initWithTitle:@"提示" message:@"您的意见反馈已经成功，感谢您提出的宝贵意见" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil] show];;
        }
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma - mark UITextViewDelegate 代理

- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length > 0) {
        _lblPlaceholder.hidden = YES;
    } else {
        _lblPlaceholder.hidden = NO;
    }
}

#pragma - mark 键盘

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
