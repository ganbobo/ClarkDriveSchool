//
//  SchoolCommentController.m
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/10.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import "SchoolCommentController.h"

#import <UIImageView+AFNetworking.h>
#import "RatingBar.h"
#import "MySchoolViewModel.h"
@interface SchoolCommentController ()<UITextViewDelegate, RatingBarDelegate, UITextViewDelegate> {
    UIImageView *_imgSchool;
    UILabel *_lblSchoolName;
    
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

@implementation SchoolCommentController

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
    [PMCommon setNavigationTitle:self withTitle:@"驾校评价"];
}

- (void)loadViews {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - NavBarHeight - StatusBarHeight)];
    _scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_scrollView];
    
    UIView *lineTop = [[UIView alloc] initWithFrame:CGRectMake(0, 10, ScreenWidth, 0.5)];
    lineTop.backgroundColor = RGBA(0xee, 0xee, 0xee, 1);
    [_scrollView addSubview:lineTop];
    
    _imgSchool = [[UIImageView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(lineTop.frame) + 5, 80, 80)];
    [_imgSchool setImageWithURL:getImageUrl(_mySchoolInfo.resourseUrl) placeholderImage:[UIImage imageNamed:@"downlaod_picture_fail"]];
    _imgSchool.layer.borderColor = RGBA(0xee, 0xee, 0xee, 1).CGColor;
    _imgSchool.layer.borderWidth = 0.5;
    [_scrollView addSubview:_imgSchool];
    
    _lblSchoolName = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imgSchool.frame) + 10, 10, ScreenWidth - CGRectGetMaxX(_imgSchool.frame) - 20, 30)];
    _lblSchoolName.font = [UIFont systemFontOfSize:15];
    _lblSchoolName.textColor = RGBA(0x32, 0x32, 0x32, 1);
    _lblSchoolName.text = _mySchoolInfo.drivingName;
    [_scrollView addSubview:_lblSchoolName];
    
    UILabel *lblAdd = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imgSchool.frame) + 5, CGRectGetMaxY(_lblSchoolName.frame) + 10, ScreenWidth - CGRectGetMaxX(_imgSchool.frame) - 20, 40)];
    lblAdd.font = [UIFont systemFontOfSize:14];
    lblAdd.numberOfLines = 0;
    lblAdd.textColor = RGBA(0x69, 0x69, 0x69, 1);
    lblAdd.text = _mySchoolInfo.drivingAddr;
    [_scrollView addSubview:lblAdd];
    
    UIView *lineMid = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_imgSchool.frame) + 10, ScreenWidth, 0.5)];
    lineMid.backgroundColor = RGBA(0xee, 0xee, 0xee, 1);
    [_scrollView addSubview:lineMid];
    
    UILabel *lblTotal = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(lineMid.frame) + 10, 65, 30)];
    lblTotal.font = [UIFont systemFontOfSize:15];
    lblTotal.textColor = RGBA(0x32, 0x32, 0x32, 1);
    lblTotal.text = @"总体评价";
    [_scrollView addSubview:lblTotal];
    
    _starTotalView = [[RatingBar alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lblTotal.frame) + 10, lblTotal.origin.y, 180, 30)];
//    _starTotalView.enable = NO;
    [_scrollView addSubview:_starTotalView];
    
    UIView *lineMid1 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lblTotal.frame) + 10, ScreenWidth, 0.5)];
    lineMid1.backgroundColor = RGBA(0xee, 0xee, 0xee, 1);
    [_scrollView addSubview:lineMid1];
    
    UILabel *lblTotal0 = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(lineMid1.frame) + 10, 65, 30)];
    lblTotal0.font = [UIFont systemFontOfSize:15];
    lblTotal0.textColor = RGBA(0x32, 0x32, 0x32, 1);
    lblTotal0.text = @"驾校环境";
    [_scrollView addSubview:lblTotal0];
    
    _starEnView = [[RatingBar alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lblTotal0.frame) + 10, lblTotal0.origin.y, 150, 30)];
    [_scrollView addSubview:_starEnView];

    UILabel *lblTotal1 = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(lblTotal0.frame) + 10, 65, 30)];
    lblTotal1.font = [UIFont systemFontOfSize:15];
    lblTotal1.textColor = RGBA(0x32, 0x32, 0x32, 1);
    lblTotal1.text = @"前台服务";
    [_scrollView addSubview:lblTotal1];
    _starQiantaiView = [[RatingBar alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lblTotal1.frame) + 10, lblTotal1.origin.y, 150, 30)];
    [_scrollView addSubview:_starQiantaiView];

    UILabel *lblTotal2 = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(lblTotal1.frame) + 10, 65, 30)];
    lblTotal2.font = [UIFont systemFontOfSize:15];
    lblTotal2.textColor = RGBA(0x32, 0x32, 0x32, 1);
    lblTotal2.text = @"教练服务";
    [_scrollView addSubview:lblTotal2];
    
    _starCoachView = [[RatingBar alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lblTotal2.frame) + 10, lblTotal2.origin.y, 150, 30)];
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
    
    _lblPlaceholder = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, _textView.width - 10, 40)];
    _lblPlaceholder.font = [UIFont systemFontOfSize:14];
    _lblPlaceholder.numberOfLines = 0;
    _lblPlaceholder.textColor = RGBA(0x99, 0x99, 0x99, 1);
    _lblPlaceholder.text = @"为提高服务质量，请您认真填写评价啊，谢谢！";
    if (IPHONE6 || IPHONE6PLUS) {
        _lblPlaceholder.height = 20;
    }
    [_textView addSubview:_lblPlaceholder];
    
    UIView *lineMid3 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_textView.frame) + 10, ScreenWidth, 0.5)];
    lineMid3.backgroundColor = RGBA(0xee, 0xee, 0xee, 1);
    [_scrollView addSubview:lineMid3];
    
    _btnHiddenName = [[UIButton alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(lineMid3.frame) + 5, 90, 25)];
    [_btnHiddenName setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_btnHiddenName setTitleColor:RGBA(0x11, 0xcd, 0x6e, 1) forState:UIControlStateSelected];
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
    [_btnSubmit addTarget:self action:@selector(clickSubmit) forControlEvents:UIControlEventTouchUpInside];
    _btnSubmit.backgroundColor = [UIColor colorWithRed:0.165 green:0.690 blue:0.252 alpha:1.000];
    [_scrollView addSubview:_btnSubmit];
    
    _starCoachView.delegate = self;
    _starEnView.delegate = self;
    _starQiantaiView.delegate = self;
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
    [self sendComment];
}

- (void)sendComment {
    
    MySchoolViewModel *model = [[MySchoolViewModel alloc] init];
    
    [model sendCommentToServer:_mySchoolInfo.drivingId drivingScole:_starTotalView.starNumber enScole:_starEnView.starNumber prosceScole:_starQiantaiView.starNumber drivingTrainer:_starCoachView.starNumber driving_comment:_textView.text isShowName:_btnHiddenName.selected controller:self callBack:^(BOOL success) {
        if (success) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

#pragma - mark UITextViewDelegate 代理

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if (IPHONE5) {
        [UIView animateWithDuration:0.25 animations:^{
            [_scrollView setOrigin:CGPointMake(0, -50)];
        }];
    }
    
    if (!IPHONE6 && !IPHONE6PLUS && !IPHONE5) {
        [UIView animateWithDuration:0.25 animations:^{
            [_scrollView setOrigin:CGPointMake(0, -136)];
        }];
    }
    
    if (IPHONE6) {
        [UIView animateWithDuration:0.25 animations:^{
            [_scrollView setOrigin:CGPointMake(0, -20)];
        }];
    }
    
    
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    if (!IPHONE6PLUS) {
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

#pragma - mark RatingBarDelegate 

- (void)didChangeScole {
//    NSInteger scole = (_starEnView.starNumber + _starCoachView.starNumber + _starQiantaiView.starNumber) / 3;
//    _starTotalView.starNumber = scole;
}

@end
