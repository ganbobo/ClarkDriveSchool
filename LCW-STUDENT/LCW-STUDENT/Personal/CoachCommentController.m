//
//  CoachCommentController.m
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/10.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import "CoachCommentController.h"
#import "RatingBar.h"
#import "MyCoachViewModel.h"

@interface CoachCommentController ()<UITextViewDelegate, RatingBarDelegate, UITextViewDelegate> {
    UIScrollView *_scrollView;
    
    RatingBar *_starTotalView;// 环境
    RatingBar *_starEnView;// 环境
    RatingBar *_starQiantaiView;// 前台服务
    RatingBar *_starCoachView;// 教练服务
    
    UITextView *_textView;
    
    UILabel *_lblPlaceholder;
    
    UIButton *_btnHiddenName;
    
    UIButton *_btnSubmit;
}

@end

@implementation CoachCommentController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView {
    [super loadView];
    [self loadViews];
    [PMCommon setNavigationTitle:self withTitle:@"教练评价"];
}

- (void)loadViews {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - NavBarHeight - StatusBarHeight)];
    _scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_scrollView];
    
    UIView *lineMid = [[UIView alloc] initWithFrame:CGRectMake(0, 10, ScreenWidth, 0.5)];
    lineMid.backgroundColor = RGBA(0xee, 0xee, 0xee, 1);
    [_scrollView addSubview:lineMid];
    
    UILabel *lblTotal = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(lineMid.frame) + 10, 65, 30)];
    lblTotal.font = [UIFont systemFontOfSize:15];
    lblTotal.textColor = RGBA(0x32, 0x32, 0x32, 1);
    lblTotal.text = @"总体评价";
    [_scrollView addSubview:lblTotal];
    
    _starTotalView = [[RatingBar alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lblTotal.frame) + 10, lblTotal.origin.y, 180, 30)];
    _starTotalView.enable = NO;
    [_scrollView addSubview:_starTotalView];
    
    UIView *lineMid1 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lblTotal.frame) + 10, ScreenWidth, 0.5)];
    lineMid1.backgroundColor = RGBA(0xee, 0xee, 0xee, 1);
    [_scrollView addSubview:lineMid1];
    
    UILabel *lblTotal0 = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(lineMid1.frame) + 10, 65, 30)];
    lblTotal0.font = [UIFont systemFontOfSize:15];
    lblTotal0.textColor = RGBA(0x32, 0x32, 0x32, 1);
    lblTotal0.text = @"教学态度";
    [_scrollView addSubview:lblTotal0];
    
    _starEnView = [[RatingBar alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lblTotal0.frame) + 10, lblTotal0.origin.y, 150, 30)];
    _starEnView.delegate = self;
    [_scrollView addSubview:_starEnView];
    
    UILabel *lblTotal1 = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(lblTotal0.frame) + 10, 65, 30)];
    lblTotal1.font = [UIFont systemFontOfSize:15];
    lblTotal1.textColor = RGBA(0x32, 0x32, 0x32, 1);
    lblTotal1.text = @"教学能力";
    [_scrollView addSubview:lblTotal1];
    _starQiantaiView = [[RatingBar alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lblTotal1.frame) + 10, lblTotal1.origin.y, 150, 30)];
    _starQiantaiView.delegate = self;
    [_scrollView addSubview:_starQiantaiView];
    
    UILabel *lblTotal2 = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(lblTotal1.frame) + 10, 65, 30)];
    lblTotal2.font = [UIFont systemFontOfSize:15];
    lblTotal2.textColor = RGBA(0x32, 0x32, 0x32, 1);
    lblTotal2.text = @"车内环境";
    [_scrollView addSubview:lblTotal2];
    
    _starCoachView = [[RatingBar alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lblTotal2.frame) + 10, lblTotal2.origin.y, 150, 30)];
    _starCoachView.delegate = self;
    [_scrollView addSubview:_starCoachView];
    
    UIView *lineMid2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_starCoachView.frame) + 10, ScreenWidth, 0.5)];
    lineMid2.backgroundColor = RGBA(0xee, 0xee, 0xee, 1);
    [_scrollView addSubview:lineMid2];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(lineMid2.frame) + 5, ScreenWidth - 20, 70)];
    _textView.font = [UIFont systemFontOfSize:14];
    _textView.textColor = RGBA(0x32, 0x32, 0x32, 1);
    _textView.delegate  = self;
    _textView.backgroundColor = [UIColor clearColor];
    [_scrollView addSubview:_textView];
    
    _lblPlaceholder = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, _textView.width - 10, 20)];
    _lblPlaceholder.font = [UIFont systemFontOfSize:14];
    _lblPlaceholder.numberOfLines = 0;
    _lblPlaceholder.textColor = RGBA(0x99, 0x99, 0x99, 1);
    _lblPlaceholder.text = @"为提供更好的服务，请认真评价，谢谢！";
    [_textView addSubview:_lblPlaceholder];
    
    UIView *lineMid3 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_textView.frame) + 10, ScreenWidth, 0.5)];
    lineMid3.backgroundColor = RGBA(0xee, 0xee, 0xee, 1);
    [_scrollView addSubview:lineMid3];
    
    _btnHiddenName = [[UIButton alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(lineMid3.frame) + 10, 90, 25)];
    [_btnHiddenName setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_btnHiddenName setTitleColor:kGreenColor forState:UIControlStateSelected];
    _btnHiddenName.titleLabel.font = [UIFont systemFontOfSize:14];
    [_btnHiddenName setImage:[UIImage imageNamed:@"btn_check"] forState:UIControlStateSelected];
    [_btnHiddenName setImage:[UIImage imageNamed:@"btn_uncheck"] forState:UIControlStateNormal];
    [_btnHiddenName setTitle:@" 匿名评价" forState:UIControlStateNormal];
    [_btnHiddenName addTarget:self action:@selector(clickHiddenName) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_btnHiddenName];
    
    _btnSubmit = [UIButton buttonWithType:UIButtonTypeSystem];
    _btnSubmit.frame = CGRectMake(20, CGRectGetMaxY(_btnHiddenName.frame) + 20, ScreenWidth - 40, 40);
    _btnSubmit.layer.cornerRadius = 5;
    _btnSubmit.layer.masksToBounds = YES;
    [_btnSubmit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btnSubmit setTitle:@"提交" forState:UIControlStateNormal];
    _btnSubmit.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    _btnSubmit.backgroundColor = [UIColor colorWithRed:0.165 green:0.690 blue:0.252 alpha:1.000];
    [_btnSubmit addTarget:self action:@selector(clickSubmit) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_btnSubmit];
}

- (void)textViewDidChange:(UITextView *)textView {
    _lblPlaceholder.hidden = (textView.text.length > 0);
}

- (void)clickHiddenName {
    [self.view endEditing:YES];
    if (_btnHiddenName.selected) {
        _btnHiddenName.selected = NO;
    } else {
        _btnHiddenName.selected = YES;
    }
}

- (void)clickSubmit {
    [self.view endEditing:YES];

    MyCoachViewModel *viewModel = [[MyCoachViewModel alloc] init];
    [viewModel sendCoachCommentToServer:_coachInfo.trainerId scole:_starCoachView.starNumber attitude:_starEnView.starNumber ablility:_starQiantaiView.starNumber environment:_starCoachView.starNumber comment:_textView.text isShowName:_btnHiddenName.selected controller:self callBack:^(BOOL success) {
        if (success) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

#pragma - mark RatingBarDelegate

- (void)didChangeScole {
    NSInteger scole = (_starEnView.starNumber + _starCoachView.starNumber + _starQiantaiView.starNumber) / 3;
    _starTotalView.starNumber = scole;
}

#pragma - mark UITextViewDelegate 代理

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if (IPHONE5) {
        [UIView animateWithDuration:0.25 animations:^{
            [_scrollView setOrigin:CGPointMake(0, 0)];
        }];
    }
    
    if (!IPHONE6 && !IPHONE6PLUS && !IPHONE5) {
        [UIView animateWithDuration:0.25 animations:^{
            [_scrollView setOrigin:CGPointMake(0, -86)];
        }];
    }
    
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    if (!IPHONE6 && !IPHONE6PLUS) {
        [UIView animateWithDuration:0.25 animations:^{
            [_scrollView setOrigin:CGPointMake(0, 64)];
        }];
    }
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

@end
