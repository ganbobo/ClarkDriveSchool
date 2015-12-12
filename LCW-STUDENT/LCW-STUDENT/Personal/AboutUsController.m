//
//  AboutUsController.m
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/12/8.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import "AboutUsController.h"

@interface AboutUsController () {
    UITextView *_txtView;
}

@end

@implementation AboutUsController

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
    self.automaticallyAdjustsScrollViewInsets = NO;
    [PMCommon setNavigationTitle:self withTitle:@"关于网上学车"];
    
    _txtView = [[UITextView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)];
    _txtView.editable = NO;
    _txtView.font = [UIFont systemFontOfSize:14];
    _txtView.textColor = RGBA(0x32, 0x32, 0x32, 1);
    _txtView.text = @"  网上学车是由北京零从科技有限公司开发的一款学车软件。旨在通过网上约车、网上约考、网上选择驾校、教练、网上评价教练等互联网方式，解决传统驾考的吃拿卡要，教学态度差，学员学车时间利用率低等问题，最终创造一个轻松愉快，文明和谐的学车环境。";
    _txtView.userInteractionEnabled = NO;
    [self.view addSubview:_txtView];
}

@end
